-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 14-02-2025 a las 02:06:52
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agrosoftnode`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `id` int NOT NULL,
  `fk_Cultivos` int NOT NULL,
  `fk_Usuarios` bigint NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('Asignada','Completada','Cancelada') NOT NULL DEFAULT (_cp850'Asignada')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id`, `fk_Cultivos`, `fk_Usuarios`, `titulo`, `descripcion`, `fecha`, `estado`) VALUES
(1, 1, 1012345876, 'Preparación de suelo', 'Preparar el suelo para la siembra', '2025-02-01', 'Asignada'),
(2, 2, 1047384923, 'Siembra de maíz', 'Realizar la siembra de semillas de maíz', '2025-02-02', 'Completada'),
(3, 3, 1067324819, 'Riego', 'Riego inicial del cultivo', '2025-02-03', 'Asignada'),
(4, 1, 1070598678, 'Aplicación de fertilizante', 'Fertilización del cultivo', '2025-02-04', 'Asignada'),
(5, 2, 1078236459, 'Control de plagas', 'Inspección y control de plagas', '2025-02-05', 'Cancelada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `afecciones`
--

CREATE TABLE `afecciones` (
  `id` int NOT NULL,
  `fk_Plantaciones` int NOT NULL,
  `fk_Plagas` int NOT NULL,
  `fechaEncuentro` date NOT NULL,
  `estado` enum('SinTratamiento','EnControl','Eliminado') NOT NULL DEFAULT (_cp850'SinTratamiento')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `afecciones`
--

INSERT INTO `afecciones` (`id`, `fk_Plantaciones`, `fk_Plagas`, `fechaEncuentro`, `estado`) VALUES
(1, 1, 1, '2025-02-01', 'SinTratamiento'),
(2, 2, 2, '2025-02-05', 'SinTratamiento'),
(3, 3, 3, '2025-02-10', 'EnControl'),
(4, 4, 4, '2025-02-15', 'Eliminado'),
(5, 5, 5, '2025-02-20', 'EnControl');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controles`
--

CREATE TABLE `controles` (
  `id` int NOT NULL,
  `fk_Afecciones` int NOT NULL,
  `fk_TiposControl` int NOT NULL,
  `descripcion` text NOT NULL,
  `fechaControl` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `controles`
--

INSERT INTO `controles` (`id`, `fk_Afecciones`, `fk_TiposControl`, `descripcion`, `fechaControl`) VALUES
(1, 1, 2, 'Aplicación de insecticida contra pulgón', '2025-02-02'),
(2, 2, 1, 'Uso de hongos benéficos contra mildiu', '2025-02-06'),
(3, 3, 3, 'Rotación de cultivos para reducir bacterias', '2025-02-11'),
(4, 4, 4, 'Eliminación manual de hojas infectadas', '2025-02-16'),
(5, 5, 5, 'Uso de variedades resistentes', '2025-02-21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cosechas`
--

CREATE TABLE `cosechas` (
  `id` int NOT NULL,
  `fk_Cultivos` int NOT NULL,
  `unidades` int NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cosechas`
--

INSERT INTO `cosechas` (`id`, `fk_Cultivos`, `unidades`, `fecha`) VALUES
(1, 1, 50, '2024-01-10'),
(2, 2, 40, '2024-01-15'),
(3, 3, 60, '2024-01-20'),
(4, 4, 55, '2024-01-25'),
(5, 5, 45, '2024-01-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cultivos`
--

CREATE TABLE `cultivos` (
  `id` int NOT NULL,
  `fk_Especies` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `unidades` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT (1),
  `fechaSiembra` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cultivos`
--

INSERT INTO `cultivos` (`id`, `fk_Especies`, `nombre`, `unidades`, `activo`, `fechaSiembra`) VALUES
(1, 1, 'Cultivo de Tomates', 80, 1, '2025-02-05'),
(2, 2, 'Cultivo de Manzanas', 40, 1, '2025-02-15'),
(3, 3, 'Cultivo de Maíz', 180, 1, '2025-01-25'),
(4, 4, 'Cultivo de Frijoles', 130, 1, '2025-02-20'),
(5, 5, 'Cultivo de Papas', 110, 1, '2025-03-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desechos`
--

CREATE TABLE `desechos` (
  `id` int NOT NULL,
  `fk_Cultivos` int NOT NULL,
  `fk_TiposDesecho` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `desechos`
--

INSERT INTO `desechos` (`id`, `fk_Cultivos`, `fk_TiposDesecho`, `nombre`, `descripcion`) VALUES
(1, 1, 1, 'Hojas caídas', 'Residuos orgánicos de la cosecha'),
(2, 2, 2, 'Bolsas plásticas', 'Empaques de insumos agrícolas'),
(3, 3, 3, 'Trozos de alambre', 'Residuos de estructuras de soporte'),
(4, 4, 4, 'Frascos de vidrio', 'Envases de productos agrícolas'),
(5, 5, 5, 'Cajas de cartón', 'Empaques utilizados en la recolección de productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eras`
--

CREATE TABLE `eras` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `tamX` decimal(3,2) NOT NULL,
  `tamY` decimal(3,2) NOT NULL,
  `posX` decimal(3,2) NOT NULL,
  `posY` decimal(3,2) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT (1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `eras`
--

INSERT INTO `eras` (`id`, `fk_Lotes`, `tamX`, `tamY`, `posX`, `posY`, `estado`) VALUES
(1, 1, 1.00, 1.00, 2.00, 5.00, 0),
(2, 2, 1.00, 1.00, 1.00, 1.00, 1),
(3, 3, 2.00, 2.00, 1.50, 1.50, 0),
(4, 5, 1.00, 1.00, 2.00, 2.00, 1),
(5, 4, 1.00, 1.00, 2.50, 2.50, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especies`
--

CREATE TABLE `especies` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `tiempoCrecimiento` int NOT NULL,
  `fk_TiposEspecie` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `especies`
--

INSERT INTO `especies` (`id`, `nombre`, `descripcion`, `img`, `tiempoCrecimiento`, `fk_TiposEspecie`) VALUES
(1, 'Tomate', 'Planta de frutos rojos comestibles', 'tomate.jpg', 90, 1),
(2, 'Manzano', 'Árbol frutal que produce manzanas', 'manzano.jpg', 365, 2),
(3, 'Maíz', 'Cereal ampliamente cultivado para alimento humano y animal', 'maiz.jpg', 120, 3),
(4, 'Frijol', 'Planta leguminosa productora de granos comestibles', 'frijol.jpg', 80, 4),
(5, 'Papa', 'Planta de tubérculo comestible', 'papa.jpg', 100, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evapotranspiraciones`
--

CREATE TABLE `evapotranspiraciones` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `fecha` datetime NOT NULL,
  `milimetrosMCuadrado` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `evapotranspiraciones`
--

INSERT INTO `evapotranspiraciones` (`id`, `fk_Lotes`, `fecha`, `milimetrosMCuadrado`) VALUES
(1, 1, '2025-02-10 00:00:00', 4),
(2, 2, '2025-02-11 00:00:00', 4),
(3, 3, '2025-02-12 00:00:00', 4),
(4, 4, '2025-02-13 00:00:00', 4),
(5, 5, '2025-02-14 00:00:00', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramientas`
--

CREATE TABLE `herramientas` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `unidades` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `herramientas`
--

INSERT INTO `herramientas` (`id`, `fk_Lotes`, `nombre`, `descripcion`, `unidades`) VALUES
(1, 1, 'Azadón', 'Herramienta para remover tierra', 10),
(2, 2, 'Rastrillo', 'Herramienta para nivelar el suelo', 15),
(3, 3, 'Pala', 'Herramienta para cavar', 20),
(4, 4, 'Carretilla', 'Para transportar materiales', 5),
(5, 5, 'Manguera', 'Para riego del cultivo', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horasmensuales`
--

CREATE TABLE `horasmensuales` (
  `id` int NOT NULL,
  `fk_Pasantes` int NOT NULL,
  `minutos` int NOT NULL,
  `salario` int NOT NULL,
  `mes` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `horasmensuales`
--

INSERT INTO `horasmensuales` (`id`, `fk_Pasantes`, `minutos`, `salario`, `mes`) VALUES
(1, 1, 480, 96000, 'marzo'),
(2, 1, 520, 104000, 'marzo'),
(3, 1, 500, 100000, 'abril'),
(4, 1, 530, 106000, 'abril'),
(5, 1, 510, 102000, 'mayo'),
(6, 1, 540, 108000, 'mayo'),
(7, 1, 520, 104000, 'junio'),
(8, 1, 550, 110000, 'junio'),
(9, 1, 530, 106000, 'julio'),
(10, 1, 560, 112000, 'julio'),
(11, 2, 450, 67500, 'febrer'),
(12, 2, 470, 70500, 'febrer'),
(13, 2, 460, 69000, 'marzo'),
(14, 2, 480, 72000, 'marzo'),
(15, 2, 470, 70500, 'abril'),
(16, 2, 490, 73500, 'abril'),
(17, 2, 480, 72000, 'mayo'),
(18, 2, 500, 75000, 'mayo'),
(19, 2, 490, 73500, 'junio'),
(20, 2, 510, 76500, 'junio'),
(21, 3, 600, 150000, 'enero'),
(22, 3, 620, 155000, 'enero'),
(23, 3, 610, 152500, 'febrer'),
(24, 3, 630, 157500, 'febrer'),
(25, 3, 620, 155000, 'marzo'),
(76, 3, 640, 160000, 'marzo'),
(77, 3, 630, 157500, 'abril'),
(78, 3, 650, 162500, 'abril'),
(79, 3, 640, 160000, 'mayo'),
(80, 3, 660, 165000, 'mayo'),
(81, 4, 400, 46667, 'abril'),
(82, 4, 420, 49000, 'abril'),
(83, 4, 410, 47833, 'mayo'),
(84, 4, 430, 50167, 'mayo'),
(85, 4, 420, 49000, 'junio'),
(86, 4, 440, 51400, 'junio'),
(87, 4, 430, 50167, 'julio'),
(88, 4, 450, 52500, 'julio'),
(89, 4, 440, 51400, 'agosto'),
(90, 4, 460, 53833, 'agosto'),
(91, 5, 550, 123750, 'mayo'),
(92, 5, 570, 128250, 'mayo'),
(93, 5, 560, 126000, 'junio'),
(94, 5, 580, 130500, 'junio'),
(95, 5, 570, 128250, 'julio'),
(96, 5, 590, 132750, 'julio'),
(97, 5, 580, 130500, 'agosto'),
(98, 5, 600, 135000, 'agosto'),
(99, 5, 590, 132750, 'septi'),
(100, 5, 610, 137250, 'septi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `humedadambiental`
--

CREATE TABLE `humedadambiental` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `fecha` datetime NOT NULL,
  `porcentaje` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `humedadambiental`
--

INSERT INTO `humedadambiental` (`id`, `fk_Lotes`, `fecha`, `porcentaje`) VALUES
(1, 1, '2025-02-10 00:00:00', 60),
(2, 2, '2025-02-11 00:00:00', 55),
(3, 3, '2025-02-12 00:00:00', 65),
(4, 4, '2025-02-13 00:00:00', 58),
(5, 5, '2025-02-14 00:00:00', 62),
(6, 1, '2025-02-11 00:00:00', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `humedadterreno`
--

CREATE TABLE `humedadterreno` (
  `id` int NOT NULL,
  `fk_Eras` int NOT NULL,
  `porcentaje` int NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `humedadterreno`
--

INSERT INTO `humedadterreno` (`id`, `fk_Eras`, `porcentaje`, `fecha`) VALUES
(1, 1, 31, '2024-02-12 00:00:00'),
(2, 2, 35, '2024-02-11 00:00:00'),
(3, 3, 29, '2024-02-10 00:00:00'),
(4, 4, 40, '2024-02-09 00:00:00'),
(5, 5, 32, '2024-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `iluminaciones`
--

CREATE TABLE `iluminaciones` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `fecha` datetime NOT NULL,
  `lumens` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `iluminaciones`
--

INSERT INTO `iluminaciones` (`id`, `fk_Lotes`, `fecha`, `lumens`) VALUES
(1, 1, '2025-02-10 00:00:00', 15000),
(2, 2, '2025-02-11 00:00:00', 14000),
(3, 3, '2025-02-12 00:00:00', 16000),
(4, 4, '2025-02-13 00:00:00', 15500),
(5, 5, '2025-02-14 00:00:00', 14500);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `precio` int NOT NULL,
  `unidades` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `insumos`
--

INSERT INTO `insumos` (`id`, `nombre`, `descripcion`, `precio`, `unidades`) VALUES
(1, 'Fertilizante A', 'Fertilizante para crecimiento', 50000, 100),
(2, 'Herbicida B', 'Control de malezas', 70000, 50),
(3, 'Semilla de maíz', 'Semillas de alta calidad', 200000, 100),
(4, 'Fungicida C', 'Protección contra hongos', 80000, 30),
(5, 'Insecticida D', 'Control de insectos', 60000, 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

CREATE TABLE `lotes` (
  `id` int NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `descripcion` text NOT NULL,
  `tamX` tinyint NOT NULL,
  `tamY` tinyint NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT (1),
  `posX` decimal(3,2) NOT NULL,
  `posY` decimal(3,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id`, `nombre`, `descripcion`, `tamX`, `tamY`, `estado`, `posX`, `posY`) VALUES
(1, 'Lote A', 'Lote para cultivo de hortalizas', 50, 50, 1, 1.00, 2.00),
(2, 'Lote B', 'Lote para cultivo de frutales', 60, 60, 0, 3.00, 3.00),
(3, 'Lote C', 'Lote para cultivo de cereales', 70, 70, 1, 2.00, 3.00),
(4, 'Lote D', 'Lote para cultivo de leguminosas', 40, 40, 0, 2.50, 2.00),
(5, 'Lote E', 'Lote para cultivo de tubérculos', 55, 55, 0, 2.30, 1.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasantes`
--

CREATE TABLE `pasantes` (
  `id` int NOT NULL,
  `fk_Usuarios` bigint NOT NULL,
  `fechaInicioPasantia` date NOT NULL,
  `fechaFinalizacion` date NOT NULL,
  `salarioHora` int NOT NULL,
  `area` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `pasantes`
--

INSERT INTO `pasantes` (`id`, `fk_Usuarios`, `fechaInicioPasantia`, `fechaFinalizacion`, `salarioHora`, `area`) VALUES
(1, 1012345876, '2025-03-01', '2025-08-31', 12000, 'Café'),
(2, 1047384923, '2025-02-15', '2025-07-15', 9000, 'Platanal'),
(3, 1067324819, '2025-01-10', '2025-06-10', 15000, 'Horticultura'),
(4, 1070598678, '2025-04-01', '2025-09-30', 7000, 'Café'),
(5, 1078236459, '2025-05-20', '2025-10-20', 13500, 'Platanal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `phs`
--

CREATE TABLE `phs` (
  `id` int NOT NULL,
  `fk_Eras` int NOT NULL,
  `acidez` int NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `phs`
--

INSERT INTO `phs` (`id`, `fk_Eras`, `acidez`, `fecha`) VALUES
(1, 1, 7, '2024-02-12 00:00:00'),
(2, 2, 7, '2024-02-11 00:00:00'),
(3, 3, 6, '2024-02-10 00:00:00'),
(4, 4, 6, '2024-02-09 00:00:00'),
(5, 5, 7, '2024-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plagas`
--

CREATE TABLE `plagas` (
  `id` int NOT NULL,
  `fk_TiposPlaga` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `plagas`
--

INSERT INTO `plagas` (`id`, `fk_TiposPlaga`, `nombre`, `descripcion`, `img`) VALUES
(1, 1, 'Pulgón', 'Insecto que se alimenta de la savia', 'pulgon.jpg'),
(2, 2, 'Mildiu', 'Hongo que produce manchas amarillas', 'mildiu.jpg'),
(3, 3, 'Xanthomonas', 'Bacteria que provoca manchas necróticas', 'xanthomonas.jpg'),
(4, 4, 'Virus del mosaico', 'Provoca deformación y manchas en hojas', 'virusmosaico.jpg'),
(5, 5, 'Meloidogyne', 'Nematodo que causa nudos en raíces', 'meloidogyne.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantaciones`
--

CREATE TABLE `plantaciones` (
  `id` int NOT NULL,
  `fk_Cultivos` int NOT NULL,
  `fk_Eras` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `plantaciones`
--

INSERT INTO `plantaciones` (`id`, `fk_Cultivos`, `fk_Eras`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precipitaciones`
--

CREATE TABLE `precipitaciones` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `fecha` datetime NOT NULL,
  `mm` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `precipitaciones`
--

INSERT INTO `precipitaciones` (`id`, `fk_Lotes`, `fecha`, `mm`) VALUES
(1, 1, '2025-02-10 00:00:00', 13),
(2, 2, '2025-02-11 00:00:00', 8),
(3, 3, '2025-02-12 00:00:00', 15),
(4, 4, '2025-02-13 00:00:00', 10),
(5, 5, '2025-02-14 00:00:00', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoscontrol`
--

CREATE TABLE `productoscontrol` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `precio` int NOT NULL,
  `compuestoActivo` varchar(20) NOT NULL,
  `fichaTecnica` text NOT NULL,
  `contenido` int NOT NULL,
  `tipoContenido` varchar(10) NOT NULL,
  `unidades` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `productoscontrol`
--

INSERT INTO `productoscontrol` (`id`, `nombre`, `precio`, `compuestoActivo`, `fichaTecnica`, `contenido`, `tipoContenido`, `unidades`) VALUES
(1, 'Insecticida A', 15000, 'Imidacloprid', 'insecticidaA.pdf', 500, 'ml', 10),
(2, 'Fungicida B', 20000, 'Azoxistrobin', 'fungicidaB.pdf', 1, 'L', 5),
(3, 'Bactericida C', 25000, 'Cobre', 'bactericidaC.pdf', 2, 'kg', 8),
(4, 'Aceite Mineral', 12000, 'Aceite de neem', 'aceiteNeem.pdf', 1, 'L', 6),
(5, 'Trichoderma', 30000, 'Hongos benéficos', 'trichoderma.pdf', 1, 'kg', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `semilleros`
--

CREATE TABLE `semilleros` (
  `id` int NOT NULL,
  `fk_Especies` int NOT NULL,
  `unidades` int NOT NULL,
  `fechaSiembra` date NOT NULL,
  `fechaEstimada` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `semilleros`
--

INSERT INTO `semilleros` (`id`, `fk_Especies`, `unidades`, `fechaSiembra`, `fechaEstimada`) VALUES
(1, 1, 100, '2025-02-01', '2025-04-01'),
(2, 2, 50, '2025-02-10', '2026-02-10'),
(3, 3, 200, '2025-01-20', '2025-05-20'),
(4, 4, 150, '2025-02-15', '2025-05-06'),
(5, 5, 120, '2025-03-01', '2025-06-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temperaturas`
--

CREATE TABLE `temperaturas` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `gradosC` tinyint NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `temperaturas`
--

INSERT INTO `temperaturas` (`id`, `fk_Lotes`, `gradosC`, `fecha`) VALUES
(1, 1, 29, '2025-02-10 00:00:00'),
(2, 2, 30, '2025-02-11 00:00:00'),
(3, 3, 26, '2025-02-12 00:00:00'),
(4, 4, 27, '2025-02-13 00:00:00'),
(5, 5, 30, '2025-02-14 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposcontrol`
--

CREATE TABLE `tiposcontrol` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tiposcontrol`
--

INSERT INTO `tiposcontrol` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Biológico', 'Control de plagas mediante organismos vivos'),
(2, 'Químico', 'Uso de productos químicos para erradicación'),
(3, 'Cultural', 'Modificación del entorno para evitar plagas'),
(4, 'Mecánico', 'Eliminación manual de plagas'),
(5, 'Genético', 'Uso de variedades resistentes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposdesecho`
--

CREATE TABLE `tiposdesecho` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tiposdesecho`
--

INSERT INTO `tiposdesecho` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Orgánico', 'Desechos biodegradables provenientes de cultivos'),
(2, 'Plástico', 'Residuos plásticos utilizados en la agricultura'),
(3, 'Metal', 'Desechos de herramientas y maquinaria'),
(4, 'Vidrio', 'Botellas y otros elementos de vidrio descartados'),
(5, 'Papel', 'Desechos de papel y cartón utilizados en empaques');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposespecie`
--

CREATE TABLE `tiposespecie` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tiposespecie`
--

INSERT INTO `tiposespecie` (`id`, `nombre`, `descripcion`, `img`) VALUES
(1, 'Hortaliza', 'Plantas cultivadas para consumo alimenticio', 'hortaliza.jpg'),
(2, 'Frutal', 'Árboles y arbustos que producen frutos comestibles', 'frutal.jpg'),
(3, 'Cereal', 'Plantas gramíneas cultivadas por su grano', 'cereal.jpg'),
(4, 'Leguminosa', 'Plantas que producen legumbres', 'leguminosa.jpg'),
(5, 'Tubérculo', 'Plantas que producen raíces o tubérculos comestibles', 'tuberculo.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposplaga`
--

CREATE TABLE `tiposplaga` (
  `id` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tiposplaga`
--

INSERT INTO `tiposplaga` (`id`, `nombre`, `descripcion`, `img`) VALUES
(1, 'Insectos', 'Plagas causadas por insectos como pulgones y trips', 'insectos.jpg'),
(2, 'Hongos', 'Plagas fúngicas como mildiu y roya', 'hongos.jpg'),
(3, 'Bacterias', 'Plagas bacterianas que afectan las plantas', 'bacterias.jpg'),
(4, 'Virus', 'Plagas virales como mosaicos y virosis', 'virus.jpg'),
(5, 'Nematodos', 'Plagas de gusanos microscópicos en las raíces', 'nematodos.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usoproductocontrol`
--

CREATE TABLE `usoproductocontrol` (
  `id` int NOT NULL,
  `fk_ProductosControl` int NOT NULL,
  `fk_Controles` int NOT NULL,
  `cantidadProducto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usoproductocontrol`
--

INSERT INTO `usoproductocontrol` (`id`, `fk_ProductosControl`, `fk_Controles`, `cantidadProducto`) VALUES
(1, 1, 1, 50),
(2, 2, 2, 30),
(3, 3, 3, 20),
(4, 4, 4, 40),
(5, 5, 5, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usosherramientas`
--

CREATE TABLE `usosherramientas` (
  `id` int NOT NULL,
  `fk_Herramientas` int NOT NULL,
  `fk_Actividades` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usosherramientas`
--

INSERT INTO `usosherramientas` (`id`, `fk_Herramientas`, `fk_Actividades`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usosproductos`
--

CREATE TABLE `usosproductos` (
  `id` int NOT NULL,
  `fk_Insumos` int NOT NULL,
  `fk_Actividades` int NOT NULL,
  `cantidadProducto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usosproductos`
--

INSERT INTO `usosproductos` (`id`, `fk_Insumos`, `fk_Actividades`, `cantidadProducto`) VALUES
(1, 1, 1, 10),
(2, 2, 2, 5),
(3, 3, 3, 20),
(4, 4, 4, 15),
(5, 5, 5, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `identificacion` bigint NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correoElectronico` varchar(200) NOT NULL,
  `passwordHash` varchar(60) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT (0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`identificacion`, `nombre`, `apellidos`, `fechaNacimiento`, `telefono`, `correoElectronico`, `passwordHash`, `admin`) VALUES
(1012345876, 'José Andrés', 'Torres Gómez', '1993-08-05', '3198765432', 'jose.torres@outlook.com', '$2b$10$zDjs2Rhr5Me1RIRVOho22.PEiyfXGhyjqqH8/97Z4ItNdwAqQEyM2', 0),
(1047384923, 'Carlos Alberto', 'Martínez Pérez', '1998-07-15', '3156541234', 'carlos.martinez@gmail.com', '$2b$10$GEBmV98qtkLVPzg1cD9MaO1Fd1fty8k78DNSQTWwJrQQxw3ra5OwG', 0),
(1067324819, 'Luis Eduardo', 'González Sánchez', '1995-05-30', '3125674321', 'luis.gonzalez@yahoo.com', '$2b$10$rragh/Cbg4eYcEy76SZZnO1Twi7L8DfexfUfkCieY8t0rowAYrPfS', 0),
(1070598678, 'Estefany Daniela', 'Parada Escalante', '2007-11-11', '3201236789', 'stefanny@gmail.com', '$2b$10$NuDI8gjzB5Ekc2n3RrEAQuaU36vCmAlevP2fGLpaWQsAK.DmMgpYe', 0),
(1078236459, 'Felipe Javier', 'Cabrera García', '2001-12-18', '3141236789', 'felipe.cabrera@hotmail.com', '$2b$10$J178o3sQVGNy4wH5kxS9UOQrWU0f7mXvBLyNifaEaQu.TuFSyF48G', 0),
(1079534351, 'Luis Alejandro', 'Bonilla Echeverri', '2005-02-06', '3202615357', 'alendroideyt@gmail.com', '$2b$10$BUVewugF4WT9tZKTClxwMeZaYgigr7R1i.3s3RayvkcB6VFKCC0o6', 1),
(1083869594, 'Sergio Augusto', 'García Murcia', '2005-01-20', '3134325678', 'augusto@gmail.com', '$2b$10$kCfnTZRiNjQc6ysXhEqtLuKjanXKwCJGsUxzj9n01PaO2ssyEWrRC', 0),
(1098753467, 'María Fernanda', 'Hernández Romero', '2000-11-10', '3134567890', 'maria.hernandez@gmail.com', '$2b$10$4qDl0CoijKZUzJhJNr0yo.kf/.avlWzDK1Hn7fo2nY7taFgalvqzy', 0),
(1129456781, 'Ana Lucía', 'Ramírez López', '2002-03-22', '3147896543', 'ana.ramirez@hotmail.com', '$2b$10$CdtlbTQie26DjZn/zJFR4e9hVXnoKTU7EQrsTtdyl0XKffbfvDMJC', 0),
(1135674928, 'Isabella Sofía', 'Pérez Ruiz', '2004-02-28', '3187456321', 'isabella.perez@gmail.com', '$2b$10$PNre9gUkOIHn0eJawTn7Ne8olrIRipl2d.tsmp400zqmEXlLCwpDO', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `velocidadviento`
--

CREATE TABLE `velocidadviento` (
  `id` int NOT NULL,
  `fk_Lotes` int NOT NULL,
  `fecha` datetime NOT NULL,
  `kilomhora` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `velocidadviento`
--

INSERT INTO `velocidadviento` (`id`, `fk_Lotes`, `fecha`, `kilomhora`) VALUES
(1, 1, '2025-02-10 00:00:00', 13),
(2, 2, '2025-02-11 00:00:00', 14),
(3, 3, '2025-02-12 00:00:00', 11),
(4, 4, '2025-02-13 00:00:00', 13),
(5, 5, '2025-02-14 00:00:00', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int NOT NULL,
  `fk_Cosechas` int NOT NULL,
  `precioUnitario` int NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `fk_Cosechas`, `precioUnitario`, `fecha`) VALUES
(1, 1, 11, '2024-02-01'),
(2, 2, 12, '2024-02-05'),
(3, 3, 11, '2024-02-10'),
(4, 4, 10, '2024-02-15'),
(5, 5, 13, '2024-02-20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cultivos` (`fk_Cultivos`),
  ADD KEY `fk_Usuarios` (`fk_Usuarios`);

--
-- Indices de la tabla `afecciones`
--
ALTER TABLE `afecciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Plantaciones` (`fk_Plantaciones`),
  ADD KEY `fk_Plagas` (`fk_Plagas`);

--
-- Indices de la tabla `controles`
--
ALTER TABLE `controles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Afecciones` (`fk_Afecciones`),
  ADD KEY `fk_TiposControl` (`fk_TiposControl`);

--
-- Indices de la tabla `cosechas`
--
ALTER TABLE `cosechas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cultivos` (`fk_Cultivos`);

--
-- Indices de la tabla `cultivos`
--
ALTER TABLE `cultivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Especies` (`fk_Especies`);

--
-- Indices de la tabla `desechos`
--
ALTER TABLE `desechos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cultivos` (`fk_Cultivos`),
  ADD KEY `fk_TiposDesecho` (`fk_TiposDesecho`);

--
-- Indices de la tabla `eras`
--
ALTER TABLE `eras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `especies`
--
ALTER TABLE `especies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `esUna` (`fk_TiposEspecie`);

--
-- Indices de la tabla `evapotranspiraciones`
--
ALTER TABLE `evapotranspiraciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `horasmensuales`
--
ALTER TABLE `horasmensuales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Pasantes` (`fk_Pasantes`);

--
-- Indices de la tabla `humedadambiental`
--
ALTER TABLE `humedadambiental`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `humedadterreno`
--
ALTER TABLE `humedadterreno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Eras` (`fk_Eras`);

--
-- Indices de la tabla `iluminaciones`
--
ALTER TABLE `iluminaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pasantes`
--
ALTER TABLE `pasantes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Usuarios` (`fk_Usuarios`);

--
-- Indices de la tabla `phs`
--
ALTER TABLE `phs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Eras` (`fk_Eras`);

--
-- Indices de la tabla `plagas`
--
ALTER TABLE `plagas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_TiposPlaga` (`fk_TiposPlaga`);

--
-- Indices de la tabla `plantaciones`
--
ALTER TABLE `plantaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cultivos` (`fk_Cultivos`),
  ADD KEY `fk_Eras` (`fk_Eras`);

--
-- Indices de la tabla `precipitaciones`
--
ALTER TABLE `precipitaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `productoscontrol`
--
ALTER TABLE `productoscontrol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `semilleros`
--
ALTER TABLE `semilleros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `esDe` (`fk_Especies`);

--
-- Indices de la tabla `temperaturas`
--
ALTER TABLE `temperaturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `tiposcontrol`
--
ALTER TABLE `tiposcontrol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiposdesecho`
--
ALTER TABLE `tiposdesecho`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiposespecie`
--
ALTER TABLE `tiposespecie`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiposplaga`
--
ALTER TABLE `tiposplaga`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usoproductocontrol`
--
ALTER TABLE `usoproductocontrol`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ProductosControl` (`fk_ProductosControl`),
  ADD KEY `fk_Controles` (`fk_Controles`);

--
-- Indices de la tabla `usosherramientas`
--
ALTER TABLE `usosherramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Herramientas` (`fk_Herramientas`),
  ADD KEY `fk_Actividades` (`fk_Actividades`);

--
-- Indices de la tabla `usosproductos`
--
ALTER TABLE `usosproductos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Insumos` (`fk_Insumos`),
  ADD KEY `fk_Actividades` (`fk_Actividades`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`identificacion`);

--
-- Indices de la tabla `velocidadviento`
--
ALTER TABLE `velocidadviento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Lotes` (`fk_Lotes`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Cosechas` (`fk_Cosechas`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `afecciones`
--
ALTER TABLE `afecciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `controles`
--
ALTER TABLE `controles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cosechas`
--
ALTER TABLE `cosechas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cultivos`
--
ALTER TABLE `cultivos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `desechos`
--
ALTER TABLE `desechos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `eras`
--
ALTER TABLE `eras`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `especies`
--
ALTER TABLE `especies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `evapotranspiraciones`
--
ALTER TABLE `evapotranspiraciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horasmensuales`
--
ALTER TABLE `horasmensuales`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `humedadambiental`
--
ALTER TABLE `humedadambiental`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `humedadterreno`
--
ALTER TABLE `humedadterreno`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `iluminaciones`
--
ALTER TABLE `iluminaciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pasantes`
--
ALTER TABLE `pasantes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `phs`
--
ALTER TABLE `phs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `plagas`
--
ALTER TABLE `plagas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `plantaciones`
--
ALTER TABLE `plantaciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `precipitaciones`
--
ALTER TABLE `precipitaciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productoscontrol`
--
ALTER TABLE `productoscontrol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `semilleros`
--
ALTER TABLE `semilleros`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `temperaturas`
--
ALTER TABLE `temperaturas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tiposcontrol`
--
ALTER TABLE `tiposcontrol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tiposdesecho`
--
ALTER TABLE `tiposdesecho`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tiposespecie`
--
ALTER TABLE `tiposespecie`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tiposplaga`
--
ALTER TABLE `tiposplaga`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usoproductocontrol`
--
ALTER TABLE `usoproductocontrol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usosherramientas`
--
ALTER TABLE `usosherramientas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usosproductos`
--
ALTER TABLE `usosproductos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `velocidadviento`
--
ALTER TABLE `velocidadviento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`fk_Cultivos`) REFERENCES `cultivos` (`id`),
  ADD CONSTRAINT `actividades_ibfk_2` FOREIGN KEY (`fk_Usuarios`) REFERENCES `usuarios` (`identificacion`);

--
-- Filtros para la tabla `afecciones`
--
ALTER TABLE `afecciones`
  ADD CONSTRAINT `afecciones_ibfk_1` FOREIGN KEY (`fk_Plantaciones`) REFERENCES `plantaciones` (`id`),
  ADD CONSTRAINT `afecciones_ibfk_2` FOREIGN KEY (`fk_Plagas`) REFERENCES `plagas` (`id`);

--
-- Filtros para la tabla `controles`
--
ALTER TABLE `controles`
  ADD CONSTRAINT `controles_ibfk_1` FOREIGN KEY (`fk_Afecciones`) REFERENCES `afecciones` (`id`),
  ADD CONSTRAINT `controles_ibfk_2` FOREIGN KEY (`fk_TiposControl`) REFERENCES `tiposcontrol` (`id`);

--
-- Filtros para la tabla `cosechas`
--
ALTER TABLE `cosechas`
  ADD CONSTRAINT `cosechas_ibfk_1` FOREIGN KEY (`fk_Cultivos`) REFERENCES `cultivos` (`id`);

--
-- Filtros para la tabla `cultivos`
--
ALTER TABLE `cultivos`
  ADD CONSTRAINT `cultivos_ibfk_1` FOREIGN KEY (`fk_Especies`) REFERENCES `especies` (`id`);

--
-- Filtros para la tabla `desechos`
--
ALTER TABLE `desechos`
  ADD CONSTRAINT `desechos_ibfk_1` FOREIGN KEY (`fk_Cultivos`) REFERENCES `cultivos` (`id`),
  ADD CONSTRAINT `desechos_ibfk_2` FOREIGN KEY (`fk_TiposDesecho`) REFERENCES `tiposdesecho` (`id`);

--
-- Filtros para la tabla `eras`
--
ALTER TABLE `eras`
  ADD CONSTRAINT `eras_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `especies`
--
ALTER TABLE `especies`
  ADD CONSTRAINT `esUna` FOREIGN KEY (`fk_TiposEspecie`) REFERENCES `tiposespecie` (`id`);

--
-- Filtros para la tabla `evapotranspiraciones`
--
ALTER TABLE `evapotranspiraciones`
  ADD CONSTRAINT `evapotranspiraciones_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `herramientas`
--
ALTER TABLE `herramientas`
  ADD CONSTRAINT `herramientas_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `horasmensuales`
--
ALTER TABLE `horasmensuales`
  ADD CONSTRAINT `horasmensuales_ibfk_1` FOREIGN KEY (`fk_Pasantes`) REFERENCES `pasantes` (`id`);

--
-- Filtros para la tabla `humedadambiental`
--
ALTER TABLE `humedadambiental`
  ADD CONSTRAINT `humedadambiental_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `humedadterreno`
--
ALTER TABLE `humedadterreno`
  ADD CONSTRAINT `humedadterreno_ibfk_1` FOREIGN KEY (`fk_Eras`) REFERENCES `eras` (`id`);

--
-- Filtros para la tabla `iluminaciones`
--
ALTER TABLE `iluminaciones`
  ADD CONSTRAINT `iluminaciones_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `pasantes`
--
ALTER TABLE `pasantes`
  ADD CONSTRAINT `pasantes_ibfk_1` FOREIGN KEY (`fk_Usuarios`) REFERENCES `usuarios` (`identificacion`);

--
-- Filtros para la tabla `phs`
--
ALTER TABLE `phs`
  ADD CONSTRAINT `phs_ibfk_1` FOREIGN KEY (`fk_Eras`) REFERENCES `eras` (`id`);

--
-- Filtros para la tabla `plagas`
--
ALTER TABLE `plagas`
  ADD CONSTRAINT `plagas_ibfk_1` FOREIGN KEY (`fk_TiposPlaga`) REFERENCES `tiposplaga` (`id`);

--
-- Filtros para la tabla `plantaciones`
--
ALTER TABLE `plantaciones`
  ADD CONSTRAINT `plantaciones_ibfk_1` FOREIGN KEY (`fk_Cultivos`) REFERENCES `cultivos` (`id`),
  ADD CONSTRAINT `plantaciones_ibfk_2` FOREIGN KEY (`fk_Eras`) REFERENCES `eras` (`id`);

--
-- Filtros para la tabla `precipitaciones`
--
ALTER TABLE `precipitaciones`
  ADD CONSTRAINT `precipitaciones_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `semilleros`
--
ALTER TABLE `semilleros`
  ADD CONSTRAINT `esDe` FOREIGN KEY (`fk_Especies`) REFERENCES `especies` (`id`);

--
-- Filtros para la tabla `temperaturas`
--
ALTER TABLE `temperaturas`
  ADD CONSTRAINT `temperaturas_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `usoproductocontrol`
--
ALTER TABLE `usoproductocontrol`
  ADD CONSTRAINT `usoproductocontrol_ibfk_1` FOREIGN KEY (`fk_ProductosControl`) REFERENCES `productoscontrol` (`id`),
  ADD CONSTRAINT `usoproductocontrol_ibfk_2` FOREIGN KEY (`fk_Controles`) REFERENCES `controles` (`id`);

--
-- Filtros para la tabla `usosherramientas`
--
ALTER TABLE `usosherramientas`
  ADD CONSTRAINT `usosherramientas_ibfk_1` FOREIGN KEY (`fk_Herramientas`) REFERENCES `herramientas` (`id`),
  ADD CONSTRAINT `usosherramientas_ibfk_2` FOREIGN KEY (`fk_Actividades`) REFERENCES `actividades` (`id`);

--
-- Filtros para la tabla `usosproductos`
--
ALTER TABLE `usosproductos`
  ADD CONSTRAINT `usosproductos_ibfk_1` FOREIGN KEY (`fk_Insumos`) REFERENCES `insumos` (`id`),
  ADD CONSTRAINT `usosproductos_ibfk_2` FOREIGN KEY (`fk_Actividades`) REFERENCES `actividades` (`id`);

--
-- Filtros para la tabla `velocidadviento`
--
ALTER TABLE `velocidadviento`
  ADD CONSTRAINT `velocidadviento_ibfk_1` FOREIGN KEY (`fk_Lotes`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`fk_Cosechas`) REFERENCES `cosechas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
