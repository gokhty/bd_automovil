-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2018 a las 09:54:42
-- Versión del servidor: 5.6.26
-- Versión de PHP: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `autoexpres1`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cancelarReserva`(id int)
begin
update reserva set estado = '0' where id =  id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkInAuto`(idR int,idRep char(8))
begin
-- estado
-- 0 activo
-- 1 finalizado
insert into recepcionReserva values (null,idR, idRep, 0);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkOutAuto`(idR int,idRep char(8))
begin
-- estado
-- 0 activo
-- 1 finalizado
update recepcionReserva set estado = 1 where idReserva = idR;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaAutomovilDisponible`(ini date, fin date)
begin
select * from automovil where matricula not in(select idAuto from reserva r where 
ini between fechaIni and fechaFin
or
fin between fechaIni and fechaFin
or 
fechaIni >= ini and fechaFin <=fin
and
r.estado = '1');
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaReserva`(cli char(9))
begin
select * from reserva where
id not in (select id from recepcionReserva)
and
idCliente = cli order by fechaIni desc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recepcionReserva`(cli char(9),idR int)
begin
select rr.*, r.fechaIni, r.fechaFin from recepcionReserva rr
join reserva r
on rr.idReserva = r.id
where rr.estado = 0 and (r.idCliente = cli or rr.idReserva = idR) order by fechaIni desc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registraReservaAutomovil`(cli char(9), movil char(7),ini date,fin date)
begin
-- 0 disponible
-- 1 reservado

	insert into reserva values(null, cli, movil, ini, fin,'1');

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_volverAbrirReserva`(id int)
begin
update reserva set estado = '1' where id =  id;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `automovil`
--

CREATE TABLE IF NOT EXISTS `automovil` (
  `matricula` char(7) NOT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `anno` int(11) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `foto` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `automovil`
--

INSERT INTO `automovil` (`matricula`, `modelo`, `anno`, `precio`, `foto`) VALUES
('ABC-931', 'sony 3', 2017, 300, 'image/amarillo.jpg'),
('ABC-A32', 'pun racer', 2007, 400, 'image/blanco.jpg'),
('CC1-2AA', 'orion 45', 2001, 100, 'image/negro.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `licencia` char(9) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`licencia`, `nombre`, `email`, `telefono`, `pass`) VALUES
('G71962605', NULL, NULL, NULL, '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepcionista`
--

CREATE TABLE IF NOT EXISTS `recepcionista` (
  `dni` char(8) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `recepcionista`
--

INSERT INTO `recepcionista` (`dni`, `nombre`, `pass`) VALUES
('12345671', 'Ana', 'Au3Qr11'),
('12345672', 'Maria', 'Mu3Qr11'),
('12345678', 'luisa', 'Lu3Qr11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepcionreserva`
--

CREATE TABLE IF NOT EXISTS `recepcionreserva` (
  `id` int(11) NOT NULL,
  `idReserva` int(11) DEFAULT NULL,
  `idRecepcionista` char(8) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE IF NOT EXISTS `reserva` (
  `id` int(11) NOT NULL,
  `idCliente` char(9) DEFAULT NULL,
  `idAuto` char(7) DEFAULT NULL,
  `fechaIni` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`id`, `idCliente`, `idAuto`, `fechaIni`, `fechaFin`, `estado`) VALUES
(1, 'G71962605', 'ABC-931', '2018-11-24', '2018-11-25', '1'),
(2, 'G71962605', 'CC1-2AA', '2018-12-01', '2018-12-02', '1'),
(3, 'G71962605', 'ABC-A32', '2018-11-27', '2018-11-28', '1'),
(4, 'G71962605', 'CC1-2AA', '2019-11-24', '2019-11-27', '1'),
(5, 'G71962605', 'CC1-2AA', '2018-11-06', '2018-11-29', '1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `automovil`
--
ALTER TABLE `automovil`
  ADD PRIMARY KEY (`matricula`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`licencia`);

--
-- Indices de la tabla `recepcionista`
--
ALTER TABLE `recepcionista`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `recepcionreserva`
--
ALTER TABLE `recepcionreserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idReserva` (`idReserva`),
  ADD KEY `idRecepcionista` (`idRecepcionista`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idAuto` (`idAuto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `recepcionreserva`
--
ALTER TABLE `recepcionreserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `recepcionreserva`
--
ALTER TABLE `recepcionreserva`
  ADD CONSTRAINT `recepcionreserva_ibfk_1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`id`),
  ADD CONSTRAINT `recepcionreserva_ibfk_2` FOREIGN KEY (`idRecepcionista`) REFERENCES `recepcionista` (`dni`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`licencia`),
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`idAuto`) REFERENCES `automovil` (`matricula`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
