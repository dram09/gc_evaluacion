-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 15-07-2024 a las 02:57:02
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `grupocastores`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_ABC_Productos` (IN `opcion` INT, IN `nombre` VARCHAR(255), IN `precio` DECIMAL(12,2), IN `cantidad` INT, IN `estatus` BIT, IN `usuins` INT, IN `id` INT)  BEGIN
	-- SECCION PARA DETECTAR SI OCURRE UN ERROR DURANTE LA EJECUCION DE LAS INSTRUCCIONES EN EL PROCEDIMIENTO ALMACENADO
	DECLARE code_number 	 VARCHAR(10) DEFAULT '00000';
    DECLARE number_condition INT;
	DECLARE msg_diagnostic 	 TEXT;
    DECLARE id_temp 		 INT DEFAULT 0;
   
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
     
		GET CURRENT DIAGNOSTICS number_condition = NUMBER;
		GET CURRENT DIAGNOSTICS CONDITION number_condition
        
		code_number    =	MYSQL_ERRNO, 
		msg_diagnostic = MESSAGE_TEXT;
   
        
        SELECT code_number,msg_diagnostic;
        
    END;
    
    -- ISERTAR UN NUEVO PRODUCTO
	IF opcion = 1 THEN
    
			INSERT INTO `grupocastores`.`tbl_productos`
				(`nombre`,
				`precio`,
				`stock`,
				`usuins`,
				`fecins`,
				`usuupd`,
				`fecupd`,
				`activo`)
			VALUES
				(nombre,
				precio,
				0,
				usuins,
				SYSDATE(),
				usuins,
				'0000-00-00 00:00:00',
				1);
                
			SELECT 1 Result;
            
    END IF;
    
     -- ACTUALIZAR UN PRODUCTO
    IF opcion = 2 THEN
    
		UPDATE `grupocastores`.`tbl_productos`
			SET
			`stock` = (stock + 1),
			`usuupd` = usuins,
			`fecupd` = SYSDATE()
		WHERE `tbl_productos`.`id` = id;
        
        SELECT 1 Result;

    END IF;
    
     -- ACTUALIZAR EL ESTATUS DE UN PRODUCTO
    IF opcion = 3 THEN
    
		UPDATE `grupocastores`.`tbl_productos`
			SET
			`activo` = estatus,
			`usuupd` = usuins,
			`fecupd` = SYSDATE()
		WHERE `tbl_productos`.`id` = id;
    		
		SELECT 1 Result;
        
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_ABC_Roles` (IN `opcion` INT, IN `nombre` VARCHAR(255), IN `modulos` VARCHAR(255), IN `usuins` INT, IN `id` INT)  BEGIN
	-- SECCION PARA DETECTAR SI OCURRE UN ERROR DURANTE LA EJECUCION DE LAS INSTRUCCIONES EN EL PROCEDIMIENTO ALMACENADO
	DECLARE code_number 	 VARCHAR(10) DEFAULT '00000';
    DECLARE number_condition INT;
	DECLARE msg_diagnostic 	 TEXT;
    DECLARE id_temp 		 INT DEFAULT 0;
   
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
     
		GET CURRENT DIAGNOSTICS number_condition = NUMBER;
		GET CURRENT DIAGNOSTICS CONDITION number_condition
        
		code_number    =	MYSQL_ERRNO, 
		msg_diagnostic = MESSAGE_TEXT;
   
        
        SELECT code_number,msg_diagnostic;
        
    END;
    
	-- ISERTAR UN NUEVO ROL
	IF opcion = 1 THEN
    
		INSERT INTO `grupocastores`.`tbl_roles`
			(`nombre`,
			`modulos`,
			`usuins`,
			`fecins`,
			`usuupd`,
			`fecupd`,
			`activo`)
			VALUES
			(nombre,
			modulos,
			usuins,
			SYSDATE(),
			usuins,
			'0000-00-00 00:00:00',
			1);
		
        SELECT 1 Result;
        
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_ABC_Usuarios` (IN `opcion` INT, IN `id_rol` INT, IN `nombre` VARCHAR(255), IN `apellido_p` VARCHAR(255), IN `apellido_m` VARCHAR(255), IN `correo` VARCHAR(255), IN `usuario` VARCHAR(255), IN `contrasenia` VARCHAR(255), IN `usuins` INT, IN `id` INT)  BEGIN
	-- SECCION PARA DETECTAR SI OCURRE UN ERROR DURANTE LA EJECUCION DE LAS INSTRUCCIONES EN EL PROCEDIMIENTO ALMACENADO
	DECLARE code_number 	 VARCHAR(10) DEFAULT '00000';
    DECLARE number_condition INT;
	DECLARE msg_diagnostic 	 TEXT;
    DECLARE id_temp 		 INT DEFAULT 0;
   
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
     
		GET CURRENT DIAGNOSTICS number_condition = NUMBER;
		GET CURRENT DIAGNOSTICS CONDITION number_condition
        
		code_number    =	MYSQL_ERRNO, 
		msg_diagnostic = MESSAGE_TEXT;
   
        
        SELECT code_number,msg_diagnostic;
        
    END;
    
    -- INGRESAR UN NUEVO USUARIO
	IF opcion = 1 THEN
    
		INSERT INTO `grupocastores`.`tbl_usuarios`
			(`nombre`,
			`apellido_p`,
			`apellido_m`,
			`correo`,
			`usuario`,
			`contrasenia`,
			`id_rol`,
			`usuins`,
			`fecins`,
			`usuupd`,
			`fecupd`,
			`activo`)
			VALUES
			(nombre,
			apellido_p,
			apellido_m,
			correo,
			usuario,
			AES_ENCRYPT(contrasenia,'GC123456'),
			id_rol,
			usuins,
			SYSDATE(),
			usuins,
			'0000-00-00 00:00:00',
			1);
		
        SELECT 1 Result;
        
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_ABC_Ventas` (IN `opcion` INT, IN `id_producto` INT, IN `cantidad` INT, IN `usuins` INT, IN `id` INT)  BEGIN
	-- SECCION PARA DETECTAR SI OCURRE UN ERROR DURANTE LA EJECUCION DE LAS INSTRUCCIONES EN EL PROCEDIMIENTO ALMACENADO
	DECLARE code_number 	 VARCHAR(10) DEFAULT '00000';
    DECLARE number_condition INT;
	DECLARE msg_diagnostic 	 TEXT;
    DECLARE id_temp 		 INT DEFAULT 0;
    
	DECLARE precio_temp DECIMAL(12,2) DEFAULT 0.0;
    DECLARE stock_temp INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
     
		GET CURRENT DIAGNOSTICS number_condition = NUMBER;
		GET CURRENT DIAGNOSTICS CONDITION number_condition
        
		code_number    =	MYSQL_ERRNO, 
		msg_diagnostic = MESSAGE_TEXT;
   
        
        SELECT code_number,msg_diagnostic;
        
    END;
    
	
    -- AGREGAR NUEVA VENTA
	IF opcion = 1 THEN
    
		 SET stock_temp = ( SELECT P.`stock` FROM `tbl_productos` P WHERE P.`id` = id_producto);
         
         IF (stock_temp >= cantidad) THEN
         
			 SET precio_temp =( SELECT P.`precio` FROM `tbl_productos` P WHERE P.`id` = id_producto);
		   
			INSERT INTO `grupocastores`.`tbl_ventas`
					(`id_producto`,
					`precio`,
					`cantidad`,
					`usuins`,
					`fecins`,
					`usuupd`,
					`fecupd`,
					`activo`)
				VALUES
					(id_producto,
					(SELECT P.`precio` FROM `tbl_productos` P WHERE P.`id` = id_producto),
					cantidad,
					usuins,
					SYSDATE(),
					usuins,
					'0000-00-00 00:00:00',
					1);
					
			UPDATE `grupocastores`.`tbl_productos`
				SET
				`stock` = (`stock`-cantidad),
				`usuupd` = usuins,
				`fecupd` = SYSDATE()
			WHERE `tbl_productos`.`id` = id_producto;
			
			SELECT 1 Result;
            
         ELSE
         
			SELECT -1 Result;
            
         END IF;

    END IF;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_Acceso` (IN `opcion` INT, IN `usuario` VARCHAR(255), IN `contrasenia` VARCHAR(255), IN `id` INT)  BEGIN
    -- VALIDAR EL ACCESO AL SISTEMA
	IF opcion = 1 THEN
    
		IF EXISTS (SELECT U.id FROM tbl_usuarios U WHERE U.usuario = usuario AND AES_DECRYPT(U.contrasenia,'GC123456') = contrasenia) THEN
        
			SELECT 	U.`id`,
					U.`nombre`,
					U.`apellido_p`,
					U.`apellido_m`,
					U.`correo`,
					U.`usuario`,
					U.`contrasenia`,
					R.`modulos`
			FROM `grupocastores`.`tbl_usuarios` U
            INNER JOIN `tbl_roles` R ON R.id= U.id_rol 
            WHERE U.`activo` = 1 AND U.`usuario` = usuario AND AES_DECRYPT(U.contrasenia,'GC123456') = contrasenia;
            
		ELSE
			SELECT -1 Result;
        END IF;
	
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_Catalogos` (IN `opcion` INT, IN `id` INT)  BEGIN
	IF opcion = 1 THEN
    
		SELECT 	P.`id`,
				P.`nombre`
		FROM `grupocastores`.`tbl_productos` P
        WHERE P.`activo` = 1;
        
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_Consultas` ()  BEGIN
	CREATE TABLE IF NOT EXISTS productos(
	idProducto 	INT				PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre     	VARCHAR(40) 	NOT NULL,
	precio		DECIMAL(16,2) 	NOT NULL
	);

	CREATE TABLE IF NOT EXISTS ventas(
	idVenta 		INT  PRIMARY KEY AUTO_INCREMENT NOT NULL,
	idProducto		INT  NOT NULL,
	cantidad 		INT,
	FOREIGN KEY(idProducto) REFERENCES productos(idProducto)
	);

	SELECT 
		P.idProducto, 
        P.nombre, 
        P.precio, 
        SUM(V.cantidad) AS cant_productos,
        COUNT(P.idProducto) AS cant_ventas
	FROM productos P 
    INNER JOIN ventas V ON P.idProducto = V.IdProducto
    GROUP BY P.idProducto
    HAVING cant_ventas = 1;
    
	SELECT 
		P.idProducto, 
        P.nombre, 
        P.precio, 
        SUM(V.cantidad) AS cantidad
	FROM productos P 
    INNER JOIN ventas V ON P.idProducto = V.IdProducto
    GROUP BY P.idProducto;
    
	SELECT 
		P.idProducto, 
        P.nombre, 
        P.precio, 
        SUM(V.cantidad) AS cantidad,
		SUM(P.precio*V.cantidad) AS total
	FROM productos P 
    LEFT JOIN ventas V ON P.idProducto = V.IdProducto
    GROUP BY P.idProducto;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_GET_Productos` (IN `opcion` INT, IN `estatus` INT)  BEGIN
	-- OBTENER PRODUCTOS
	IF opcion = 1 THEN
    
		SELECT 	P.`id`,
				P.`nombre`,
				P.`precio`,
				P.`stock`,
				P.`activo`
		FROM `grupocastores`.`tbl_productos` P;

    END IF;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_GET_Roles` (IN `opcion` INT, IN `id` INT)  BEGIN
	-- OBTENER ROLES
	IF opcion = 1 THEN
    
		SELECT 	R.`id`,
				R.`nombre`,
				R.`modulos`
		FROM `grupocastores`.`tbl_roles` R
        WHERE R.`activo` = 1;

    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_GET_Usuarios` (IN `opcion` INT, IN `id` INT)  BEGIN
	-- OBTENER USUARIOS
	IF opcion = 1 THEN
    
		SELECT U.`id`,
			CONCAT(U.`nombre`, ' ',U.`apellido_p`,' ',U.`apellido_m` ) AS usuario,
			U.`correo`,
			U.`usuario` as nombre_usuario,
            R.`nombre` AS rol
		FROM `grupocastores`.`tbl_usuarios` U
        INNER JOIN `tbl_roles` R ON R.id =  U.id_rol 
        WHERE U.`activo` = 1;

    END IF;
    
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_GET_Ventas` (IN `opcion` INT, IN `id` INT)  BEGIN
	-- OBTENER VENTAS
	IF opcion = 1 THEN
    
		SELECT 	V.`id`,
				P.`nombre`,
				V.`precio`,
				V.`cantidad`,
                (V.`precio` * V.`cantidad`) AS total,
				CONCAT(U.`nombre`,' ',U.`apellido_p`,' ',U.`apellido_m`) AS usuario,
				DA_Func_Format_Fecha(1,V.`fecins`) AS fecha
		FROM `grupocastores`.`tbl_ventas` V
        INNER JOIN `tbl_usuarios` U ON U.id = V.usuins
        INNER JOIN `tbl_productos` P ON P.id = V.id_producto
        WHERE V.`activo` = 1;

    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DA_spGC_Historial` (IN `opcion` INT, IN `id` INT)  BEGIN
	-- OBTENER PRODUCTOS (ENTRADAS)
	IF opcion = 1 THEN
    
		SELECT 	P.`nombre`,
				P.`precio`,
				P.`stock`,
				CONCAT(U.`nombre`,' ',U.`apellido_p`,' ',U.`apellido_m`) as usuario,
				DA_Func_Format_Fecha(1,P.`fecins`) AS fecha
		FROM `grupocastores`.`tbl_productos` P
		INNER JOIN `tbl_usuarios` U ON U.id = P.usuins;
   
    END IF;
    
    -- OBTENER VENTAS (SALIDAS)
    IF opcion = 2 THEN
		     
		SELECT 	P.`nombre`,
				V.`precio`,
				V.`cantidad`,
                (V.`precio`* V.`cantidad`) AS total,
				CONCAT(U.`nombre`,' ',U.`apellido_p`,' ',U.`apellido_m`) AS usuario,
				DA_Func_Format_Fecha(1,V.`fecins`) AS fecha
		FROM `grupocastores`.`tbl_ventas` V
        INNER JOIN `tbl_usuarios` U ON U.id = V.usuins
		INNER JOIN `tbl_productos` P ON P.id = V.id_producto
        WHERE V.`activo` = 1;
        
    END IF;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `DA_Func_Format_Fecha` (`opcion` INT, `fecha` DATETIME) RETURNS VARCHAR(25) CHARSET latin1 BEGIN
	DECLARE format_fecha VARCHAR(25) DEFAULT '';
    
	-- FORMATO DIA MES ANIO 
	IF opcion = 1 THEN
		SET format_fecha = date_format(fecha,'%d-%m-%Y %h:%i:%s');
	END IF;
    
