from django.contrib import admin
from django.urls import path
from app1Discopro import views
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [

    # ---------------------------
    # LOGIN / LOGOUT
    # ---------------------------
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),

    # ---------------------------
    # DASHBOARD
    # ---------------------------
    path('', views.index, name='index'),

    # ---------------------------
    # REPORTES
    # ---------------------------
    path('reportes/', views.ReporteMovimientosView.as_view(), name='reporte_general'),
    path('reportes/pdf/', views.ExportarReportePDFView.as_view(), name='exportar_pdf'),

    # ---------------------------
    # USUARIOS
    # ---------------------------
    path('usuarios/', views.UsuarioListView.as_view(), name='usuario_lista'),
    path('usuarios/crear/', views.UsuarioCreateView.as_view(), name='usuario_crear'),
    path('usuarios/<int:pk>/editar/', views.UsuarioUpdateView.as_view(), name='usuario_editar'),
    path('usuarios/<int:pk>/eliminar/', views.UsuarioDeleteView.as_view(), name='usuario_eliminar'),
    path('usuarios/<int:pk>/reset-password/', views.AdminPasswordResetView.as_view(), name='admin_reset_password'),

    # Mi Cuenta
    path('mi-cuenta/', views.MiCuentaView.as_view(), name='mi_cuenta'),
    path('mi-cuenta/editar/', views.MiCuentaUpdateView.as_view(), name='mi_cuenta_editar'),

     # ---------------------------
     # FARMACIAS
     # ---------------------------
     path('farmacias/', views.FarmaciaListView.as_view(), name='farmacia_lista'),
     path('farmacias/crear/', views.FarmaciaCreateView.as_view(), name='farmacia_crear'),
     path('farmacias/<int:pk>/editar/', views.FarmaciaUpdateView.as_view(), name='farmacia_editar'),
     path('farmacias/<int:pk>/eliminar/', views.FarmaciaDeleteView.as_view(), name='farmacia_eliminar'),
     path('farmacias/<int:pk>/', views.FarmaciaDetailView.as_view(), name='farmacia_detalle'),


    # ---------------------------
    # MOTORISTAS
    # ---------------------------
    path('motoristas/', views.MotoristaListView.as_view(), name='motorista_lista'),
    path('motoristas/crear/', views.MotoristaCreateView.as_view(), name='motorista_crear'),
    path('motoristas/<int:pk>/editar/', views.MotoristaUpdateView.as_view(), name='motorista_editar'),
    path('motoristas/<int:pk>/eliminar/', views.MotoristaDeleteView.as_view(), name='motorista_eliminar'),
    path('motoristas/<int:pk>/', views.MotoristaDetailView.as_view(), name='motorista_detalle'),

    # Asignaciones
    path('motoristas/<int:motorista_pk>/asignar-farmacia/',
         views.AsignacionFarmaciaCreateView.as_view(),
         name='asignar_farmacia'),

     path('motos/<str:moto_pk>/asignar-moto/',
          views.AsignacionMotoCreateView.as_view(),
          name='asignar_moto'),

    # Contactos emergencia
    path('motoristas/<int:motorista_pk>/contacto/crear/',
         views.ContactoEmergenciaCreateView.as_view(),
         name='contacto_emergencia_crear'),

    path('contacto-eliminar/<int:pk>/',
         views.ContactoEmergenciaDeleteView.as_view(),
         name='contacto_emergencia_eliminar'),

    # ---------------------------
    # MOTOS
    # ---------------------------
    path('motos/', views.MotoListView.as_view(), name='moto_lista'),
    path('motos/crear/', views.MotoCreateView.as_view(), name='moto_crear'),
    path('motos/editar/<str:pk>/', views.MotoUpdateView.as_view(), name='moto_editar'),
    path('motos/eliminar/<str:pk>/', views.MotoDeleteView.as_view(), name='moto_eliminar'),
    path('motos/<str:pk>/', views.MotoDetailView.as_view(), name='moto_detalle'),

    # Documentación y mantenimiento
    path('motos/<str:pk>/documentacion/', views.DocumentacionMotoUpdateView.as_view(), name='documentacion_moto'),
    path('motos/<str:pk>/mantenimiento/', views.MantenimientoCreateView.as_view(), name='mantenimiento_moto'),

    # ---------------------------
    # MOVIMIENTOS (DESPACHOS)
    # ---------------------------
    path('movimientos/', views.MovimientoListView.as_view(), name='movimiento_lista'),
    path('movimientos/crear/', views.MovimientoCreateView.as_view(), name='movimiento_crear'),
    path('movimientos/<int:pk>/', views.MovimientoDetailView.as_view(), name='movimiento_detalle'),
    path('movimientos/<int:pk>/editar/', views.MovimientoUpdateView.as_view(), name='movimiento_editar'),
    path('movimientos/<int:pk>/eliminar/', views.MovimientoDeleteView.as_view(), name='movimiento_eliminar'),

    # Tramos
    path('movimientos/<int:padre_pk>/tramo/crear/', views.TramoCreateView.as_view(), name='tramo_crear'),
    path('tramos/<int:pk>/editar/', views.TramoUpdateView.as_view(), name='tramo_editar'),
    path('tramos/<int:pk>/eliminar/', views.TramoDeleteView.as_view(), name='tramo_eliminar'),

    # ---------------------------
    # AJAX REGIÓN / PROVINCIA / COMUNA
    # ---------------------------
    path('ajax/provincias/', views.load_provincias, name='ajax_provincias'),
    path('ajax/comunas/', views.load_comunas, name='ajax_comunas'),

    # Django Admin
    path('admin/', admin.site.urls),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)