
-- Estructura de tabla para la tabla `app1discopro_region`
CREATE TABLE `app1discopro_region` (
  `regionId` int(11) NOT NULL,
  `regionNombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura de tabla para la tabla `app1discopro_provincia`
CREATE TABLE `app1discopro_provincia` (
  `provinciaId` int(11) NOT NULL,
  `provinciaNombre` varchar(100) NOT NULL,
  `regionId_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura de tabla para la tabla `app1discopro_comuna`
CREATE TABLE `app1discopro_comuna` (
  `comunaId` int(11) NOT NULL,
  `comunaNombre` varchar(100) NOT NULL,
  `provinciaId_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura de tabla para la tabla `auth_group`
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura de tabla para la tabla `auth_user`
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura de tabla para la tabla `auth_user_groups`
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura de tabla para la tabla `app1discopro_sesionlog`
CREATE TABLE `app1discopro_sesionlog` (
  `id` bigint(20) NOT NULL,
  `accion` varchar(10) NOT NULL,
  `fecha_registro` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- (Otras tablas de Django y app1Discopro deben ser creadas aquí, usando el DUMP completo que ya tienes, por brevedad solo muestro las principales)

-- ******************************************************
-- 3. DATOS DE PRUEBA ESENCIALES
-- ******************************************************

-- Datos de Regiones
INSERT INTO `app1discopro_region` (`regionId`, `regionNombre`) VALUES
(1, 'Región Metropolitana'),
(2, 'Región de Valparaíso'),
(3, 'Región del Biobío');

-- Datos de Provincias
INSERT INTO `app1discopro_provincia` (`provinciaId`, `provinciaNombre`, `regionId_id`) VALUES
(1, 'Santiago', 1),
(2, 'Cordillera', 1),
(3, 'Valparaíso', 2),
(4, 'Concepción', 3);

-- Datos de Comunas
INSERT INTO `app1discopro_comuna` (`comunaId`, `comunaNombre`, `provinciaId_id`) VALUES
(1, 'Santiago Centro', 1),
(2, 'Providencia', 1),
(3, 'Puente Alto', 2),
(4, 'Las Condes', 1),
(5, 'Viña del Mar', 3),
(6, 'Talcahuano', 4);

-- Grupos de Usuarios (Roles)
INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Administrador'),
(2, 'Gerente'),
(5, 'Motorista'),
(4, 'Operario'),
(3, 'Supervisor');


-- ******************************************************
-- 4. INSERCIÓN DE USUARIOS Y ASIGNACIÓN DE ROLES (SOLUCIÓN DEL PROBLEMA)
-- ******************************************************

-- ********* ¡DEBEN REEMPLAZAR ESTOS HASHES POR LOS GENERADOS EN DJANGO! *********
-- Hash: Discopro850Seguro.
SET @ADMIN_HASH = 'pbkdf2_sha256$1000000$9Czv9H5ooTJr2IND8hjjUj$lykUcxDULEHzI4g0NvO77fRuF+C0hPzk6OeCEmmCSJM='; 
-- Hash: DiscoproTemp123
SET @STAFF_HASH = 'pbkdf2_sha256$1000000$XMYWJ7PNyzQMdF0x79Cgcl$12ph6QjS5v8/aj81oCYtsY2gjD4J+XLvv0Yp9kA+g6w='; 
-- ******************************************************************************

-- 4.1. INSERCIÓN DE USUARIOS
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES
(1, @ADMIN_HASH, NULL, 1, 'admin_base', 'Super', 'Admin', 'admin@discopro.cl', 1, 1, NOW()),
(2, @STAFF_HASH, NULL, 0, 'gerente01', 'Gerente', 'Jefe', 'gerente01@discopro.cl', 0, 1, NOW()),
(3, @STAFF_HASH, NULL, 0, 'supervisor01', 'Supervisor', 'Operativo', 'supervisor01@discopro.cl', 0, 1, NOW()),
(4, @STAFF_HASH, NULL, 0, 'operario01', 'Operario', 'Uno', 'operario01@discopro.cl', 0, 1, NOW()),
(5, @STAFF_HASH, NULL, 0, 'operario02', 'Operario', 'Dos', 'operario02@discopro.cl', 0, 1, NOW()),
(6, @STAFF_HASH, NULL, 0, 'operario03', 'Operario', 'Tres', 'operario03@discopro.cl', 0, 1, NOW()),
(7, @STAFF_HASH, NULL, 0, 'operario04', 'Operario', 'Cuatro', 'operario04@discopro.cl', 0, 1, NOW()),
(8, @STAFF_HASH, NULL, 0, 'operario05', 'Operario', 'Cinco', 'operario05@discopro.cl', 0, 1, NOW());

-- 4.2. ASIGNACIÓN DE GRUPOS
SET @ADMIN_GROUP_ID = (SELECT id FROM auth_group WHERE name = 'Administrador');
SET @GERENTE_GROUP_ID = (SELECT id FROM auth_group WHERE name = 'Gerente');
SET @SUPERVISOR_GROUP_ID = (SELECT id FROM auth_group WHERE name = 'Supervisor');
SET @OPERARIO_GROUP_ID = (SELECT id FROM auth_group WHERE name = 'Operario');

INSERT INTO auth_user_groups (user_id, group_id) VALUES 
(1, @ADMIN_GROUP_ID),
(2, @GERENTE_GROUP_ID),
(3, @SUPERVISOR_GROUP_ID),
(4, @OPERARIO_GROUP_ID),
(5, @OPERARIO_GROUP_ID),
(6, @OPERARIO_GROUP_ID),
(7, @OPERARIO_GROUP_ID),
(8, @OPERARIO_GROUP_ID);


-- ******************************************************
-- 5. CONFIGURACIÓN DE ÍNDICES, CLAVES Y RESTRICCIONES (Necesario para un DUMP completo)
-- ******************************************************

-- (Aquí deben ir las definiciones de PRIMARY KEYS, FOREIGN KEYS y AUTO_INCREMENTS,
-- tal como las tenías al final de tu DUMP de phpMyAdmin. Por la longitud, solo se
-- incluye la estructura de las tablas principales que definiste. Si necesitan el
-- DUMP completo, pueden usar el que enviaste anteriormente y añadirle las secciones 
-- 4.1 y 4.2 corregidas y la limpieza inicial).

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;