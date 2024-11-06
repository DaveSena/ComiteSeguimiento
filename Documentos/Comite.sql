CREATE DATABASE  IF NOT EXISTS `comite`;
USE `comite`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: comite
-- ------------------------------------------------------
-- Server version	8.0.39

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


CREATE TABLE `acta` (
  `IdActa` int NOT NULL,
  `FechaActa` date NOT NULL,
  `Hora` time NOT NULL,
  `DetallesActa` text NOT NULL,
  `IdPlanMejora` int NOT NULL,
  PRIMARY KEY (`IdActa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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


CREATE TABLE `citacion` (
  `IdProceso` int NOT NULL,
  `Identificacion` int NOT NULL,
  KEY `IdProceso` (`IdProceso`),
  KEY `Identificacion` (`Identificacion`),
  CONSTRAINT `citacion_ibfk_1` FOREIGN KEY (`IdProceso`) REFERENCES `proceso` (`IdProceso`),
  CONSTRAINT `citacion_ibfk_2` FOREIGN KEY (`Identificacion`) REFERENCES `usuario` (`Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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


CREATE TABLE `generar` (
  `IdProceso` int NOT NULL,
  `IdPlanMejora` int NOT NULL,
  KEY `IdProceso` (`IdProceso`),
  CONSTRAINT `generar_ibfk_1` FOREIGN KEY (`IdProceso`) REFERENCES `proceso` (`IdProceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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


CREATE TABLE `proceso` (
  `IdProceso` int NOT NULL,
  `FechaCitacion` date NOT NULL,
  `Descargos` text NOT NULL,
  `Decision` text NOT NULL,
  `Estado` int NOT NULL,
  `Motivo` text NOT NULL,
  `Resumen` text NOT NULL,
  `Evidencias` text NOT NULL,
  `IdReporte` int NOT NULL,
  PRIMARY KEY (`IdProceso`),
  KEY `IdReporte` (`IdReporte`),
  CONSTRAINT `proceso_ibfk_1` FOREIGN KEY (`IdReporte`) REFERENCES `reporte` (`IdReporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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


CREATE TABLE `reporte` (
  `IdReporte` int NOT NULL,
  `Identificacion` int NOT NULL,
  `Nombre` text NOT NULL,
  `Ficha` int NOT NULL,
  `ProgramaFormacion` text NOT NULL,
  `Coordinacion` text NOT NULL,
  `TipoFalta` text NOT NULL,
  `CausasReporte` text NOT NULL,
  `Faltas` varchar(50) NOT NULL,
  `EvidenciaPDF` text NOT NULL,
  PRIMARY KEY (`IdReporte`),
  KEY `CedulaUsuario` (`Identificacion`),
  CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`Identificacion`) REFERENCES `usuario` (`Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte`
--

LOCK TABLES `reporte` WRITE;
/*!40000 ALTER TABLE `reporte` DISABLE KEYS */;
INSERT INTO `reporte` VALUES (1,10468595,'Ana',451231,'ADSO','logistica','grave','El joven fomenta el desorden','Contribuir al desaseo','hello.PDF');
/*!40000 ALTER TABLE `reporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--


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
-- Table structure for table `usuario`
--


CREATE TABLE `usuario` (
  `Identificacion` int NOT NULL AUTO_INCREMENT,
  `Nombre` text NOT NULL,
  `ProgramaFormacion` text,
  `Ficha` int DEFAULT NULL,
  `Direccion` text NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Correo` text NOT NULL,
  `password` varchar(100) NOT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`Identificacion`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2134534545 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1234567,'jijijij','',NULL,'mjfdhswfjgwe','123456','holi@holi.com','1111',2),(10468595,'Ana','ADSO',451231,'calle 12 #34','233457','ana@gmail.com','2020',1),(10468596,'Carlos','ADSO',451232,'avenida 9 #10','233458','carlos@gmail.com','1234',2),(10468598,'Jorge','ADSO',451234,'carrera 3 #6','233460','jorge@gmail.com','12',3),(10468599,'Sofia','ADSO',451235,'calle 45 #78','233461','sofia@gmail.com','123456',2),(21012155,'Damian','ADSO',547857,'ggjgjhghgy','12345210','dani@misena.edu.co','sasasa',4),(45664564,'David','EDSI',2558697,'Cll 52 N13 65','3132012936','davidsantimm2014@misena.edu.co','2222',4),(2134534543,'laura','GESO',5869845,'sdfghjhgdjk','32101052','dasdawa@afas.com','dsadada',4);
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

-- Dump completed on 2024-09-11  9:42:32
