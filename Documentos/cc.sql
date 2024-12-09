-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: comite
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acta`
--

DROP TABLE IF EXISTS `acta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acta` (
  `IdActa` int(11) NOT NULL,
  `FechaActa` date NOT NULL,
  `Hora` time NOT NULL,
  `DetallesActa` text NOT NULL,
  `IdPlanMejora` int(11) NOT NULL,
  PRIMARY KEY (`IdActa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acta`
--

LOCK TABLES `acta` WRITE;
/*!40000 ALTER TABLE `acta` DISABLE KEYS */;
/*!40000 ALTER TABLE `acta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citacion`
--

DROP TABLE IF EXISTS `citacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citacion` (
  `IdProceso` int(11) NOT NULL,
  `Identificacion` int(11) NOT NULL,
  KEY `IdProceso` (`IdProceso`),
  KEY `Identificacion` (`Identificacion`),
  CONSTRAINT `citacion_ibfk_1` FOREIGN KEY (`IdProceso`) REFERENCES `proceso` (`IdProceso`),
  CONSTRAINT `citacion_ibfk_2` FOREIGN KEY (`Identificacion`) REFERENCES `usuario` (`Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citacion`
--

LOCK TABLES `citacion` WRITE;
/*!40000 ALTER TABLE `citacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `citacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comite`
--

DROP TABLE IF EXISTS `comite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `caso` varchar(100) NOT NULL,
  `fecha` date DEFAULT NULL,
  `motivo` text NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comite`
--

