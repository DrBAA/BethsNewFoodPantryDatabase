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
-- Table structure for table `other_support_requested_by_members`
--

DROP TABLE IF EXISTS `other_support_requested_by_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_support_requested_by_members` (
  `member_id` varchar(10) NOT NULL,
  `type_of_support_id` varchar(20) NOT NULL,
  `date_requested` date NOT NULL,
  `initial_outcome_of_request` varchar(100) NOT NULL,
  `current_status_of_request` varchar(100) NOT NULL,
  KEY `FK_other_support_requested_by_members_Type_of_support_id` (`type_of_support_id`),
  KEY `FK_other_support_requested_by_members_Member_id` (`member_id`),
  CONSTRAINT `FK_other_support_requested_by_members_Member_id` FOREIGN KEY (`member_id`) REFERENCES `members_personal_details` (`member_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_other_support_requested_by_members_Type_of_support_id` FOREIGN KEY (`type_of_support_id`) REFERENCES `other_types_of_support_available_for_members` (`type_of_support_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_support_requested_by_members`
--

LOCK TABLES `other_support_requested_by_members` WRITE;
/*!40000 ALTER TABLE `other_support_requested_by_members` DISABLE KEYS */;
INSERT INTO `other_support_requested_by_members` VALUES ('M1','SUP01','2024-01-18','awaiting allocation','awaiting allocation'),('M2','SUP02','2023-07-03','applied for benefits','referral closed'),('M2','SUP03','2023-12-12','referred to another agency','referral closed'),('M5','SUP12','2023-07-10','advice and information','referral closed'),('M8','SUP05','2023-12-20','allocated to a worker','support ongoing'),('M8','SUP06','2023-07-20','allocated to a worker','support ongoing'),('M6','SUP07','2024-01-26','awaiting allocation','awaiting allocation'),('M6','SUP08','2023-05-10','advice and information','referral closed'),('M3','SUP09','2023-06-12','referred to another agency','referral closed'),('M3','SUP10','2023-06-12','allocated to a worker','support ongoing'),('M5','SUP04','2023-08-31','applied for housing','referral closed'),('M5','SUP03','2023-12-12','awaiting allocation','awaiting allocation'),('M1','SUP02','2024-01-20','awaiting allocation','awaiting allocation'),('M10','SUP11','2023-05-10','allocated to a worker','support ongoing'),('M4','SUP06','2023-05-25','applied for debt relief','referral closed'),('M7','SUP06','2023-09-10','allocated to a worker','support ongoing'),('M12','SUP03','2024-01-24','awaiting allocation','awaiting allocation');
/*!40000 ALTER TABLE `other_support_requested_by_members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 19:36:34