RETURN format_fecha;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_abcs`
--

CREATE TABLE `tbl_abcs` (
  `id` int(11) NOT NULL,
  `referencia` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `usuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_productos`
--

CREATE TABLE `tbl_productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `precio` decimal(12,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `usuins` int(11) NOT NULL,
  `fecins` datetime NOT NULL,
  `usuupd` int(11) NOT NULL,
  `fecupd` datetime NOT NULL,
  `activo` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_productos`
--

INSERT INTO `tbl_productos` (`id`, `nombre`, `precio`, `stock`, `usuins`, `fecins`, `usuupd`, `fecupd`, `activo`) VALUES
(1, 'LAPTOP', '3000.00', 0, 2, '2024-07-14 17:15:15', 2, '2024-07-14 17:19:27', b'1'),
(2, 'PC', '4000.00', 0, 2, '2024-07-14 17:15:35', 2, '2024-07-14 17:20:01', b'1'),
(3, 'MOUSE', '100.00', 0, 2, '2024-07-14 17:15:52', 2, '2024-07-14 17:19:57', b'1'),
(4, 'TECLADO', '150.00', 0, 2, '2024-07-14 17:16:01', 2, '2024-07-14 17:20:33', b'1'),
(5, 'MONITOR', '2000.00', 0, 2, '2024-07-14 17:16:08', 2, '2024-07-14 17:20:12', b'1'),
(6, 'MICROFONO', '350.00', 0, 2, '2024-07-14 17:16:16', 2, '2024-07-14 17:20:17', b'1'),
(7, 'AUDIFONOS', '450.00', 0, 2, '2024-07-14 17:16:26', 2, '2024-07-14 17:20:28', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `modulos` varchar(255) NOT NULL,
  `usuins` int(11) NOT NULL,
  `fecins` datetime NOT NULL,
  `usuupd` int(11) NOT NULL,
  `fecupd` datetime NOT NULL,
  `activo` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_roles`
--

INSERT INTO `tbl_roles` (`id`, `nombre`, `modulos`, `usuins`, `fecins`, `usuupd`, `fecupd`, `activo`) VALUES
(1, 'Administrador', 'inventario,agregar_productos,aumentar_inventario,desactivar_producto,activar_producto,historial,roles,usuarios', 2, '2024-07-14 15:08:23', 2, '0000-00-00 00:00:00', b'1'),
(2, 'Almacenista', 'inventario,salida_productos,ventas,agregar_ventas', 2, '2024-07-14 14:08:23', 2, '0000-00-00 00:00:00', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `id` int(11) NOT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido_p` varchar(255) NOT NULL,
  `apellido_m` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `contrasenia` blob NOT NULL,
  `usuins` int(11) NOT NULL,
  `fecins` datetime NOT NULL,
  `usuupd` int(11) NOT NULL,
  `fecupd` datetime NOT NULL,
  `activo` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`id`, `id_rol`, `nombre`, `apellido_p`, `apellido_m`, `correo`, `usuario`, `contrasenia`, `usuins`, `fecins`, `usuupd`, `fecupd`, `activo`) VALUES
(2, 1, 'Dennis Ronald', 'Aguilar', 'Mota', 'ronalddenis@hotmail.com', 'Dennis', 0xf578709bd20aab863cad68de9fa81355, 2, '2024-07-14 01:43:48', 2, '0000-00-00 00:00:00', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ventas`
--

CREATE TABLE `tbl_ventas` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `precio` decimal(12,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `usuins` int(11) NOT NULL,
  `fecins` datetime NOT NULL,
  `usuupd` int(11) NOT NULL,
  `fecupd` datetime NOT NULL,
  `activo` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_ventas`
--

INSERT INTO `tbl_ventas` (`id`, `id_producto`, `precio`, `cantidad`, `usuins`, `fecins`, `usuupd`, `fecupd`, `activo`) VALUES
(1, 1, '3000.00', 1, 2, '2024-07-14 17:19:27', 2, '0000-00-00 00:00:00', b'1'),
(2, 3, '100.00', 1, 2, '2024-07-14 17:19:57', 2, '0000-00-00 00:00:00', b'1'),
(3, 2, '4000.00', 1, 2, '2024-07-14 17:20:01', 2, '0000-00-00 00:00:00', b'1'),
(4, 4, '150.00', 1, 2, '2024-07-14 17:20:07', 2, '0000-00-00 00:00:00', b'1'),
(5, 5, '2000.00', 1, 2, '2024-07-14 17:20:12', 2, '0000-00-00 00:00:00', b'1'),
(6, 6, '350.00', 1, 2, '2024-07-14 17:20:17', 2, '0000-00-00 00:00:00', b'1'),
(7, 7, '450.00', 2, 2, '2024-07-14 17:20:28', 2, '0000-00-00 00:00:00', b'1'),
(8, 4, '150.00', 1, 2, '2024-07-14 17:20:33', 2, '0000-00-00 00:00:00', b'1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_abcs`
--
ALTER TABLE `tbl_abcs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuins` (`usuins`),
  ADD KEY `usuupd` (`usuupd`);

--
-- Indices de la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuins` (`usuins`),
  ADD KEY `usuupd` (`usuupd`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tbl_usuarios_ibfk_1` (`id_rol`);

--
-- Indices de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuins` (`usuins`),
  ADD KEY `usuupd` (`usuupd`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_abcs`
--
ALTER TABLE `tbl_abcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  ADD CONSTRAINT `tbl_productos_ibfk_1` FOREIGN KEY (`usuins`) REFERENCES `tbl_usuarios` (`id`),
  ADD CONSTRAINT `tbl_productos_ibfk_2` FOREIGN KEY (`usuupd`) REFERENCES `tbl_usuarios` (`id`);

--
-- Filtros para la tabla `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD CONSTRAINT `tbl_roles_ibfk_1` FOREIGN KEY (`usuins`) REFERENCES `tbl_usuarios` (`id`),
  ADD CONSTRAINT `tbl_roles_ibfk_2` FOREIGN KEY (`usuupd`) REFERENCES `tbl_usuarios` (`id`);

--
-- Filtros para la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD CONSTRAINT `tbl_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_roles` (`id`);

--
-- Filtros para la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  ADD CONSTRAINT `tbl_ventas_ibfk_1` FOREIGN KEY (`usuins`) REFERENCES `tbl_usuarios` (`id`),
  ADD CONSTRAINT `tbl_ventas_ibfk_2` FOREIGN KEY (`usuupd`) REFERENCES `tbl_usuarios` (`id`),
  ADD CONSTRAINT `tbl_ventas_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `tbl_productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
