CREATE DATABASE  IF NOT EXISTS `buyme` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buyme`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: buyme
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `userId` int NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES (4);
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerRep`
--

DROP TABLE IF EXISTS `CustomerRep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerRep` (
  `userId` int NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `customerrep_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerRep`
--

LOCK TABLES `CustomerRep` WRITE;
/*!40000 ALTER TABLE `CustomerRep` DISABLE KEYS */;
INSERT INTO `CustomerRep` VALUES (5),(6);
/*!40000 ALTER TABLE `CustomerRep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EndUser`
--

DROP TABLE IF EXISTS `EndUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EndUser` (
  `userId` int NOT NULL,
  `rating` float DEFAULT '0',
  PRIMARY KEY (`userId`),
  CONSTRAINT `enduser_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EndUser`
--

LOCK TABLES `EndUser` WRITE;
/*!40000 ALTER TABLE `EndUser` DISABLE KEYS */;
INSERT INTO `EndUser` VALUES (1,0),(2,0),(3,0),(7,0),(8,0),(9,0);
/*!40000 ALTER TABLE `EndUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'John Doe','johndoe','482c811da5d5b4bc6d497ffa98491e38','johndoe@example.com','New York'),(2,'Jane Doe','janedoe','96b33694c4bb7dbd07391e0be54745fb','janedoe@example.com','Los Angeles'),(3,'Bob Smith','bobsmith','7d347cf0ee68174a3588f6cba31b8a67','bobsmith@example.com','Chicago'),(4,'Mike Jones','mikejones','73a054cc528f91ca1bbdda3589b6a22d','mikejones@example.com','Paris'),(5,'Emma Johnson','emmajohnson','ba1b5d9d26dd50164b5fb53a948e5cdf','emmajohnson@example.com','New York'),(6,'David Brown','davidbrown','b4af804009cb036a4ccdc33431ef9ac9','davidbrown@example.com','Los Angeles'),(7,'Sarah Johnson','sjohnson','82080600934821faf0bc59cba79964bc','sarahj@example.com','New York City'),(8,'Michael Lee','mlee23','d34eb083b98f9c2f535fed62c288f583','mlee23@gmail.com','Toronto'),(9,'Samantha Smith,','ssmith22','07f4aaf87a3d11457830ea799091ccfc','samsmith22@yahoo.com','New Brunswick');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-26 21:57:28
