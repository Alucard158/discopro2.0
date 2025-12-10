# =======================================================
# IMPORTS GENERALES
# =======================================================
from django import forms
from django.db.models import Count, Q, Subquery, OuterRef
from django.db.models.functions import Length
from django.views import View
from django.views.generic import (
    TemplateView, ListView, DetailView,
    CreateView, UpdateView, DeleteView
)
from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse_lazy
from django.http import HttpRequest, JsonResponse
from django.utils import timezone
from datetime import timedelta
from collections import defaultdict

# Mensajes
from django.contrib import messages
from django.contrib.messages.views import SuccessMessageMixin

# Autenticación
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin 
from django.contrib.auth.forms import SetPasswordForm

from django.urls import reverse
from django.urls import reverse_lazy
from django.shortcuts import get_object_or_404

# Utils
from app1Discopro.utils import render_to_pdf

# Formularios
from .forms import (
    CustomLoginForm, UsuarioForm, UsuarioUpdateForm,
    FarmaciaForm, MotoristaForm, MotoForm,
    AsignacionFarmaciaForm, AsignacionMotoForm,
    DocumentacionMotoForm, MantenimientoForm,
    ContactoEmergenciaForm, MovimientoForm
)

# Modelos
from .models import (
    Usuario, Rol, Farmacia, Motorista, Moto,
    Provincia, Comuna,
    AsignacionFarmacia, AsignacionMoto,
    DocumentacionMoto, Mantenimiento,
    ContactoEmergencia, TipoMovimiento, Movimiento
)


# =======================================================
# LOGIN / LOGOUT
# =======================================================

def login_view(request):
    if request.user.is_authenticated:
        return redirect('index')

    if request.method == 'POST':
        form = CustomLoginForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            messages.success(request, f"¡Bienvenido, {user.first_name}!")
            next_url = request.POST.get('next') or request.GET.get('next')
            return redirect(next_url or 'index')
        else:
            messages.error(request, "Usuario o contraseña incorrectos.")
    else:
        form = CustomLoginForm()

    return render(request, 'templatesApp1Discopro/login.html', {'form': form})


def logout_view(request):
    logout(request)
    messages.success(request, 'Has cerrado sesión exitosamente.')
    return redirect('login')

# =======================================================
# DASHBOARD
# =======================================================

@login_required
def index(request):
    context = {
        'total_farmacias': Farmacia.objects.count(),
        'total_motoristas': Motorista.objects.count(),
        'total_motos': Moto.objects.count(),
        'total_usuarios': Usuario.objects.count(),
        'total_movimientos': Movimiento.objects.filter(movimiento_padre__isnull=True).count(),
    }
    return render(request, 'templatesApp1Discopro/dashboard.html', context)

# =======================================================
# REPORTES / PDF
# =======================================================

class ReporteMovimientosView(LoginRequiredMixin, TemplateView):
    template_name = 'templatesApp1Discopro/reporte_general.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        ahora = timezone.localtime()

        inicio_dia = ahora.replace(hour=0, minute=0, second=0, microsecond=0)
        inicio_mes = ahora.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
        inicio_anio = ahora.replace(month=1, day=1, hour=0, minute=0, second=0, microsecond=0)

        # Diario
        qs_hoy = Movimiento.objects.filter(fecha_movimiento__date=ahora.date())
        context['total_hoy'] = qs_hoy.count()
        context['estados_hoy'] = qs_hoy.values('estado').annotate(total=Count('estado'))

        # Mensual
        qs_mes = Movimiento.objects.filter(fecha_movimiento__gte=inicio_mes)
        context['total_mes'] = qs_mes.count()
        context['tipos_mes'] = qs_mes.values('tipo_movimiento__nombre').annotate(total=Count('tipo_movimiento'))

        # Anual
        qs_anio = Movimiento.objects.filter(
            fecha_movimiento__gte=inicio_anio,
            estado='completado'
        )

        context['total_anio'] = qs_anio.count()

        datos_agrupados = defaultdict(int)
        for mov in qs_anio:
            fecha = timezone.localtime(mov.fecha_movimiento)
            mes_key = fecha.replace(day=1)
            datos_agrupados[mes_key] += 1

        context['evolucion_anual'] = sorted(
            [{'mes': k, 'total': v} for k, v in datos_agrupados.items()],
            key=lambda x: x['mes']
        )

        return context


