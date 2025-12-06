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
-- Table structure for table `members_address`
--

DROP TABLE IF EXISTS `members_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_address` (
  `address_id` varchar(10) NOT NULL,
  `house_number` varchar(15) NOT NULL,
  `street_name` varchar(50) DEFAULT NULL,
  `city_or_town` varchar(50) DEFAULT NULL,
  `post_code` varchar(10) NOT NULL,
  `country` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_address`
--

LOCK TABLES `members_address` WRITE;
/*!40000 ALTER TABLE `members_address` DISABLE KEYS */;
INSERT INTO `members_address` VALUES ('A0','No fixed abode','ZZZ','ZZZ','ZZZ','UK'),('A1','20','Swingle Close','Halesowen','HH16 8DX','UK'),('A10','10','Gorsvenor Road','Erdington','E29 8NW','UK'),('A11','129','Daisy Road','Birmingham','B19 8PA','UK'),('A12','58','High Street','Erdington','E15 10BL','UK'),('A13','22','Broadway North','Walsall','WS1 2QB','UK'),('A14','17','Victoria Road','Birmingham','BH4 2HJ','UK'),('A15','22','Manor Lane','Halesowen','B62 8QG','UK'),('A16','14','Manor Lane','Halesowen','B62 8QG','UK'),('A17','15','Manor Lane','Halesowen','B62 8QG','UK'),('A18','99','Maple Grove','Birmingham','B16 7LP','UK'),('A19','20','Swingle Close','Halesowen','HH20 9ZZ','UK'),('A2','57','High Street','Erdington','E15 10BL','UK'),('A3','32','London Road','Birmingham','B15 6DL','UK'),('A4','33','Brixto Street','Walsal','WX2 7HX','UK'),('A5','91','Newtown Walk','Birmingham','B18 6HU','UK'),('A6','47','Bonn Stret','Birmingham','B9 5XU','UK'),('A7','195','Glasgow Street','Dudley','DL27 9JX','UK'),('A8','202','Plex Corner','Walsal','WX5 5BJ','UK'),('A9','115','Good Hope Street','Dudley','DL15 8BX','UK');
/*!40000 ALTER TABLE `members_address` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 19:36:38
