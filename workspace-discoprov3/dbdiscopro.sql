-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-12-2025 a las 03:39:16
-- Versión del servidor: 12.0.2-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbdiscopro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_asignacionfarmacia`
--

CREATE TABLE `app1discopro_asignacionfarmacia` (
  `idAsignacionFarmacia` int(11) NOT NULL,
  `fechaAsignacion` datetime(6) NOT NULL,
  `observaciones` longtext DEFAULT NULL,
  `fechaTermino` date DEFAULT NULL,
  `farmacia_id` int(11) NOT NULL,
  `motorista_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_asignacionfarmacia`
--

INSERT INTO `app1discopro_asignacionfarmacia` (`idAsignacionFarmacia`, `fechaAsignacion`, `observaciones`, `fechaTermino`, `farmacia_id`, `motorista_id`) VALUES
(1, '2025-12-09 21:29:03.004493', '', NULL, 11, 1),
(3, '2025-12-09 22:52:55.709809', '', '2025-12-18', 12, 1),
(4, '2025-12-10 02:02:36.582772', '', NULL, 13, 1),
(5, '2025-12-10 02:13:36.775123', '', NULL, 12, 3),
(6, '2025-12-10 02:24:05.094372', '', NULL, 11, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_asignacionmoto`
--

CREATE TABLE `app1discopro_asignacionmoto` (
  `idAsignacionMoto` int(11) NOT NULL,
  `fechaAsignacion` datetime(6) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `fechaTermino` date DEFAULT NULL,
  `moto_id` varchar(15) NOT NULL,
  `motorista_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_asignacionmoto`
--

INSERT INTO `app1discopro_asignacionmoto` (`idAsignacionMoto`, `fechaAsignacion`, `estado`, `fechaTermino`, `moto_id`, `motorista_id`) VALUES
(3, '2025-12-09 21:27:50.321383', 'Asignada', NULL, 'ASDF90', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_comuna`
--

CREATE TABLE `app1discopro_comuna` (
  `idComuna` int(11) NOT NULL,
  `nombreComuna` varchar(100) NOT NULL,
  `provincia_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_comuna`
--

INSERT INTO `app1discopro_comuna` (`idComuna`, `nombreComuna`, `provincia_id`) VALUES
(1, 'Arica', 1),
(2, 'Iquique', 2),
(3, 'Antofagasta', 3),
(4, 'Copiapó', 4),
(5, 'La Serena', 5),
(6, 'Valparaíso', 6),
(7, 'Santiago Centro', 7),
(8, 'Rancagua', 8),
(9, 'Talca', 9),
(10, 'Chillán', 10),
(11, 'Concepción', 11),
(12, 'Temuco', 12),
(13, 'Valdivia', 13),
(14, 'Puerto Montt', 14),
(15, 'Coyhaique', 15),
(16, 'Punta Arenas', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_contactoemergencia`
--

CREATE TABLE `app1discopro_contactoemergencia` (
  `idContacto` int(11) NOT NULL,
  `nombreCompleto` varchar(100) NOT NULL,
  `parentesco` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `motorista_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_contactoemergencia`
--

INSERT INTO `app1discopro_contactoemergencia` (`idContacto`, `nombreCompleto`, `parentesco`, `telefono`, `motorista_id`) VALUES
(2, 'Maria Teresa', 'Madre', '+56950000031', 1),
(3, 'Maria Teresa', 'Primo', '+56950000031', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_documentacion`
--

CREATE TABLE `app1discopro_documentacion` (
  `idDocumentacion` int(11) NOT NULL,
  `nombreDocumento` varchar(100) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `fechaVencimiento` date DEFAULT NULL,
  `motorista_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_documentacionmoto`
--

CREATE TABLE `app1discopro_documentacionmoto` (
  `id` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `permiso_circulacion_file` varchar(100) DEFAULT NULL,
  `permiso_circulacion_vencimiento` date DEFAULT NULL,
  `seguro_obligatorio_file` varchar(100) DEFAULT NULL,
  `seguro_obligatorio_vencimiento` date DEFAULT NULL,
  `revision_tecnica_file` varchar(100) DEFAULT NULL,
  `revision_tecnica_vencimiento` date DEFAULT NULL,
  `moto_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_documentacionmoto`
--

INSERT INTO `app1discopro_documentacionmoto` (`id`, `anio`, `permiso_circulacion_file`, `permiso_circulacion_vencimiento`, `seguro_obligatorio_file`, `seguro_obligatorio_vencimiento`, `revision_tecnica_file`, `revision_tecnica_vencimiento`, `moto_id`) VALUES
(1, 2025, '', NULL, '', NULL, '', NULL, 'ASDF90');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_farmacia`
--

CREATE TABLE `app1discopro_farmacia` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `horario_apertura` time(6) NOT NULL,
  `horario_cierre` time(6) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `latitud` decimal(9,6) DEFAULT NULL,
  `longitud` decimal(9,6) DEFAULT NULL,
  `comuna_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_farmacia`
--

INSERT INTO `app1discopro_farmacia` (`codigo`, `nombre`, `direccion`, `horario_apertura`, `horario_cierre`, `telefono`, `latitud`, `longitud`, `comuna_id`) VALUES
(11, 'Cruz Verde Arica Centro', '21 de Mayo 346', '08:00:00.000000', '21:01:00.000000', '+5658223344', -18.478300, -70.312600, 1),
(12, 'Cruz Verde Iquique Baquedano', 'Baquedano 1012', '09:00:00.000000', '22:00:00.000000', '+5657238844', -20.213300, -70.152400, 2),
(13, 'Cruz Verde Antofagasta Mall Plaza', 'Av. Angamos 2320', '08:30:00.000000', '21:30:00.000000', '+5655223344', -23.652600, -70.395400, 3),
(14, 'Cruz Verde Copiapó Centro', 'Atacama 560', '09:00:00.000000', '20:00:00.000000', '+5652221122', -27.366800, -70.332300, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_mantenimiento`
--

CREATE TABLE `app1discopro_mantenimiento` (
  `id` bigint(20) NOT NULL,
  `fecha_mantenimiento` date NOT NULL,
  `descripcion` longtext NOT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `taller` varchar(100) DEFAULT NULL,
  `kilometraje` int(11) DEFAULT NULL,
  `factura` varchar(100) DEFAULT NULL,
  `fecha_registro` datetime(6) NOT NULL,
  `moto_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_moto`
--

CREATE TABLE `app1discopro_moto` (
  `patente` varchar(15) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `color` varchar(30) NOT NULL,
  `anio` int(11) NOT NULL,
  `numero_chasis` varchar(50) DEFAULT NULL,
  `motor` varchar(50) DEFAULT NULL,
  `propietario` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_moto`
--

INSERT INTO `app1discopro_moto` (`patente`, `marca`, `modelo`, `color`, `anio`, `numero_chasis`, `motor`, `propietario`) VALUES
('ASDF90', 'Honda', 'XR150', 'Azul', 2021, 'CHS222111', 'MT150', 'Motorista'),
('ASDF93', 'Honda', 'XR150', 'Rojo', 1990, 'CHS222111', 'MT150', 'Motorista'),
('ASDF96', 'Dell', 'XR150', 'Rojo', 1990, 'CHS222111', 'MT150', 'Motorista'),
('BNMM88', 'TVS', 'RTR160', 'Azul', 2021, 'CHS123777', 'MT160', 'Motorista'),
('HKFR11', 'Yamaha', 'FZ16', 'Rojo', 2016, 'CHS123001', 'MT150', 'Empresa'),
('JKLT22', 'Honda', 'CB125', 'Negro', 2018, 'CHS122341', 'MT125', 'Motorista'),
('LOPK55', 'Keeway', 'Superlight200', 'Negro', 2019, 'CHS998877', 'MT200', 'Empresa'),
('PLSD45', 'Suzuki', 'GN125', 'Azul', 2015, 'CHS987654', 'MT125', 'Empresa'),
('QWER66', 'Honda', 'Wave110', 'Gris', 2017, 'CHS883200', 'MT110', 'Empresa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_motorista`
--

CREATE TABLE `app1discopro_motorista` (
  `codigo` int(11) NOT NULL,
  `rut` varchar(12) NOT NULL,
  `pasaporte` varchar(20) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(254) NOT NULL,
  `incluye_moto_personal` tinyint(1) NOT NULL,
  `licencia_conducir` varchar(100) DEFAULT NULL,
  `fecha_ultimo_control` date DEFAULT NULL,
  `fecha_proximo_control` date DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `comuna_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_motorista`
--

INSERT INTO `app1discopro_motorista` (`codigo`, `rut`, `pasaporte`, `nombres`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `direccion`, `telefono`, `correo`, `incluye_moto_personal`, `licencia_conducir`, `fecha_ultimo_control`, `fecha_proximo_control`, `estado`, `comuna_id`) VALUES
(1, '12.345.678-9', NULL, 'Carlos', 'Muñoz', 'Pérez', '1990-05-12', 'Av. Arica 1000', '958112233', 'carlos.munoz@mail.cl', 0, 'licencias/HP-ProDesk.avif', '2026-01-02', '2025-12-16', 'activo', 1),
(2, '13.998.211-4', NULL, 'Javier', 'Gómez', 'Rivas', '1988-09-22', 'Av. Tarapacá 200', '997665544', 'javier.gomez@mail.cl', 0, NULL, NULL, NULL, 'activo', 2),
(3, '14.778.991-1', NULL, 'Luis', 'Torres', 'Mendoza', '1992-02-10', 'Av. Brasil 3000', '934556677', 'luis.torres@mail.cl', 1, '', NULL, NULL, 'activo', 3),
(4, '15.112.664-7', NULL, 'Felipe', 'Pino', 'Soto', '1995-11-01', 'Av. Atacama 400', '922334455', 'felipe.pino@mail.cl', 0, NULL, NULL, NULL, 'inactivo', 4),
(5, '16.337.819-6', NULL, 'Diego', 'Lagos', 'Valdés', '1987-01-17', 'Av. Peñuelas 150', '944556677', 'diego.lagos@mail.cl', 0, NULL, NULL, NULL, 'activo', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_movimiento`
--

CREATE TABLE `app1discopro_movimiento` (
  `id_movimiento` int(11) NOT NULL,
  `numero_despacho` varchar(50) DEFAULT NULL,
  `fecha_movimiento` datetime(6) NOT NULL,
  `observacion` longtext DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `origen` varchar(255) NOT NULL,
  `destino` varchar(255) NOT NULL,
  `motorista_asignado_id` int(11) DEFAULT NULL,
  `movimiento_padre_id` int(11) DEFAULT NULL,
  `usuario_responsable_id` bigint(20) NOT NULL,
  `tipo_movimiento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_movimiento`
--

INSERT INTO `app1discopro_movimiento` (`id_movimiento`, `numero_despacho`, `fecha_movimiento`, `observacion`, `estado`, `origen`, `destino`, `motorista_asignado_id`, `movimiento_padre_id`, `usuario_responsable_id`, `tipo_movimiento_id`) VALUES
(1, 'D-1001', '2025-12-09 07:54:00.000000', 'Entrega directa a cliente', 'completado', 'Farmacia Arica', 'Cliente Calle 1', 1, NULL, 1, 1),
(2, 'D-1002', '2025-12-09 06:52:00.000000', 'Requiere receta médica', 'completado', 'Farmacia Iquique', 'Hospital Base', 2, NULL, 5, 2),
(3, 'D-1003', '2025-12-09 06:52:05.000000', 'Traslado interno', 'terminado', 'Farmacia Antofagasta', 'Sucursal Centro', 3, NULL, 1, 3),
(4, 'D-1004', '2025-12-09 06:52:05.000000', 'Reenvío por dirección incorrecta', 'anulado', 'Farmacia Copiapó', 'Cliente Reenvío', 4, NULL, 1, 4),
(5, 'D-1005', '2025-12-09 06:52:05.000000', 'Tramo adicional', 'pendiente', 'Sucursal La Serena', 'Cliente Final', 5, NULL, 1, 1),
(6, 'D-1006', '2025-12-09 06:52:00.000000', 'Entrega urgente', 'completado', 'Farmacia Santiago', 'Clínica Indisa', NULL, NULL, 1, 2),
(7, 'D-1007', '2025-12-09 06:52:05.000000', 'Retiro en farmacia', 'terminado', 'Farmacia Talca', 'Cliente Calle 15', NULL, NULL, 1, 3),
(8, 'D-1008', '2025-12-09 06:52:05.000000', 'Reenvío autorizado', 'anulado', 'Farmacia Temuco', 'Cliente Nuevo', NULL, NULL, 1, 4),
(9, 'D-1009', '2025-12-09 06:52:05.000000', 'Directo sin observaciones', 'pendiente', 'Farmacia Valparaíso', 'Cliente Cerro Alegre', NULL, NULL, 1, 1),
(11, 'D-1200', '2025-12-09 15:23:00.000000', 'a', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, NULL, 1, 1),
(12, 'D-1222', '2025-12-09 13:53:00.000000', 'a', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, NULL, 1, 2),
(13, 'D-1013-B', '2025-12-09 22:30:00.000000', 'a', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, 1, 6, 2),
(14, 'D-1013-C', '2025-12-09 22:31:00.000000', 'a', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', 2, 13, 8, 3),
(20, 'D-1001', '2025-12-10 01:01:19.641611', 'aaa', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, 1, 1, 1),
(21, 'D-1001', '2025-12-10 01:06:49.586509', 'aaa', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, 1, 1, 2),
(22, 'D-1001', '2025-12-10 01:07:41.014602', 'aa', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, 1, 1, 1),
(23, 'D-1013-E', '2025-12-10 01:12:00.000000', 'aaa', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', NULL, 1, 3, 3),
(24, 'D-1200-A', '2025-12-10 01:28:00.000000', '', 'pendiente', 'Hospital Base', 'Almte. Barroso 76', 2, 2, 5, 1),
(25, 'D-1188', '2025-12-10 01:29:00.000000', '', 'pendiente', 'Calle 3, 5024', 'Almte. Barroso 76', 5, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_provincia`
--

CREATE TABLE `app1discopro_provincia` (
  `idProvincia` int(11) NOT NULL,
  `nombreProvincia` varchar(100) NOT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_provincia`
--

INSERT INTO `app1discopro_provincia` (`idProvincia`, `nombreProvincia`, `region_id`) VALUES
(1, 'Arica', 1),
(2, 'Iquique', 2),
(3, 'Antofagasta', 3),
(4, 'Copiapó', 4),
(5, 'La Serena', 5),
(6, 'Valparaíso', 6),
(7, 'Santiago', 7),
(8, 'Rancagua', 8),
(9, 'Talca', 9),
(10, 'Chillán', 10),
(11, 'Concepción', 11),
(12, 'Temuco', 12),
(13, 'Valdivia', 13),
(14, 'Puerto Montt', 14),
(15, 'Coyhaique', 15),
(16, 'Punta Arenas', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_region`
--

CREATE TABLE `app1discopro_region` (
  `idRegion` int(11) NOT NULL,
  `nombreRegion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_region`
--

INSERT INTO `app1discopro_region` (`idRegion`, `nombreRegion`) VALUES
(1, 'Arica y Parinacota'),
(2, 'Tarapacá'),
(3, 'Antofagasta'),
(4, 'Atacama'),
(5, 'Coquimbo'),
(6, 'Valparaíso'),
(7, 'Metropolitana de Santiago'),
(8, 'O’Higgins'),
(9, 'Maule'),
(10, 'Ñuble'),
(11, 'Biobío'),
(12, 'La Araucanía'),
(13, 'Los Ríos'),
(14, 'Los Lagos'),
(15, 'Aysén'),
(16, 'Magallanes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_rol`
--

CREATE TABLE `app1discopro_rol` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_rol`
--

INSERT INTO `app1discopro_rol` (`idRol`, `nombreRol`) VALUES
(1, 'Administrador'),
(2, 'Gerente'),
(3, 'Supervisor'),
(4, 'Operador'),
(5, 'Motorista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_tipomovimiento`
--

CREATE TABLE `app1discopro_tipomovimiento` (
  `idTipoMovimiento` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_tipomovimiento`
--

INSERT INTO `app1discopro_tipomovimiento` (`idTipoMovimiento`, `nombre`, `descripcion`) VALUES
(1, 'Directo', NULL),
(2, 'Con receta', NULL),
(3, 'Con traslado', NULL),
(4, 'Con reenvío', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_usuario`
--

CREATE TABLE `app1discopro_usuario` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `rut` varchar(12) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `app1discopro_usuario`
--

INSERT INTO `app1discopro_usuario` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `rut`, `telefono`, `rol_id`) VALUES
(1, 'pbkdf2_sha256$1000000$n3JJHQGT7LSETzRScVTCHi$lI0ZaYOfkAkaJMS3UX+BwRz7Og179jNpk/hJ1lnMCvY=', '2025-12-10 02:22:26.210071', 1, 'admin', '', '', 'admin@discopro.cl', 1, 1, '2025-12-09 03:41:30.879844', NULL, NULL, 1),
(2, 'pbkdf2_sha256$720000$3xH8DLwsjepD3cvPGRaV5M$F2ZxZ1tcHTidI6op0MtMgiFz6EOK7P0RMFcxOUS8MRE=', NULL, 0, 'gerente01', 'Carlos', 'Rojas', 'gerente01@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '13.452.698-5', '987654321', 2),
(3, 'pbkdf2_sha256$720000$Q/JU9tS5DQeCFfEsVPBEWQ$gJWqIeX0gTH7P6va6Q0lMYdRXjG0wxvTJHCMCFoD8O0=', NULL, 0, 'supervisor01', 'Javier', 'Torres', 'supervisor01@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '16.784.552-3', '912345678', 3),
(4, 'pbkdf2_sha256$720000$3xH8DLwsjepD3cvPGRaV5M$F2ZxZ1tcHTidI6op0MtMgiFz6EOK7P0RMFcxOUS8MRE=', NULL, 0, 'op1', 'Claudio', 'Pizarro', 'operario01@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '17.554.662-9', '911111111', 4),
(5, 'pbkdf2_sha256$720000$3xH8DLwsjepD3cvPGRaV5M$F2ZxZ1tcHTidI6op0MtMgiFz6EOK7P0RMFcxOUS8MRE=', NULL, 0, 'op2', 'Marco', 'Figueroa', 'operario02@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '18.332.145-7', '922222222', 4),
(6, 'pbkdf2_sha256$720000$3xH8DLwsjepD3cvPGRaV5M$F2ZxZ1tcHTidI6op0MtMgiFz6EOK7P0RMFcxOUS8MRE=', NULL, 0, 'op3', 'Hernán', 'Córdoba', 'operario03@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '19.226.998-1', '933333333', 4),
(7, 'pbkdf2_sha256$720000$3xH8DLwsjepD3cvPGRaV5M$F2ZxZ1tcHTidI6op0MtMgiFz6EOK7P0RMFcxOUS8MRE=', NULL, 0, 'op4', 'Rodrigo', 'Vega', 'operario04@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '20.124.554-2', '944444444', 4),
(8, 'pbkdf2_sha256$720000$Q/JU9tS5DQeCFfEsVPBEWQ$gJWqIeX0gTH7P6va6Q0lMYdRXjG0wxvTJHCMCFoD8O0=', NULL, 0, 'op5', 'Julio', 'Martínez', 'operario05@discopro.cl', 0, 1, '2025-12-09 06:39:12.000000', '21.887.662-5', '955555555', 4),
(9, 'pbkdf2_sha256$1000000$6jcN6HSgQTHB68OUw7ys3g$Iex80Pm3xh+xKfICcFXopHobogfR8dNAlloLQEkGums=', NULL, 0, 'admin123', 'Alvaro Mario', 'Vergara Ñanculef', 'alvaro.vergara.nanculef@gmail.com', 0, 1, '2025-12-09 22:05:32.386820', '20.000.000-0', '+56922334455', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_usuario_groups`
--

CREATE TABLE `app1discopro_usuario_groups` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app1discopro_usuario_user_permissions`
--

CREATE TABLE `app1discopro_usuario_user_permissions` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Administrador'),
(2, 'Gerente'),
(5, 'Motorista'),
(4, 'Operador'),
(3, 'Supervisor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add comuna', 6, 'add_comuna'),
(22, 'Can change comuna', 6, 'change_comuna'),
(23, 'Can delete comuna', 6, 'delete_comuna'),
(24, 'Can view comuna', 6, 'view_comuna'),
(25, 'Can add moto', 7, 'add_moto'),
(26, 'Can change moto', 7, 'change_moto'),
(27, 'Can delete moto', 7, 'delete_moto'),
(28, 'Can view moto', 7, 'view_moto'),
(29, 'Can add provincia', 8, 'add_provincia'),
(30, 'Can change provincia', 8, 'change_provincia'),
(31, 'Can delete provincia', 8, 'delete_provincia'),
(32, 'Can view provincia', 8, 'view_provincia'),
(33, 'Can add region', 9, 'add_region'),
(34, 'Can change region', 9, 'change_region'),
(35, 'Can delete region', 9, 'delete_region'),
(36, 'Can view region', 9, 'view_region'),
(37, 'Can add rol', 10, 'add_rol'),
(38, 'Can change rol', 10, 'change_rol'),
(39, 'Can delete rol', 10, 'delete_rol'),
(40, 'Can view rol', 10, 'view_rol'),
(41, 'Can add tipo movimiento', 11, 'add_tipomovimiento'),
(42, 'Can change tipo movimiento', 11, 'change_tipomovimiento'),
(43, 'Can delete tipo movimiento', 11, 'delete_tipomovimiento'),
(44, 'Can view tipo movimiento', 11, 'view_tipomovimiento'),
(45, 'Can add Usuario', 12, 'add_usuario'),
(46, 'Can change Usuario', 12, 'change_usuario'),
(47, 'Can delete Usuario', 12, 'delete_usuario'),
(48, 'Can view Usuario', 12, 'view_usuario'),
(49, 'Can add farmacia', 13, 'add_farmacia'),
(50, 'Can change farmacia', 13, 'change_farmacia'),
(51, 'Can delete farmacia', 13, 'delete_farmacia'),
(52, 'Can view farmacia', 13, 'view_farmacia'),
(53, 'Can add mantenimiento', 14, 'add_mantenimiento'),
(54, 'Can change mantenimiento', 14, 'change_mantenimiento'),
(55, 'Can delete mantenimiento', 14, 'delete_mantenimiento'),
(56, 'Can view mantenimiento', 14, 'view_mantenimiento'),
(57, 'Can add documentacion moto', 15, 'add_documentacionmoto'),
(58, 'Can change documentacion moto', 15, 'change_documentacionmoto'),
(59, 'Can delete documentacion moto', 15, 'delete_documentacionmoto'),
(60, 'Can view documentacion moto', 15, 'view_documentacionmoto'),
(61, 'Can add motorista', 16, 'add_motorista'),
(62, 'Can change motorista', 16, 'change_motorista'),
(63, 'Can delete motorista', 16, 'delete_motorista'),
(64, 'Can view motorista', 16, 'view_motorista'),
(65, 'Can add documentacion', 17, 'add_documentacion'),
(66, 'Can change documentacion', 17, 'change_documentacion'),
(67, 'Can delete documentacion', 17, 'delete_documentacion'),
(68, 'Can view documentacion', 17, 'view_documentacion'),
(69, 'Can add contacto emergencia', 18, 'add_contactoemergencia'),
(70, 'Can change contacto emergencia', 18, 'change_contactoemergencia'),
(71, 'Can delete contacto emergencia', 18, 'delete_contactoemergencia'),
(72, 'Can view contacto emergencia', 18, 'view_contactoemergencia'),
(73, 'Can add asignacion moto', 19, 'add_asignacionmoto'),
(74, 'Can change asignacion moto', 19, 'change_asignacionmoto'),
(75, 'Can delete asignacion moto', 19, 'delete_asignacionmoto'),
(76, 'Can view asignacion moto', 19, 'view_asignacionmoto'),
(77, 'Can add asignacion farmacia', 20, 'add_asignacionfarmacia'),
(78, 'Can change asignacion farmacia', 20, 'change_asignacionfarmacia'),
(79, 'Can delete asignacion farmacia', 20, 'delete_asignacionfarmacia'),
(80, 'Can view asignacion farmacia', 20, 'view_asignacionfarmacia'),
(81, 'Can add Movimiento', 21, 'add_movimiento'),
(82, 'Can change Movimiento', 21, 'change_movimiento'),
(83, 'Can delete Movimiento', 21, 'delete_movimiento'),
(84, 'Can view Movimiento', 21, 'view_movimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(20, 'app1Discopro', 'asignacionfarmacia'),
(19, 'app1Discopro', 'asignacionmoto'),
(6, 'app1Discopro', 'comuna'),
(18, 'app1Discopro', 'contactoemergencia'),
(17, 'app1Discopro', 'documentacion'),
(15, 'app1Discopro', 'documentacionmoto'),
(13, 'app1Discopro', 'farmacia'),
(14, 'app1Discopro', 'mantenimiento'),
(7, 'app1Discopro', 'moto'),
(16, 'app1Discopro', 'motorista'),
(21, 'app1Discopro', 'movimiento'),
(8, 'app1Discopro', 'provincia'),
(9, 'app1Discopro', 'region'),
(10, 'app1Discopro', 'rol'),
(11, 'app1Discopro', 'tipomovimiento'),
(12, 'app1Discopro', 'usuario'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-12-09 03:39:33.583069'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-12-09 03:39:33.626562'),
(3, 'auth', '0001_initial', '2025-12-09 03:39:33.780238'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-12-09 03:39:33.811573'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-12-09 03:39:33.816516'),
(6, 'auth', '0004_alter_user_username_opts', '2025-12-09 03:39:33.821758'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-12-09 03:39:33.826360'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-12-09 03:39:33.828540'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-12-09 03:39:33.832918'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-12-09 03:39:33.839435'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-12-09 03:39:33.844587'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-12-09 03:39:33.863241'),
(13, 'auth', '0011_update_proxy_permissions', '2025-12-09 03:39:33.868660'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-12-09 03:39:33.884792'),
(15, 'app1Discopro', '0001_initial', '2025-12-09 03:39:34.808238'),
(16, 'admin', '0001_initial', '2025-12-09 03:39:34.893575'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-12-09 03:39:34.901653'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-09 03:39:34.911052'),
(19, 'sessions', '0001_initial', '2025-12-09 03:39:34.943156'),
(20, 'app1Discopro', '0002_alter_movimiento_estado', '2025-12-10 00:35:09.742553'),
(21, 'app1Discopro', '0003_alter_movimiento_numero_despacho', '2025-12-10 01:00:43.484221');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('03xeij3jzbebjexcgsorlg60g59m5jjw', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vSyKq:sN54z8lOZinI_fMYngh370DEk_3ChE3cPXOc0sx3HfY', '2025-12-09 14:35:00.269273'),
('2cq6lkn8q5xhox5nharqwjoc7gwyskd1', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vT8lU:BKtLT9az7l-VQIt6978VJ04Wu9nmCLwjQiWWMCnglLE', '2025-12-10 01:43:12.250319'),
('2nntl75w7wdhxzgoz0nahqlqdsfk8ye7', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vT81U:3u-sbbwlZCPCYYmwk481QYH44oDqSSxYvzukX8V46Zw', '2025-12-10 00:55:40.541032'),
('9whxmcon63xpxlbg5u9la424geucuq8u', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vSvtk:MsLiBrEmTtbFv5MImH4ljgmRCWr4E0CUzLX1Cq867aw', '2025-12-09 11:58:52.899691'),
('aeuktirrxkp5sl91l41598xtmrvthl26', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vT942:Fc2nw0lse50f1O5Zd9NwNDOw8AuTWgYzvLouzb06hdY', '2025-12-10 02:02:22.105544'),
('eohd7lqs49fplwvghzcnlm0l7y8tnux3', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vSozv:oNQJB4clQVCwH9d8c0TLvivDo4iYWRm56eg2P7ngTNQ', '2025-12-09 04:36:47.324516'),
('g51wvhpmr46pkepyfwkwt4u0rz9yys29', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vT7tW:yh4aYq6WVzMuLrSa6GCpuJGpp_-zgaR-2ghm0vQRxOk', '2025-12-10 00:47:26.834608'),
('mszgflrudzcy9gwp44ujphlgijkhzc7k', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vT9o8:xrzN34LexI1mnbZ_S80XguoMOf5gVbwuzj4ZqQ8PCvA', '2025-12-10 02:50:00.867027'),
('udfdsrl373rog3q5xps9giagdqc0zed6', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vSxLx:jgYhMC6aI4mGCaQvZJtEX6pshdRsjEeIQuKUrTac9Xs', '2025-12-09 13:32:05.313987'),
('w073ta9o14ellev4nw96x02o6ll8sl5c', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vT9HG:-xdnEUsCCJRdLZHEudTLNSqwNMUkHIv3sHkATQLr1Nw', '2025-12-10 02:16:02.570376'),
('yj0x9e8gkipsmiu4365zr0qf6ryljdxd', '.eJxVjL0OwiAURt-F2TTlHxyNjsbJmVzgNjS2hYCdjO9uTTroer7vnBdxsD6TWxtWN0ZyJJQcfpmH8MDlO0Ap9Dy2kEvN3Y5bd5lhnG71vn0XmPGaI06n3fkLJWhpqzDGgjbMe06F6j1VWqP0PPYsKBUpWM0VGiFxUCJwI9DKGE0Qg-ZWaKDk_QHTvjpM:1vSzDo:f5BvuIlQpPP4QJxleyqEGchRsffL0wt9w00ZwbSNBhk', '2025-12-09 15:31:48.990336');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `app1discopro_asignacionfarmacia`
--
ALTER TABLE `app1discopro_asignacionfarmacia`
  ADD PRIMARY KEY (`idAsignacionFarmacia`),
  ADD KEY `app1Discopro_asignac_farmacia_id_fc901314_fk_app1Disco` (`farmacia_id`),
  ADD KEY `app1Discopro_asignac_motorista_id_a2bd9cf6_fk_app1Disco` (`motorista_id`);

--
-- Indices de la tabla `app1discopro_asignacionmoto`
--
ALTER TABLE `app1discopro_asignacionmoto`
  ADD PRIMARY KEY (`idAsignacionMoto`),
  ADD KEY `app1Discopro_asignac_moto_id_98817818_fk_app1Disco` (`moto_id`),
  ADD KEY `app1Discopro_asignac_motorista_id_315754b6_fk_app1Disco` (`motorista_id`);

--
-- Indices de la tabla `app1discopro_comuna`
--
ALTER TABLE `app1discopro_comuna`
  ADD PRIMARY KEY (`idComuna`),
  ADD KEY `app1Discopro_comuna_provincia_id_454a4d0e_fk_app1Disco` (`provincia_id`);

--
-- Indices de la tabla `app1discopro_contactoemergencia`
--
ALTER TABLE `app1discopro_contactoemergencia`
  ADD PRIMARY KEY (`idContacto`),
  ADD KEY `app1Discopro_contact_motorista_id_1d2434fe_fk_app1Disco` (`motorista_id`);

--
-- Indices de la tabla `app1discopro_documentacion`
--
ALTER TABLE `app1discopro_documentacion`
  ADD PRIMARY KEY (`idDocumentacion`),
  ADD KEY `app1Discopro_documen_motorista_id_c462d370_fk_app1Disco` (`motorista_id`);

--
-- Indices de la tabla `app1discopro_documentacionmoto`
--
ALTER TABLE `app1discopro_documentacionmoto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `moto_id` (`moto_id`);

--
-- Indices de la tabla `app1discopro_farmacia`
--
ALTER TABLE `app1discopro_farmacia`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `app1Discopro_farmaci_comuna_id_140c2d95_fk_app1Disco` (`comuna_id`);

--
-- Indices de la tabla `app1discopro_mantenimiento`
--
ALTER TABLE `app1discopro_mantenimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app1Discopro_manteni_moto_id_f02c145f_fk_app1Disco` (`moto_id`);

--
-- Indices de la tabla `app1discopro_moto`
--
ALTER TABLE `app1discopro_moto`
  ADD PRIMARY KEY (`patente`);

--
-- Indices de la tabla `app1discopro_motorista`
--
ALTER TABLE `app1discopro_motorista`
  ADD PRIMARY KEY (`codigo`),
  ADD UNIQUE KEY `rut` (`rut`),
  ADD KEY `app1Discopro_motoris_comuna_id_791ad158_fk_app1Disco` (`comuna_id`);

--
-- Indices de la tabla `app1discopro_movimiento`
--
ALTER TABLE `app1discopro_movimiento`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `app1Discopro_movimie_motorista_asignado_i_e9ac9251_fk_app1Disco` (`motorista_asignado_id`),
  ADD KEY `app1Discopro_movimie_movimiento_padre_id_c209e247_fk_app1Disco` (`movimiento_padre_id`),
  ADD KEY `app1Discopro_movimie_usuario_responsable__31e1818e_fk_app1Disco` (`usuario_responsable_id`),
  ADD KEY `app1Discopro_movimie_tipo_movimiento_id_30b6b0de_fk_app1Disco` (`tipo_movimiento_id`);

--
-- Indices de la tabla `app1discopro_provincia`
--
ALTER TABLE `app1discopro_provincia`
  ADD PRIMARY KEY (`idProvincia`),
  ADD KEY `app1Discopro_provinc_region_id_28ba4bc6_fk_app1Disco` (`region_id`);

--
-- Indices de la tabla `app1discopro_region`
--
ALTER TABLE `app1discopro_region`
  ADD PRIMARY KEY (`idRegion`);

--
-- Indices de la tabla `app1discopro_rol`
--
ALTER TABLE `app1discopro_rol`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `app1discopro_tipomovimiento`
--
ALTER TABLE `app1discopro_tipomovimiento`
  ADD PRIMARY KEY (`idTipoMovimiento`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `app1discopro_usuario`
--
ALTER TABLE `app1discopro_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `rut` (`rut`),
  ADD KEY `app1Discopro_usuario_rol_id_a78a3dce_fk_app1Discopro_rol_idRol` (`rol_id`);

--
-- Indices de la tabla `app1discopro_usuario_groups`
--
ALTER TABLE `app1discopro_usuario_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app1Discopro_usuario_groups_usuario_id_group_id_d89e1f2c_uniq` (`usuario_id`,`group_id`),
  ADD KEY `app1Discopro_usuario_groups_group_id_e8593a5c_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `app1discopro_usuario_user_permissions`
--
ALTER TABLE `app1discopro_usuario_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app1Discopro_usuario_use_usuario_id_permission_id_64be42a6_uniq` (`usuario_id`,`permission_id`),
  ADD KEY `app1Discopro_usuario_permission_id_c4ecc6de_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_app1Discopro_usuario_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `app1discopro_asignacionfarmacia`
--
ALTER TABLE `app1discopro_asignacionfarmacia`
  MODIFY `idAsignacionFarmacia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `app1discopro_asignacionmoto`
--
ALTER TABLE `app1discopro_asignacionmoto`
  MODIFY `idAsignacionMoto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `app1discopro_comuna`
--
ALTER TABLE `app1discopro_comuna`
  MODIFY `idComuna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `app1discopro_contactoemergencia`
--
ALTER TABLE `app1discopro_contactoemergencia`
  MODIFY `idContacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `app1discopro_documentacion`
--
ALTER TABLE `app1discopro_documentacion`
  MODIFY `idDocumentacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app1discopro_documentacionmoto`
--
ALTER TABLE `app1discopro_documentacionmoto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `app1discopro_farmacia`
--
ALTER TABLE `app1discopro_farmacia`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `app1discopro_mantenimiento`
--
ALTER TABLE `app1discopro_mantenimiento`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `app1discopro_motorista`
--
ALTER TABLE `app1discopro_motorista`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `app1discopro_movimiento`
--
ALTER TABLE `app1discopro_movimiento`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `app1discopro_provincia`
--
ALTER TABLE `app1discopro_provincia`
  MODIFY `idProvincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `app1discopro_region`
--
ALTER TABLE `app1discopro_region`
  MODIFY `idRegion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `app1discopro_rol`
--
ALTER TABLE `app1discopro_rol`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `app1discopro_tipomovimiento`
--
ALTER TABLE `app1discopro_tipomovimiento`
  MODIFY `idTipoMovimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `app1discopro_usuario`
--
ALTER TABLE `app1discopro_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `app1discopro_usuario_groups`
--
ALTER TABLE `app1discopro_usuario_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app1discopro_usuario_user_permissions`
--
ALTER TABLE `app1discopro_usuario_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `app1discopro_asignacionfarmacia`
--
ALTER TABLE `app1discopro_asignacionfarmacia`
  ADD CONSTRAINT `app1Discopro_asignac_farmacia_id_fc901314_fk_app1Disco` FOREIGN KEY (`farmacia_id`) REFERENCES `app1discopro_farmacia` (`codigo`),
  ADD CONSTRAINT `app1Discopro_asignac_motorista_id_a2bd9cf6_fk_app1Disco` FOREIGN KEY (`motorista_id`) REFERENCES `app1discopro_motorista` (`codigo`);

--
-- Filtros para la tabla `app1discopro_asignacionmoto`
--
ALTER TABLE `app1discopro_asignacionmoto`
  ADD CONSTRAINT `app1Discopro_asignac_moto_id_98817818_fk_app1Disco` FOREIGN KEY (`moto_id`) REFERENCES `app1discopro_moto` (`patente`),
  ADD CONSTRAINT `app1Discopro_asignac_motorista_id_315754b6_fk_app1Disco` FOREIGN KEY (`motorista_id`) REFERENCES `app1discopro_motorista` (`codigo`);

--
-- Filtros para la tabla `app1discopro_comuna`
--
ALTER TABLE `app1discopro_comuna`
  ADD CONSTRAINT `app1Discopro_comuna_provincia_id_454a4d0e_fk_app1Disco` FOREIGN KEY (`provincia_id`) REFERENCES `app1discopro_provincia` (`idProvincia`);

--
-- Filtros para la tabla `app1discopro_contactoemergencia`
--
ALTER TABLE `app1discopro_contactoemergencia`
  ADD CONSTRAINT `app1Discopro_contact_motorista_id_1d2434fe_fk_app1Disco` FOREIGN KEY (`motorista_id`) REFERENCES `app1discopro_motorista` (`codigo`);

--
-- Filtros para la tabla `app1discopro_documentacion`
--
ALTER TABLE `app1discopro_documentacion`
  ADD CONSTRAINT `app1Discopro_documen_motorista_id_c462d370_fk_app1Disco` FOREIGN KEY (`motorista_id`) REFERENCES `app1discopro_motorista` (`codigo`);

--
-- Filtros para la tabla `app1discopro_documentacionmoto`
--
ALTER TABLE `app1discopro_documentacionmoto`
  ADD CONSTRAINT `app1Discopro_documen_moto_id_0f3b968b_fk_app1Disco` FOREIGN KEY (`moto_id`) REFERENCES `app1discopro_moto` (`patente`);

--
-- Filtros para la tabla `app1discopro_farmacia`
--
ALTER TABLE `app1discopro_farmacia`
  ADD CONSTRAINT `app1Discopro_farmaci_comuna_id_140c2d95_fk_app1Disco` FOREIGN KEY (`comuna_id`) REFERENCES `app1discopro_comuna` (`idComuna`);

--
-- Filtros para la tabla `app1discopro_mantenimiento`
--
ALTER TABLE `app1discopro_mantenimiento`
  ADD CONSTRAINT `app1Discopro_manteni_moto_id_f02c145f_fk_app1Disco` FOREIGN KEY (`moto_id`) REFERENCES `app1discopro_moto` (`patente`);

--
-- Filtros para la tabla `app1discopro_motorista`
--
ALTER TABLE `app1discopro_motorista`
  ADD CONSTRAINT `app1Discopro_motoris_comuna_id_791ad158_fk_app1Disco` FOREIGN KEY (`comuna_id`) REFERENCES `app1discopro_comuna` (`idComuna`);

--
-- Filtros para la tabla `app1discopro_movimiento`
--
ALTER TABLE `app1discopro_movimiento`
  ADD CONSTRAINT `app1Discopro_movimie_motorista_asignado_i_e9ac9251_fk_app1Disco` FOREIGN KEY (`motorista_asignado_id`) REFERENCES `app1discopro_motorista` (`codigo`),
  ADD CONSTRAINT `app1Discopro_movimie_movimiento_padre_id_c209e247_fk_app1Disco` FOREIGN KEY (`movimiento_padre_id`) REFERENCES `app1discopro_movimiento` (`id_movimiento`),
  ADD CONSTRAINT `app1Discopro_movimie_tipo_movimiento_id_30b6b0de_fk_app1Disco` FOREIGN KEY (`tipo_movimiento_id`) REFERENCES `app1discopro_tipomovimiento` (`idTipoMovimiento`),
  ADD CONSTRAINT `app1Discopro_movimie_usuario_responsable__31e1818e_fk_app1Disco` FOREIGN KEY (`usuario_responsable_id`) REFERENCES `app1discopro_usuario` (`id`);

--
-- Filtros para la tabla `app1discopro_provincia`
--
ALTER TABLE `app1discopro_provincia`
  ADD CONSTRAINT `app1Discopro_provinc_region_id_28ba4bc6_fk_app1Disco` FOREIGN KEY (`region_id`) REFERENCES `app1discopro_region` (`idRegion`);

--
-- Filtros para la tabla `app1discopro_usuario`
--
ALTER TABLE `app1discopro_usuario`
  ADD CONSTRAINT `app1Discopro_usuario_rol_id_a78a3dce_fk_app1Discopro_rol_idRol` FOREIGN KEY (`rol_id`) REFERENCES `app1discopro_rol` (`idRol`);

--
-- Filtros para la tabla `app1discopro_usuario_groups`
--
ALTER TABLE `app1discopro_usuario_groups`
  ADD CONSTRAINT `app1Discopro_usuario_groups_group_id_e8593a5c_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `app1Discopro_usuario_usuario_id_df7e129a_fk_app1Disco` FOREIGN KEY (`usuario_id`) REFERENCES `app1discopro_usuario` (`id`);

--
-- Filtros para la tabla `app1discopro_usuario_user_permissions`
--
ALTER TABLE `app1discopro_usuario_user_permissions`
  ADD CONSTRAINT `app1Discopro_usuario_permission_id_c4ecc6de_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `app1Discopro_usuario_usuario_id_d1d56215_fk_app1Disco` FOREIGN KEY (`usuario_id`) REFERENCES `app1discopro_usuario` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_app1Discopro_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `app1discopro_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