class ExportarReportePDFView(LoginRequiredMixin, View):
    def get(self, request):
        tipo = request.GET.get('tipo', 'diario')
        ahora = timezone.localtime()

        inicio_dia = ahora.replace(hour=0, minute=0, second=0, microsecond=0)
        inicio_mes = ahora.replace(day=1)
        inicio_anio = ahora.replace(month=1, day=1)

        data = {}
        titulo = ''
        movimientos = Movimiento.objects.none()

        # ---- Diario
        if tipo == 'diario':
            titulo = f"Reporte Diario ({ahora.strftime('%d-%m-%Y')})"
            movimientos = Movimiento.objects.filter(fecha_movimiento__date=ahora.date())
            data['detalles'] = movimientos.values('estado').annotate(total=Count('estado'))
            data['columnas'] = ['Estado', 'Cantidad']

        # ---- Mensual
        elif tipo == 'mensual':
            titulo = f"Reporte Mensual ({ahora.strftime('%m-%Y')})"
            movimientos = Movimiento.objects.filter(fecha_movimiento__gte=inicio_mes)
            data['detalles'] = movimientos.values('tipo_movimiento__nombre').annotate(total=Count('tipo_movimiento'))
            data['columnas'] = ['Tipo Movimiento', 'Cantidad']

        # ---- Anual
        elif tipo == 'anual':
            titulo = f"Reporte Anual ({ahora.year})"
            movimientos = Movimiento.objects.filter(fecha_movimiento__gte=inicio_anio)
            agrupados = defaultdict(int)

            for mov in movimientos:
                if mov.estado == 'completado':
                    mes = timezone.localtime(mov.fecha_movimiento).strftime('%B')
                    agrupados[mes] += 1

            data['detalles'] = [{'nombre': k, 'total': v} for k, v in agrupados.items()]
            data['columnas'] = ['Mes', 'Completados']

        movimientos_full = movimientos.select_related(
            'tipo_movimiento', 'motorista_asignado', 'usuario_responsable'
        )

        context = {
            'titulo': titulo,
            'fecha_impresion': ahora,
            'usuario': request.user,
            'data': data,
            'total_general': movimientos.count(),
            'movimientos_completados': movimientos_full.filter(estado='completado'),
            'movimientos_pendientes': movimientos_full.filter(estado='pendiente'),
            'movimientos_anulados': movimientos_full.filter(estado='anulado'),
        }

        return render_to_pdf('templatesApp1Discopro/reporte_pdf.html', context)

# =======================================================
# CRUD USUARIOS
# =======================================================

class UsuarioListView(LoginRequiredMixin, ListView):
    model = Usuario
    template_name = 'templatesApp1Discopro/usuario_list.html'
    context_object_name = 'usuarios'
    paginate_by = 20

    def get_queryset(self):
        qs = super().get_queryset().select_related('rol')
        q = self.request.GET.get('q')
        if q:
            qs = qs.filter(
                Q(first_name__icontains=q) |
                Q(last_name__icontains=q) |
                Q(username__icontains=q) |
                Q(email__icontains=q) |
                Q(rut__icontains=q) |
                Q(rol__nombreRol__icontains=q)
            ).distinct()
        return qs


class UsuarioCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = Usuario
    form_class = UsuarioForm
    template_name = 'templatesApp1Discopro/usuario_form.html'
    success_url = reverse_lazy('usuario_lista')
    success_message = "Usuario creado exitosamente."


class UsuarioUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Usuario
    form_class = UsuarioUpdateForm
    template_name = 'templatesApp1Discopro/usuario_form.html'
    success_url = reverse_lazy('usuario_lista')
    success_message = "Usuario actualizado."


class UsuarioDeleteView(LoginRequiredMixin, DeleteView):
    model = Usuario
    template_name = "templatesApp1Discopro/usuario_eliminar.html"
    success_url = reverse_lazy("usuarios_listar")

    def dispatch(self, request, *args, **kwargs):
        usuario = self.get_object()

        # Evita eliminar al superuser
        if usuario.is_superuser:
            messages.error(request, "⚠️ No se puede eliminar el usuario superadministrador.")
            return redirect("usuarios_listar")

        return super().dispatch(request, *args, **kwargs)

