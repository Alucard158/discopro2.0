# 🚀 Instalación de Discopro 2.0 (Django + MySQL)

Sigue estos pasos en orden y el sistema quedará funcionando.

---

## 1. Clonar el proyecto desde GitHub

En una carpeta de trabajo, abre CMD/PowerShell y ejecuta:

git clone https://github.com/Alucard158/discopro2.0.git

cd discopro2.0

2. Crear y activar el entorno virtual (OBLIGATORIO)

Windows
python -m venv venv
venv\Scripts\activate

Linux / Mac
python3 -m venv venv
source venv/bin/activate


Si el entorno está bien activado, verás algo como:

(venv) C:\ruta\discopro2.0>

3. Instalar dependencias del proyecto

El repositorio incluye requirements.txt.
Instala todo con:

pip install -r requirements.txt


Esto instalará, entre otros:

Django 5.2.8

mysqlclient (para conectar con MySQL)

python-decouple (para leer .env)

weasyprint (para PDF)

Pillow (imágenes)

4. Crear el archivo .env (configuración del proyecto)

El repo incluye un ejemplo: .env.example.

Cópialo a .env:

Windows
copy .env.example .env

Linux / Mac
cp .env.example .env


Luego edita el archivo .env y revisa/ajusta los valores (por defecto vienen así):

SECRET_KEY=admin
DEBUG=True

DB_NAME=discopro
DB_USER=root
DB_PASSWORD=
DB_HOST=127.0.0.1
DB_PORT=3306


⚠️ IMPORTANTE: Antes de seguir, asegúrate de tener XAMPP/MySQL levantado
(el servicio de MySQL debe estar en ejecución).

5. Crear la base de datos en MySQL

Si la base de datos discopro aún no existe, créala.

En CMD/PowerShell:

mysql -u root -p -e "CREATE DATABASE discopro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"


Si ya existe, puedes saltarte este paso.

Si mysql no se reconoce, usa la ruta completa de XAMPP, por ejemplo:
"C:\xampp\mysql\bin\mysql.exe" -u root -p -e "CREATE DATABASE discopro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

6. Importar la base de datos del proyecto

En la raíz del proyecto viene un archivo SQL exportado, por ejemplo:

db_export.sql


Importa ese archivo a la base discopro:

mysql -u root -p discopro < db_export.sql


O con ruta completa en XAMPP:

"C:\xampp\mysql\bin\mysql.exe" -u root -p discopro < db_export.sql


Tras esto, la base de datos queda con todos los datos iniciales del sistema.

7. Aplicar migraciones (solo si el proyecto cambió)

Si recién clonas y la base viene exportada completa, normalmente no es necesario,
pero por si acaso puedes ejecutar:

python manage.py migrate

8. Usuario administrador (superuser ya creado)

No es obligatorio crear un superusuario manualmente, porque la base de datos exportada
ya incluye un usuario administrador listo para usar.

Puedes entrar con estas credenciales:

Rol: Administrador

Nombre: admin

Correo: admin@discopro.cl

Contraseña: Discopro850Seguro.

Si de todas maneras quieres crear otro superusuario adicional, puedes hacerlo con:

python manage.py createsuperuser

9. Levantar el servidor

Con el entorno virtual activado y la base de datos lista, ejecuta:

python manage.py runserver


Luego abre en el navegador:

👉 http://127.0.0.1:8000/

E inicia sesión con:

Email: admin@discopro.cl

Contraseña: Discopro850Seguro.
