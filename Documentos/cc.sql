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

create database comite;
use comite;
--
-- Table structure for table `acta`
--
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
-- Table structure for table `generar`
--

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
-- Table structure for table `proceso`
--

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
-- Table structure for table `reporte`
--

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
  `Faltas` varchar(50) NOT NULL,
  `EvidenciaPDF` text NOT NULL,
  `TipoFalta` varchar(45) NOT NULL,
  PRIMARY KEY (`IdReporte`),
  KEY `CedulaUsuario` (`Identificacion`),
  KEY `TipoFalta` (`TipoFalta`),
  CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`TipoFalta`) REFERENCES `tipo_falta` (`idtipo_falta`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte`
--

LOCK TABLES `reporte` WRITE;
/*!40000 ALTER TABLE `reporte` DISABLE KEYS */;
INSERT INTO `reporte` VALUES (8,1019602814,'David',2558697,'COMUNICACIÓN','Logistica','rompio un computador','Contribuir al desorden y/o desaseo','uploads\\Robutez - Proyecto comité de seguimiento.pdf','Leve'),(9,2147483647,'Damian',5478574,'MERCADEO','Sistemas','abcde','Otro','uploads\\Diagrama de casos de uso-Page-5.pdf','Gravísima'),(10,194007980,'Galindo',2525255,'SISTEMAS','Logistica','porquesi','Falsificar documentos oficiales','uploads\\Diagrama de casos de uso-Page-5.pdf','Grave'),(11,292031342,'dananana',3232226,'','Logistica','no hizo nada','Realizar fraude en evaluaciones','uploads\\Robutez - Proyecto comité de seguimiento.pdf','Leve'),(13,542343236,'Diana Yisel Martinez Montes',2558697,'ADSO','Artistica','robo','Hurtar, estafar o abusar de la confianza de cualqu','uploads\\INTERESADOS.pdf','Leve'),(14,292031342,'dananana',3232226,'','Artistica','eqwqwe','Falsificar documentos oficiales','uploads\\MER (1).pdf','Leve'),(15,194007980,'Galindo',2525255,'SISTEMAS','Artistica','ewafqfa','Actos que saboteen actividades de formación','uploads\\MER (1).pdf','Leve'),(16,2147483647,'Omar Muñoz',5478574,'COMUNICACIÓN','Artistica','sdfbewsfbcffe','Otro','uploads\\INTERESADOS.pdf','Leve'),(17,194007980,'Galindo',2525255,'SISTEMAS','Artistica','dsdqdsacdwdsvc','Realizar fraude en evaluaciones','uploads\\Robutez - Proyecto comité de seguimiento.pdf','Leve');
/*!40000 ALTER TABLE `reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

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
INSERT INTO `usuario` VALUES (111111,'Omar Muñoz','',0,'casdafa','2147483','omar@misena.edu.co','0000',3),(3213131,'dananana','',0,'dadasdadada','1312323','dana@mariagarcia.com','3456',2),(10468595,'Ana','ADSO',0,'calle 12 #34','2334570','ana@gmail.com','2020',1),(10468596,'Carlos','ADSO',0,'avenida 9 #10','2334580','carlos@gmail.com','1234',2),(10468598,'Jorge','ADSO',0,'carrera 3 #6','2334600','jorge@gmail.com','0987',3),(10468599,'Sofia','EDSI',0,'calle 45 #78','2334610','sofia@gmail.com','123456',2),(12345678,'Omar Muñoz','',0,'Cr18p N67c 50 sur ','2147483','dana@mariagarcia.com','1111',2),(130004241,'Vanesa','MERCADEO',5478574,'ggjgjhghgy','1234521','vasky300@misena.edu.co','vivimosconvanesa',4),(194007980,'Galindo','SISTEMAS',2525255,'Cr18p N67c 50 sur ','3123131','jgalindo2024@gmail.com','1234',4),(292031342,'dananana','',3232226,'dadasdadada','1312323','dana@mariagarcia.com','3456',4),(542343236,'Diana Yisel Martinez Montes','ADSO',2558697,'Cr18p N67c 50 sur ','2147483647','dianamartinez@gmail.com','1234',4),(1019602814,'David','COMUNICACIÓN',2558697,'akndaksdj','1131456','davidsantimm2014@gmail.com','1234',4),(2147483647,'Omar Muñoz','COMUNICACIÓN',5478574,'cgtvt','2147483647','omaryesitmuños@gmail.com','3456',4);
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

-- Dump completed on 2024-10-28 15:37:18