# =======================================================
# PERFIL / CONFIGURACIÓN
# =======================================================

class MiCuentaView(LoginRequiredMixin, DetailView):
    model = Usuario
    template_name = 'templatesApp1Discopro/mi_cuenta.html'
    context_object_name = 'usuario'

    def get_object(self):
        return self.request.user


class MiCuentaUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Usuario
    form_class = UsuarioUpdateForm
    template_name = 'templatesApp1Discopro/mi_cuenta_form.html'
    success_url = reverse_lazy('mi_cuenta')
    success_message = "Tu perfil ha sido actualizado."

    def get_object(self):
        return self.request.user


class AdminPasswordResetView(LoginRequiredMixin, View):
    template_name = 'templatesApp1Discopro/admin_password_reset.html'

    def get(self, request, pk):
        usuario = get_object_or_404(Usuario, pk=pk)
        form = SetPasswordForm(user=usuario)
        return render(request, self.template_name, {'form': form, 'usuario': usuario})

    def post(self, request, pk):
        usuario = get_object_or_404(Usuario, pk=pk)
        form = SetPasswordForm(user=usuario, data=request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, f"Contraseña actualizada para {usuario.username}")
            return redirect('usuario_lista')
        return render(request, self.template_name, {'form': form, 'usuario': usuario})

# =======================================================
# CRUD FARMACIAS
# =======================================================

class FarmaciaListView(LoginRequiredMixin, ListView):
    model = Farmacia
    template_name = 'templatesApp1Discopro/farmacia_list.html'
    context_object_name = 'farmacias'
    paginate_by = 20

    def get_queryset(self):
        qs = super().get_queryset().select_related(
            'comuna__provincia__region'
        )

        # ----------- BUSCADOR -----------
        q = self.request.GET.get('q')
        if q:
            qs = qs.filter(
                Q(nombre__icontains=q) |
                Q(direccion__icontains=q) |
                Q(comuna__nombreComuna__icontains=q) |
                Q(comuna__provincia__nombreProvincia__icontains=q) |
                Q(comuna__provincia__region__nombreRegion__icontains=q)
            ).distinct()

        # ----------- ORDENAMIENTO -----------
        sort = self.request.GET.get('sort')
        if sort:

            # Campos permitidos para evitar errores
            allowed = {
                "nombre": "nombre",
                "direccion": "direccion",
                "comuna": "comuna__nombreComuna",
                "provincia": "comuna__provincia__nombreProvincia",
                "region": "comuna__provincia__region__nombreRegion",
            }

            if sort in allowed:
                qs = qs.order_by(allowed[sort])

        return qs

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx["q"] = self.request.GET.get("q", "")
        ctx["sort"] = self.request.GET.get("sort", "")
        return ctx

class FarmaciaCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = Farmacia
    form_class = FarmaciaForm
    template_name = 'templatesApp1Discopro/farmacia_form.html'
    success_url = reverse_lazy('farmacia_lista')
    success_message = "Farmacia creada correctamente."


class FarmaciaUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Farmacia
    form_class = FarmaciaForm
    template_name = 'templatesApp1Discopro/farmacia_form.html'
    success_url = reverse_lazy('farmacia_lista')
    success_message = "Farmacia actualizada correctamente."


class FarmaciaDeleteView(LoginRequiredMixin, DeleteView):
    model = Farmacia
    template_name = 'templatesApp1Discopro/confirmar_eliminar.html'
    success_url = reverse_lazy('farmacia_lista')

    def form_valid(self, form):
        messages.success(self.request, "Farmacia eliminada.")
        return super().form_valid(form)


class FarmaciaDetailView(LoginRequiredMixin, DetailView):
    model = Farmacia
    template_name = 'templatesApp1Discopro/farmacia_detail.html'
    context_object_name = 'farmacia'

# =======================================================
# CRUD MOTORISTAS
# =======================================================

