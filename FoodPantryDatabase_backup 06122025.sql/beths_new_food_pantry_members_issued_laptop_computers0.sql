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
-- Table structure for table `members_issued_laptop_computers`
--

DROP TABLE IF EXISTS `members_issued_laptop_computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_issued_laptop_computers` (
  `member_id` varchar(10) NOT NULL,
  `laptop_computer_id` varchar(20) NOT NULL,
  `collection_point_id` varchar(10) NOT NULL,
  `date_issued` date NOT NULL,
  `amount_issued` int NOT NULL,
  KEY `FK_members_issued_laptop_computers_Laptop_computer_id` (`laptop_computer_id`),
  KEY `FK_members_issued_laptop_computers_Collection_point_id` (`collection_point_id`),
  KEY `FK_members_issued_laptop_computers_Member_id` (`member_id`),
  CONSTRAINT `FK_members_issued_laptop_computers_Collection_point_id` FOREIGN KEY (`collection_point_id`) REFERENCES `main_support_collection_point` (`collection_point_id`),
  CONSTRAINT `FK_members_issued_laptop_computers_Laptop_computer_id` FOREIGN KEY (`laptop_computer_id`) REFERENCES `laptop_computers_for_issue` (`laptop_computer_id`),
  CONSTRAINT `FK_members_issued_laptop_computers_Member_id` FOREIGN KEY (`member_id`) REFERENCES `members_personal_details` (`member_id`) ON UPDATE CASCADE,
  CONSTRAINT `members_issued_laptop_computers_chk_1` CHECK ((`amount_issued` = 1)),
  CONSTRAINT `members_issued_laptop_computers_chk_2` CHECK ((`amount_issued` = 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_issued_laptop_computers`
--

LOCK TABLES `members_issued_laptop_computers` WRITE;
/*!40000 ALTER TABLE `members_issued_laptop_computers` DISABLE KEYS */;
INSERT INTO `members_issued_laptop_computers` VALUES ('M1','COMP01','ERD01','2023-12-07',1),('M7','COMP01','WAL02','2024-01-29',1);
/*!40000 ALTER TABLE `members_issued_laptop_computers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_laptop_computers_stock_AFTER_ISSUING_laptops` AFTER INSERT ON `members_issued_laptop_computers` FOR EACH ROW BEGIN
    CALL SP_update_laptop_computers_stock_AFTER_ISSUING_laptops(NEW.laptop_computer_id, NEW.amount_issued);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 19:37:07
