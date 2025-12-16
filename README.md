Discopro – Sistema de Gestión de Despachos y Motoristas

Sistema web desarrollado en Django para la gestión de motoristas, motos, farmacias, despachos y mantenimientos.
Proyecto académico con despliegue 100% funcional en la nube.

🚀 Demo en Producción

🌐 URL pública (Render):
👉 https://discopro2-0-1.onrender.com

👤 Credenciales de Prueba

⚠️ Proyecto académico — sin restricciones de seguridad avanzadas

🔑 Administrador

Email: admin@discopro.cl

Contraseña: Discopro850Seguro.

🛠️ Tecnologías Utilizadas

Backend: Django 5.2

Base de Datos:

Local: MySQL (XAMPP)

Producción: PostgreSQL (Supabase)

Servidor Web: Gunicorn

Deploy: Render

ORM: Django ORM

Autenticación: Usuario personalizado (email o username)

Frontend: HTML + Bootstrap (templates Django)

📁 Estructura del Proyecto
proyectoDiscopro/
│
├── app1Discopro/          # Aplicación principal
├── proyectoDiscopro/      # Configuración Django
├── templates/             # Templates HTML
├── static/                # Archivos estáticos
├── media/                 # Archivos subidos
├── requirements.txt
├── render.yaml
├── manage.py
└── README.md

⚙️ Instalación Local (DESARROLLO)
1️⃣ Clonar repositorio
git clone https://github.com/Alucard158/discopro2.0.git
cd discopro2.0/proyectoDiscopro

2️⃣ Crear entorno virtual

Windows

python -m venv venv
venv\Scripts\activate


Linux / Mac

python3 -m venv venv
source venv/bin/activate

3️⃣ Instalar dependencias
pip install -r requirements.txt

4️⃣ Crear archivo .env (LOCAL)

Crea un archivo .env en proyectoDiscopro/:

SECRET_KEY=admin
DEBUG=True

DB_ENGINE=django.db.backends.mysql
DB_NAME=dbdiscopro
DB_USER=root
DB_PASSWORD=admin
DB_HOST=localhost
DB_PORT=3306

5️⃣ Migraciones
python manage.py migrate

6️⃣ Crear superusuario (opcional)
python manage.py createsuperuser

7️⃣ Ejecutar servidor local
python manage.py runserver


📍 Accede en:
👉 http://127.0.0.1:8000

☁️ Configuración en Producción (Render + Supabase)
Variables de entorno en Render
SECRET_KEY=admin
DEBUG=True

DB_ENGINE=django.db.backends.postgresql
DB_NAME=postgres
DB_USER=postgres.cobedmzfqfkuwtktkyeq
DB_PASSWORD=**************
DB_HOST=aws-1-us-east-2.pooler.supabase.com
DB_PORT=6543

Comandos Render

Build Command

pip install -r requirements.txt


Start Command

cd proyectoDiscopro && gunicorn proyectoDiscopro.wsgi:application

🧪 Datos de Prueba Incluidos

Usuarios (admin, gerente, supervisor, operadores)

Motoristas

Motos

Farmacias

Movimientos (para paginación)

Mantenimientos

📌 Consideraciones Académicas

Proyecto desarrollado con fines educativos

No incluye control de permisos avanzado

Contraseñas en texto claro solo para evaluación

Enfoque en arquitectura, despliegue y funcionalidad

📄 Autor

Alumno: Alvaro Vergara, Erica Yuliana Crizologo, Pamela Buenuleo
Asignatura: Proyecto Integrado
Institución: INACAP Santiago Centro

✅ Estado del Proyecto

✔ Funcional
✔ Deploy en la nube
✔ Base de datos remota
✔ Login operativo
✔ Evaluable