class MotoristaListView(LoginRequiredMixin, ListView):
    model = Motorista
    template_name = 'templatesApp1Discopro/motorista_list.html'
    context_object_name = 'motoristas'
    paginate_by = 20

    def get_queryset(self):
        qs = super().get_queryset().select_related('comuna__provincia__region')
        q = self.request.GET.get('q')

        if not q:
            return qs

        q = q.lower().strip()

        # 🔍 Filtro especial para estado
        if q in ["activo", "activos"]:
            return qs.filter(estado="activo")

        if q in ["inactivo", "inactivos"]:
            return qs.filter(estado="inactivo")

        if q in ["licencia", "con licencia", "licencia medica", "licencia médica"]:
            return qs.filter(estado="licencia")

        # 🔍 Búsqueda general
        return qs.filter(
            Q(nombres__icontains=q) |
            Q(apellido_paterno__icontains=q) |
            Q(apellido_materno__icontains=q) |
            Q(rut__icontains=q) |
            Q(telefono__icontains=q) |
            Q(correo__icontains=q) |
            Q(comuna__nombreComuna__icontains=q) |
            Q(comuna__provincia__nombreProvincia__icontains=q) |
            Q(comuna__provincia__region__nombreRegion__icontains=q)
        ).distinct()

class MotoristaCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = Motorista
    form_class = MotoristaForm
    template_name = 'templatesApp1Discopro/motorista_form.html'
    success_url = reverse_lazy('motorista_lista')
    success_message = "Motorista creado."


class MotoristaUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Motorista
    form_class = MotoristaForm
    template_name = 'templatesApp1Discopro/motorista_form.html'
    success_url = reverse_lazy('motorista_lista')
    success_message = "Motorista actualizado."


class MotoristaDeleteView(LoginRequiredMixin, DeleteView):
    model = Motorista
    template_name = 'templatesApp1Discopro/confirmar_eliminar.html'
    success_url = reverse_lazy('motorista_lista')

    def form_valid(self, form):
        messages.success(self.request, "Motorista eliminado.")
        return super().form_valid(form)


class MotoristaDetailView(LoginRequiredMixin, DetailView):
    model = Motorista
    template_name = 'templatesApp1Discopro/motorista_detail.html'
    context_object_name = 'motorista'

    def get_context_data(self, **kwargs):
        c = super().get_context_data(**kwargs)
        moto = self.get_object()
        c['asignaciones_farmacia'] = AsignacionFarmacia.objects.filter(
            motorista=moto).select_related('farmacia')
        c['asignaciones_moto'] = AsignacionMoto.objects.filter(
            motorista=moto).select_related('moto')
        c['contactos'] = moto.contactos_emergencia.all()
        return c

# =======================================================
# CRUD MOTOS
# =======================================================

class MotoListView(LoginRequiredMixin, ListView):
    model = Moto
    template_name = 'templatesApp1Discopro/moto_list.html'
    context_object_name = 'motos'
    paginate_by = 20

    def get_queryset(self):
        q = self.request.GET.get('q', '').strip()
        qs = Moto.objects.all()

        if q:
            qs = qs.filter(
                Q(patente__icontains=q) |
                Q(marca__icontains=q) |
                Q(modelo__icontains=q) |
                Q(anio__icontains=q) |
                Q(propietario__icontains=q) |
                Q(asignacionmoto__motorista__nombres__icontains=q) |
                Q(asignacionmoto__motorista__apellido_paterno__icontains=q)
            ).distinct()

        return qs

class MotoCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = Moto
    form_class = MotoForm
    template_name = 'templatesApp1Discopro/moto_form.html'
    success_url = reverse_lazy('moto_lista')
    success_message = "Moto registrada."


class MotoUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Moto
    form_class = MotoForm
    template_name = 'templatesApp1Discopro/moto_form.html'
    success_url = reverse_lazy('moto_lista')
    success_message = "Moto actualizada."


class MotoDeleteView(LoginRequiredMixin, DeleteView):
    model = Moto
    template_name = 'templatesApp1Discopro/confirmar_eliminar.html'
    success_url = reverse_lazy('moto_lista')

    def form_valid(self, form):
        messages.success(self.request, "Moto eliminada.")
        return super().form_valid(form)


