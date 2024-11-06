-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: comite
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acta`
--
create database comite;
use comite;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acta` (
  `IdActa` int NOT NULL,
  `FechaActa` date NOT NULL,
  `Hora` time NOT NULL,
  `DetallesActa` text COLLATE utf8mb4_general_ci NOT NULL,
  `IdPlanMejora` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citacion` (
  `IdProceso` int NOT NULL,
  `Identificacion` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generar` (
  `IdProceso` int NOT NULL,
  `IdPlanMejora` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proceso` (
  `IdProceso` int NOT NULL,
  `FechaCitacion` date NOT NULL,
  `Descargos` text COLLATE utf8mb4_general_ci NOT NULL,
  `Decision` text COLLATE utf8mb4_general_ci NOT NULL,
  `Estado` int NOT NULL,
  `Motivo` text COLLATE utf8mb4_general_ci NOT NULL,
  `Resumen` text COLLATE utf8mb4_general_ci NOT NULL,
  `Evidencias` text COLLATE utf8mb4_general_ci NOT NULL,
  `IdReporte` int NOT NULL,
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


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rechazo_reportes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_reporte` int DEFAULT NULL,
  `nombre_rechazo` varchar(255) DEFAULT NULL,
  `motivo_rechazo` text,
  `fecha_rechazo` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rechazo_reportes`
--

LOCK TABLES `rechazo_reportes` WRITE;
/*!40000 ALTER TABLE `rechazo_reportes` DISABLE KEYS */;
INSERT INTO `rechazo_reportes` VALUES (1,19,'galindo','porque si','2024-11-06 20:44:12');
/*!40000 ALTER TABLE `rechazo_reportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte` (
  `IdReporte` int NOT NULL AUTO_INCREMENT,
  `Identificacion` int NOT NULL,
  `Nombre` text COLLATE utf8mb4_general_ci NOT NULL,
  `Ficha` int NOT NULL,
  `ProgramaFormacion` text COLLATE utf8mb4_general_ci NOT NULL,
  `Coordinacion` text COLLATE utf8mb4_general_ci NOT NULL,
  `CausasReporte` text COLLATE utf8mb4_general_ci NOT NULL,
  `Faltas` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `EvidenciaPDF` text COLLATE utf8mb4_general_ci NOT NULL,
  `TipoFalta` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`IdReporte`),
  KEY `CedulaUsuario` (`Identificacion`),
  KEY `TipoFalta` (`TipoFalta`),
  CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`TipoFalta`) REFERENCES `tipo_falta` (`idtipo_falta`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte`
--

LOCK TABLES `reporte` WRITE;
/*!40000 ALTER TABLE `reporte` DISABLE KEYS */;
INSERT INTO `reporte` VALUES (56,130004241,'Vanesa',5478574,'MERCADEO','Artistica','plagio','Otro','uploads\\colombia91.pdf','Leve'),(57,2147483647,'Omar Muñoz',5478574,'COMUNICACIÓN','Logistica','Robo de utiles','Destruir y dañar instalaciones físicas, equipos, software…','uploads\\TallerPracticaHTML.pdf','Leve'),(58,194007980,'Galindo',2525255,'SISTEMAS','Sistemas','Robarse un computador','Hurtar, estafar o abusar de la confianza de cualquier integrante de la comunidad educativa','uploads\\colombia91.pdf','Gravísima'),(59,292031342,'dananana',3232226,'ADSO','Sistemas','Dañar propiedad privada','Actos que saboteen actividades de formación','uploads\\colombia91.pdf','Leve'),(60,1019602814,'David',2558697,'ADSO','Artistica','ya no se me ocurre nada','Otro','uploads\\COL_Constitution_1991.pdf','Leve');
/*!40000 ALTER TABLE `reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_falta` (
  `idtipo_falta` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `Identificacion` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ProgramaFormacion` text COLLATE utf8mb4_general_ci NOT NULL,
  `Ficha` int DEFAULT NULL,
  `Direccion` text COLLATE utf8mb4_general_ci NOT NULL,
  `Telefono` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `Correo` text COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `id_rol` int NOT NULL,
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

-- Dump completed on 2024-11-06 16:02:11