LOCK TABLES `comite` WRITE;
/*!40000 ALTER TABLE `comite` DISABLE KEYS */;
/*!40000 ALTER TABLE `comite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generar`
--

DROP TABLE IF EXISTS `generar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `generar` (
  `IdProceso` int(11) NOT NULL,
  `IdPlanMejora` int(11) NOT NULL,
  KEY `IdProceso` (`IdProceso`),
  CONSTRAINT `generar_ibfk_1` FOREIGN KEY (`IdProceso`) REFERENCES `proceso` (`IdProceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generar`
--

LOCK TABLES `generar` WRITE;
/*!40000 ALTER TABLE `generar` DISABLE KEYS */;
/*!40000 ALTER TABLE `generar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas_citadas`
--

DROP TABLE IF EXISTS `personas_citadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas_citadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comite_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `comite_id` (`comite_id`),
  CONSTRAINT `personas_citadas_ibfk_1` FOREIGN KEY (`comite_id`) REFERENCES `comite` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas_citadas`
--

LOCK TABLES `personas_citadas` WRITE;
/*!40000 ALTER TABLE `personas_citadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `personas_citadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso`
--

DROP TABLE IF EXISTS `proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proceso` (
  `IdProceso` int(11) NOT NULL,
  `FechaCitacion` date NOT NULL,
  `Descargos` text NOT NULL,
  `Decision` text NOT NULL,
  `Estado` int(11) NOT NULL,
  `Motivo` text NOT NULL,
  `Resumen` text NOT NULL,
  `Evidencias` text NOT NULL,
  `IdReporte` int(11) NOT NULL,
  PRIMARY KEY (`IdProceso`),
  KEY `IdReporte` (`IdReporte`),
  CONSTRAINT `proceso_ibfk_1` FOREIGN KEY (`IdReporte`) REFERENCES `reporte` (`IdReporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso`
--

LOCK TABLES `proceso` WRITE;
/*!40000 ALTER TABLE `proceso` DISABLE KEYS */;
/*!40000 ALTER TABLE `proceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rechazo_reportes`
--

DROP TABLE IF EXISTS `rechazo_reportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rechazo_reportes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_reporte` int(11) DEFAULT NULL,
  `nombre_rechazo` varchar(255) DEFAULT NULL,
  `motivo_rechazo` text DEFAULT NULL,
  `fecha_rechazo` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rechazo_reportes`
--

LOCK TABLES `rechazo_reportes` WRITE;
/*!40000 ALTER TABLE `rechazo_reportes` DISABLE KEYS */;
INSERT INTO `rechazo_reportes` VALUES (8,62,'Ana','rechazado','2024-12-02 15:21:31'),(9,63,'Ana','zxcvbnzxcvb','2024-12-05 20:52:40');
/*!40000 ALTER TABLE `rechazo_reportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte`
--

DROP TABLE IF EXISTS `reporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporte` (
  `IdReporte` int(11) NOT NULL AUTO_INCREMENT,
  `Identificacion` int(11) NOT NULL,
  `Nombre` text NOT NULL,
  `Ficha` int(11) NOT NULL,
  `ProgramaFormacion` text NOT NULL,
  `Coordinacion` text NOT NULL,
  `CausasReporte` text NOT NULL,
  `Faltas` varchar(100) NOT NULL,
  `EvidenciaPDF` text NOT NULL,
  `TipoFalta` varchar(45) NOT NULL,
  `estado` enum('pendiente','rechazado','aceptado') DEFAULT 'pendiente',
  PRIMARY KEY (`IdReporte`),
  KEY `CedulaUsuario` (`Identificacion`),
  KEY `TipoFalta` (`TipoFalta`),
  CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`TipoFalta`) REFERENCES `tipo_falta` (`idtipo_falta`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte`
--

LOCK TABLES `reporte` WRITE;
/*!40000 ALTER TABLE `reporte` DISABLE KEYS */;
INSERT INTO `reporte` VALUES (62,130004241,'Vanesa',5478574,'MERCADEO','Artistica','no','Otro','uploads\\Robutez - Proyecto comité de seguimiento.pdf','Grave','rechazado'),(63,130004241,'Vanesa',5478574,'MERCADEO','Logistica','cmoom','Fumar en áreas no permitidas','uploads\\Robutez - Proyecto comité de seguimiento.pdf','Leve','rechazado');
/*!40000 ALTER TABLE `reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador'),(2,'Instructor'),(3,'relator'),(4,'Aprendiz');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_falta`
--

DROP TABLE IF EXISTS `tipo_falta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_falta` (
  `idtipo_falta` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipo_falta`),
  KEY `idtipo_falta` (`idtipo_falta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_falta`
--

LOCK TABLES `tipo_falta` WRITE;
/*!40000 ALTER TABLE `tipo_falta` DISABLE KEYS */;
INSERT INTO `tipo_falta` VALUES ('Grave','Grave'),('Gravisima','Gravisima'),('Leve','Leve');
/*!40000 ALTER TABLE `tipo_falta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `Identificacion` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `ProgramaFormacion` text NOT NULL,
  `Ficha` int(11) DEFAULT NULL,
  `Direccion` text NOT NULL,
  `Telefono` varchar(30) NOT NULL,
  `Correo` text NOT NULL,
  `password` varchar(200) NOT NULL,
  `id_rol` int(11) NOT NULL,
  PRIMARY KEY (`Identificacion`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2147483648 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (111111,'Omar Muñoz','',0,'casdafa','2147483','omar@misena.edu.co','0000',3),(3213131,'DANA','',0,'dadasdadada','1312323','dana@mariagarcia.com','3456',2),(10468595,'Ana','ADSO',0,'calle 12 #34','2334570','ana@gmail.com','2020',1),(10468596,'Carlos','ADSO',0,'avenida 9 #10','2334580','carlos@gmail.com','1234',2),(10468598,'Jorge','ADSO',0,'carrera 3 #6','2334600','jorge@gmail.com','0987',3),(10468599,'Sofia','EDSI',0,'calle 45 #78','2334610','sofia@gmail.com','123456',2),(12345678,'Omar Muñoz','',0,'Cr18p N67c 50 sur ','2147483','dana@mariagarcia.com','1111',2),(130004241,'Vanesa','MERCADEO',5478574,'ggjgjhghgy','1234521','vasky300@misena.edu.co','vivimosconvanesa',4),(194007980,'Galindo','SISTEMAS',2525255,'Cr18p N67c 50 sur ','3123131','jgalindo2024@gmail.com','1234',4),(292031342,'dananana','ADSO',3232226,'dadasdadada','1312323','dana@mariagarcia.com','3456',4),(542343236,'Diana Yisel Martinez Montes','ADSO',2558697,'Cr18p N67c 50 sur ','2147483647','dianamartinez@gmail.com','1234',4),(1019602814,'David','COMUNICACIÓN',2558697,'akndaksdj','1131456','davidsantimm2014@gmail.com','1234',4),(2147483647,'Omar Muñoz','COMUNICACIÓN',5478574,'cgtvt','2147483647','omaryesitmuños@gmail.com','3456',4);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-09 10:48:13