class MotoDetailView(LoginRequiredMixin, DetailView):
    model = Moto
    template_name = 'templatesApp1Discopro/moto_detail.html'
    context_object_name = 'moto'

# =======================================================
# ASIGNACIONES
# =======================================================

class AsignacionFarmaciaCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = AsignacionFarmacia
    form_class = AsignacionFarmaciaForm
    template_name = 'templatesApp1Discopro/asignacion_farmacia_form.html'
    success_message = "Asignación registrada."

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['motorista'] = get_object_or_404(Motorista, pk=self.kwargs['motorista_pk'])
        return ctx

    def form_valid(self, form):
        form.instance.motorista = get_object_or_404(Motorista, pk=self.kwargs['motorista_pk'])
        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('motorista_detalle', kwargs={'pk': self.kwargs['motorista_pk']})


class AsignacionMotoCreateView(CreateView):
    model = AsignacionMoto
    form_class = AsignacionMotoForm
    template_name = "templatesApp1Discopro/asignacion_moto_form.html"

    def dispatch(self, request, *args, **kwargs):
        self.moto = get_object_or_404(Moto, pk=kwargs.get("moto_pk"))
        return super().dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx["moto"] = self.moto
        return ctx

    def form_valid(self, form):

        # 1) Cerrar asignación previa si está activa
        asignacion_previa = AsignacionMoto.objects.filter(
            moto=self.moto,
            fechaTermino__isnull=True
        ).order_by('-fechaAsignacion').first()

        if asignacion_previa:
            asignacion_previa.fechaTermino = timezone.localdate()
            asignacion_previa.save()

        # 2) Crear nueva asignación
        form.instance.moto = self.moto
        form.instance.fechaAsignacion = timezone.now()

        # (OPCIONAL) si el usuario deja fechaTermino en blanco, Django lo guarda como NULL
        # No hay que tocar nada más

        return super().form_valid(form)

    def get_success_url(self):
        return reverse("moto_detalle", kwargs={"pk": self.moto.pk})

# =======================================================
# DOCUMENTACIÓN Y MANTENIMIENTO DE MOTOS
# =======================================================

class DocumentacionMotoUpdateView(LoginRequiredMixin, UpdateView):
    model = DocumentacionMoto
    form_class = DocumentacionMotoForm
    template_name = 'templatesApp1Discopro/documentacion_moto_form.html'

    def get_object(self, queryset=None):
        return get_object_or_404(DocumentacionMoto, moto__patente=self.kwargs['pk'])

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['moto'] = self.get_object().moto
        return ctx

    def get_success_url(self):
        return reverse('moto_detalle', kwargs={'pk': self.get_object().moto.patente})


class MantenimientoCreateView(LoginRequiredMixin, CreateView):
    model = Mantenimiento  # 👈 ESTE ES TU MODELO REAL
    form_class = MantenimientoForm
    template_name = 'templatesApp1Discopro/mantenimiento_form.html'

    def dispatch(self, request, *args, **kwargs):
        # recuperar moto por patente
        self.moto = get_object_or_404(Moto, patente=self.kwargs['pk'])
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        # Asignar la moto al mantenimiento antes de guardar
        form.instance.moto = self.moto
        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['moto'] = self.moto
        return ctx

    def get_success_url(self):
        return reverse('moto_detalle', kwargs={'pk': self.moto.patente})

# =======================================================
# CONTACTOS DE EMERGENCIA
# =======================================================

class ContactoEmergenciaCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = ContactoEmergencia
    form_class = ContactoEmergenciaForm
    template_name = 'templatesApp1Discopro/contacto_emergencia_form.html'
    success_message = "Contacto agregado."

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['motorista'] = get_object_or_404(Motorista, pk=self.kwargs['motorista_pk'])
        return ctx

    def form_valid(self, form):
        form.instance.motorista = get_object_or_404(Motorista, pk=self.kwargs['motorista_pk'])
        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('motorista_detalle', kwargs={'pk': self.kwargs['motorista_pk']})


class ContactoEmergenciaDeleteView(LoginRequiredMixin, DeleteView):
    model = ContactoEmergencia
    template_name = 'templatesApp1Discopro/confirmar_eliminar.html'

    def get_success_url(self):
        return reverse_lazy('motorista_detalle', kwargs={'pk': self.object.motorista.pk})

