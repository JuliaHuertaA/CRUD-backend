-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2021 a las 03:01:52
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cajamorelia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `detalleCliente` (IN `idClientes` INT)  BEGIN
    SELECT idCliente, nombre, apellidoPaterno, apellidoMaterno, rfc, curp FROM tbl_cmv_cliente WHERE idCliente = idClientes;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `detalleCuenta` (IN `idClientes` INT)  BEGIN
    SELECT cat.nombreCuenta, tblcc.saldoActual, tblcc.fechaContratacion, tblcc.fechaUltimoMovimiento from tbl_cmv_cliente_cuenta tblcc INNER JOIN cat_cmv_tipo_cuenta cat on tblcc.idCuenta = cat.idCuenta WHERE tblcc.idCliente = idClientes;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editarInformacionClientes` (`idClientes` INT, `nvo_nombre` VARCHAR(30), `nvo_ap` VARCHAR(30), `nvo_am` VARCHAR(50), `nvo_rfc` VARCHAR(50), `nvo_curp` VARCHAR(50))  BEGIN
    UPDATE tbl_cmv_cliente set nombre = nvo_nombre , apellidoPaterno = nvo_ap, apellidoMaterno = nvo_am ,rfc = nvo_rfc, curp = nvo_curp where idCliente = idClientes;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCliente` (`idClientes` INT)  BEGIN
    DELETE from tbl_cmv_cliente WHERE idCliente = idClientes;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarClientes` ()  BEGIN
    SELECT idCliente, nombre, apellidoPaterno, apellidoMaterno FROM tbl_cmv_cliente;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_cmv_tipo_cuenta`
--

CREATE TABLE `cat_cmv_tipo_cuenta` (
  `idCuenta` int(11) NOT NULL,
  `nombreCuenta` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cat_cmv_tipo_cuenta`
--

INSERT INTO `cat_cmv_tipo_cuenta` (`idCuenta`, `nombreCuenta`) VALUES
(2, 'Abicuenta'),
(3, 'Ahorro'),
(4, 'Inverdinamica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cmv_cliente`
--

CREATE TABLE `tbl_cmv_cliente` (
  `idCliente` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellidoPaterno` varchar(30) NOT NULL,
  `apellidoMaterno` varchar(50) NOT NULL,
  `rfc` varchar(50) NOT NULL,
  `curp` varchar(50) NOT NULL,
  `fechaAlta` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_cmv_cliente`
--

INSERT INTO `tbl_cmv_cliente` (`idCliente`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `rfc`, `curp`, `fechaAlta`) VALUES
(3, 'joel', 'Ortiz', 'joel', 'joel', '12345679851JAJAJA', '2021-06-24 13:00:00'),
(4, 'valeria sarahi', 'huerta', 'alvarez', 'CUTU809825569', 'VAAL981122MMNRLL08', '2021-06-24 13:03:00'),
(9, 'Maria Guadalupe', 'Araiza', 'Loaiza', 'MAGR2587415', 'MAAL951234MMNRLL06', '2021-06-25 15:39:07'),
(10, 'Adrian', 'Mendez', 'Rosales', 'ADMR1524789653', 'ADMR941025HMNRLL9', '2021-06-25 15:50:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cmv_cliente_cuenta`
--

CREATE TABLE `tbl_cmv_cliente_cuenta` (
  `idClienteCuenta` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idCuenta` int(11) NOT NULL,
  `saldoActual` float NOT NULL,
  `fechaContratacion` datetime NOT NULL,
  `fechaUltimoMovimiento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_cmv_cliente_cuenta`
--

INSERT INTO `tbl_cmv_cliente_cuenta` (`idClienteCuenta`, `idCliente`, `idCuenta`, `saldoActual`, `fechaContratacion`, `fechaUltimoMovimiento`) VALUES
(1, 3, 2, 1257.3, '2021-06-24 13:00:00', '2021-06-24 13:10:00'),
(2, 4, 3, 58742.6, '2021-06-24 13:03:00', '2021-06-24 14:52:10'),
(7, 10, 4, 78444.4, '2021-06-25 15:43:14', '2021-06-26 15:43:14'),
(8, 9, 3, 58999.2, '2021-06-23 15:43:14', '2021-06-25 15:43:14');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cat_cmv_tipo_cuenta`
--
ALTER TABLE `cat_cmv_tipo_cuenta`
  ADD PRIMARY KEY (`idCuenta`);

--
-- Indices de la tabla `tbl_cmv_cliente`
--
ALTER TABLE `tbl_cmv_cliente`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `tbl_cmv_cliente_cuenta`
--
ALTER TABLE `tbl_cmv_cliente_cuenta`
  ADD PRIMARY KEY (`idClienteCuenta`),
  ADD KEY `fk_idCliente` (`idCliente`),
  ADD KEY `fk_idCuenta` (`idCuenta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cat_cmv_tipo_cuenta`
--
ALTER TABLE `cat_cmv_tipo_cuenta`
  MODIFY `idCuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbl_cmv_cliente`
--
ALTER TABLE `tbl_cmv_cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_cmv_cliente_cuenta`
--
ALTER TABLE `tbl_cmv_cliente_cuenta`
  MODIFY `idClienteCuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_cmv_cliente_cuenta`
--
ALTER TABLE `tbl_cmv_cliente_cuenta`
  ADD CONSTRAINT `fk_idCliente` FOREIGN KEY (`idCliente`) REFERENCES `tbl_cmv_cliente` (`idCliente`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_idCuenta` FOREIGN KEY (`idCuenta`) REFERENCES `cat_cmv_tipo_cuenta` (`idCuenta`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
