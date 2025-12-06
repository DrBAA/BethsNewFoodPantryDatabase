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
-- Table structure for table `members_address_testing`
--

DROP TABLE IF EXISTS `members_address_testing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_address_testing` (
  `address_id` varchar(10) NOT NULL,
  `house_number` varchar(15) DEFAULT NULL,
  `street_name` varchar(50) DEFAULT NULL,
  `city_or_town` varchar(50) DEFAULT NULL,
  `post_code` varchar(10) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_address_testing`
--

LOCK TABLES `members_address_testing` WRITE;
/*!40000 ALTER TABLE `members_address_testing` DISABLE KEYS */;
INSERT INTO `members_address_testing` VALUES ('A1','20','Swingle Close','Halesowen','HH16 8DX','UK'),('A10','19','Ash Drive','Belfast','BT7 1NN','UK'),('A11','46','Chestnut Street','Glasgow','G1 2FF','UK'),('A2','57','High Street','Erdington','E15 10BL','UK'),('A3','58','High Street','Erdington','E15 10BL','UK'),('A4','12','Maple Grove','Manchester','M12 4AB','UK'),('A5','88','Birch Lane','Stockport','SK3 8TR','UK'),('A6','5A','Elm Street','Liverpool','L4 2QP','UK'),('A7','22','Oak Crescent','Birmingham','B15 3AA','UK'),('A8','101','Pine Road','Newcastle','NE1 6XE','UK'),('A9','7','Cedar Avenue','Cardiff','CF10 1EP','UK');
/*!40000 ALTER TABLE `members_address_testing` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 19:37:05
