CREATE DATABASE  IF NOT EXISTS `comite` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
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

DROP TABLE IF EXISTS `acta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

DROP TABLE IF EXISTS `citacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

DROP TABLE IF EXISTS `generar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

DROP TABLE IF EXISTS `proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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

DROP TABLE IF EXISTS `reporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte` (
  `IdReporte` int NOT NULL,
  `CedulaUsuario` int NOT NULL,
  `Nombre` text NOT NULL,
  `Ficha` int NOT NULL,
  `ProgramaFormacion` text NOT NULL,
  `Coordinacion` text NOT NULL,
  `TipoFalta` text NOT NULL,
  `CausasReporte` text NOT NULL,
  `Faltas` varchar(50) NOT NULL,
  `EvidenciaPDF` text NOT NULL,
  PRIMARY KEY (`IdReporte`),
  KEY `CedulaUsuario` (`CedulaUsuario`),
  CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`CedulaUsuario`) REFERENCES `usuario` (`Identificacion`)
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
-- Table structure for table `rolesinicio`
--

DROP TABLE IF EXISTS `rolesinicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolesinicio` (
  `Rol` int NOT NULL,
  `Tipo_de_rol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolesinicio`
--

LOCK TABLES `rolesinicio` WRITE;
/*!40000 ALTER TABLE `rolesinicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `rolesinicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `Identificacion` int NOT NULL,
  `Nombre` text NOT NULL,
  `ProgramaFormacion` text NOT NULL,
  `Ficha` int NOT NULL,
  `Direccion` text NOT NULL,
  `Telefono` int NOT NULL,
  `Correo` text NOT NULL,
  `Rol` int NOT NULL,
  PRIMARY KEY (`Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (10468595,'Ana','ADSO',451231,'calle 12 #34',233457,'ana@gmail.com',2),(10468596,'Carlos','ADSO',451232,'avenida 9 #10',233458,'carlos@gmail.com',1),(10468597,'Laura','ADSO',451233,'carrera 7 #8',233459,'laura@gmail.com',2),(10468598,'Jorge','ADSO',451234,'carrera 3 #6',233460,'jorge@gmail.com',1),(10468599,'Sofia','ADSO',451235,'calle 45 #78',233461,'sofia@gmail.com',2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'comite'
--

--
-- Dumping routines for database 'comite'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-26 13:03:02
