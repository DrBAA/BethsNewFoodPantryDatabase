CREATE DATABASE  IF NOT EXISTS `beths_new_food_pantry` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `beths_new_food_pantry`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: beths_new_food_pantry
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `incoming_food_parcels`
--

DROP TABLE IF EXISTS `incoming_food_parcels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incoming_food_parcels` (
  `food_parcel_id` varchar(20) NOT NULL,
  `date_received` date NOT NULL,
  `amount_of_food_parcels_received` int NOT NULL,
  KEY `FK_incoming_food_parcels_Food_parcel_id` (`food_parcel_id`),
  CONSTRAINT `FK_incoming_food_parcels_Food_parcel_id` FOREIGN KEY (`food_parcel_id`) REFERENCES `food_parcels_for_issue` (`food_parcel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incoming_food_parcels`
--

LOCK TABLES `incoming_food_parcels` WRITE;
/*!40000 ALTER TABLE `incoming_food_parcels` DISABLE KEYS */;
INSERT INTO `incoming_food_parcels` VALUES ('FP01','2023-12-12',30),('FP04','2023-12-14',20),('FP02','2024-01-08',20),('FP03','2024-01-12',20),('FP05','2023-12-12',20),('FP01','2025-03-09',5),('FP02','2025-03-09',5),('FP03','2025-03-09',5),('FP04','2025-03-09',5),('FP05','2025-03-09',5),('FP04','2025-09-30',20),('FP02','2025-09-30',20),('FP05','2025-10-22',20),('FP03','2025-10-22',20),('FP01','2025-10-22',10),('FP01','2025-10-22',10),('fp03','2025-10-23',10),('fp02','2025-10-23',10),('FP06','2025-10-25',1),('FP06','2025-10-25',1),('FP05','2025-10-25',1),('FP06','2025-10-25',1),('FP06','2025-10-25',2),('FP06','2025-10-25',1),('FP06','2025-10-25',1),('FP03','2025-11-08',20),('FP06','2025-12-04',1);
/*!40000 ALTER TABLE `incoming_food_parcels` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 19:36:51