# =======================================================
# CRUD MOVIMIENTOS / TRAMOS
# =======================================================

class MovimientoListView(LoginRequiredMixin, ListView):
    model = Movimiento
    template_name = 'templatesApp1Discopro/movimiento_list.html'
    context_object_name = 'movimientos'
    paginate_by = 20

    def get_queryset(self):
        qs = super().get_queryset().select_related(
            "tipo_movimiento", "motorista_asignado"
        )

        q = self.request.GET.get("q")

        if q:
            qs = qs.filter(
                Q(numero_despacho__icontains=q) |
                Q(origen__icontains=q) |
                Q(destino__icontains=q) |
                Q(estado__icontains=q) |
                Q(motorista_asignado__nombres__icontains=q)
            )

        return qs

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx["q"] = self.request.GET.get("q", "")
        return ctx


class MovimientoDetailView(LoginRequiredMixin, DetailView):
    model = Movimiento
    template_name = 'templatesApp1Discopro/movimiento_detail.html'
    context_object_name = 'movimiento'


class MovimientoCreateView(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    model = Movimiento
    form_class = MovimientoForm
    template_name = 'templatesApp1Discopro/movimiento_padre_form.html'
    success_message = "Despacho creado."

    def form_valid(self, form):
        form.instance.usuario_responsable = self.request.user
        return super().form_valid(form)

    def get_success_url(self):
        return self.object.get_absolute_url()


class MovimientoUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Movimiento
    form_class = MovimientoForm
    template_name = 'templatesApp1Discopro/movimiento_padre_form.html'
    success_message = "Movimiento actualizado."

    def get_success_url(self):
        return self.object.get_absolute_url()


class MovimientoDeleteView(LoginRequiredMixin, DeleteView):
    model = Movimiento
    template_name = 'templatesApp1Discopro/confirmar_eliminar.html'
    success_url = reverse_lazy('movimiento_lista')

    def form_valid(self, form):
        messages.success(self.request, "Movimiento eliminado.")
        return super().form_valid(form)


class TramoCreateView(CreateView):
    model = Movimiento
    form_class = MovimientoForm
    template_name = "templatesApp1Discopro/tramo_form.html"

    def dispatch(self, request, *args, **kwargs):
        self.movimiento_padre = get_object_or_404(Movimiento, pk=self.kwargs['padre_pk'])
        return super().dispatch(request, *args, **kwargs)

    def get_initial(self):
        initial = super().get_initial()
        initial["movimiento_padre"] = self.movimiento_padre
        return initial

    def form_valid(self, form):
        # Asignar siempre el movimiento padre
        form.instance.movimiento_padre = self.movimiento_padre
        
        # Los tramos NO deben tener numero_despacho porque sería duplicado
        form.instance.numero_despacho = None

        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["movimiento_padre"] = self.movimiento_padre
        return context

class TramoUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = Movimiento
    form_class = MovimientoForm
    template_name = 'templatesApp1Discopro/tramo_form.html'
    success_message = "Tramo actualizado."

    def get_success_url(self):
        return reverse_lazy('movimiento_detalle', kwargs={'pk': self.object.movimiento_padre.pk})


class TramoDeleteView(LoginRequiredMixin, DeleteView):
    model = Movimiento
    template_name = 'templatesApp1Discopro/confirmar_eliminar.html'

    def get_success_url(self):
        return reverse_lazy('movimiento_detalle', kwargs={'pk': self.object.movimiento_padre.pk})

# =======================================================
# AJAX REGIÓN / PROVINCIA / COMUNA
# =======================================================

@login_required
def load_provincias(request):
    region_id = request.GET.get('region')
    provincias = Provincia.objects.filter(region_id=region_id).order_by('nombreProvincia')
    return JsonResponse(list(provincias.values('idProvincia', 'nombreProvincia')), safe=False)


@login_required
def load_comunas(request):
    provincia_id = request.GET.get('provincia')
    comunas = Comuna.objects.filter(provincia_id=provincia_id).order_by('nombreComuna')
    return JsonResponse(list(comunas.values('idComuna', 'nombreComuna')), safe=False)
