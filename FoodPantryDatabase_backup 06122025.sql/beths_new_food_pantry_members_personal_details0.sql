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
-- Table structure for table `members_personal_details`
--

DROP TABLE IF EXISTS `members_personal_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_personal_details` (
  `member_id` varchar(10) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `age_range` varchar(20) NOT NULL,
  `dependants_under_18` int DEFAULT NULL,
  `main_contact_number` varchar(20) NOT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `address_id` varchar(10) NOT NULL,
  PRIMARY KEY (`member_id`),
  KEY `FK_members_personal_details_address_id` (`address_id`),
  CONSTRAINT `FK_members_personal_details_address_id` FOREIGN KEY (`address_id`) REFERENCES `members_address` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `members_personal_details_chk_1` CHECK ((`age_range` in (_utf8mb4'18-25',_utf8mb4'25-35',_utf8mb4'35-45',_utf8mb4'45-55',_utf8mb4'55-65',_utf8mb4'65-75',_utf8mb4'75-85',_utf8mb4'85-95',_utf8mb4'95-105',_utf8mb4'105-150',_utf8mb4'prefer not to say')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_personal_details`
--

LOCK TABLES `members_personal_details` WRITE;
/*!40000 ALTER TABLE `members_personal_details` DISABLE KEYS */;
INSERT INTO `members_personal_details` VALUES ('M1','Agatha','Benson','25-35',2,'678-896-1022','benson@mail.com','A1'),('M10','Michael','Blantyre','55-65',2,'unknown','michael.blantyre@mail.co.uk','A10'),('M11','Brian','Kumalo','75-85',2,'unknown','brian.kumalo@mail.co.uk','A11'),('M12','Jack','Maideni','35-45',0,'none','unknown','A0'),('M13','Diana','McGrath','45-55',0,'782-188-1324','mcgrath@mail.com','A12'),('M14','Trevor','Hughes','55-65',1,'079-442-9981','trevor.hughes@mail.com','A13'),('M15','Linda','Chambers','35-45',2,'074-112-7645','linda.chambers@mail.com','A14'),('M16','Marcus','Dawson','55-65',0,'079-441-8821','marcus.dawson@mail.com','A15'),('M17','Aleksandra','Nowak','25-35',1,'075-882-4412','aleksandra.nowak@mail.com','A16'),('M18','Jurgen','Schmidt','45-55',0,'078-229-7741','jurgen.schmidt@mail.com','A17'),('M19','Zofia','Kowalska','35-45',1,'074-883-2291','z.kowalska@mail.com','A1'),('M2','Lady','McBeth','65-75',0,'986-188-3124','mcbeth@mail.com','A2'),('M20','Naomi','Smith','25-35',1,'074-229-8831','naomi.smith.new@mail.com','A18'),('M21','Fatima','El-Sayed','35-45',2,'073-441-8829','fatima.elsayed@mail.com','A19'),('M22','Zofia','Benson','55-65',0,'071-445-0821','zofia.benson@mail.com','A1'),('M23','Elijah','Benson','18-25',1,'079-112-3345','elijah.benson@mail.com','A1'),('M3','Naomi','Smith','prefer not to say',0,'unknown','unknown','A3'),('M4','Alan','Kuboka','45-55',2,'333-927-5126','kubokaalan@gmail.com','A4'),('M5','Sebastian','Ali','35-45',4,'253-168-7820','ali2@mail.com','A5'),('M6','Mohamed','Seladin','45-55',3,'582-343-9130','seladin.mohamed@mail.com','A6'),('M7','Maimuna','Kibeti','18-25',2,'891-134-8189','kibetienterprises@mail.co.uk','A7'),('M8','Ivy','Duncan','75-85',0,'672-104-1350','unknown','A8'),('M9','Michelle','Mohamed','25-35',1,'none','michellemohamed@mail.co.uk','A9');
/*!40000 ALTER TABLE `members_personal_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 19:37:01
