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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '38da5713-4792-11ef-ad18-001ec969c48d:1-37';

--
-- Table structure for table `food_parcels_for_issue`
--

DROP TABLE IF EXISTS `food_parcels_for_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_parcels_for_issue` (
  `food_parcel_id` varchar(20) NOT NULL,
  `type_of_food` varchar(50) NOT NULL,
  `total_food_parcels_issued` int NOT NULL DEFAULT '0',
  `total_food_parcels_remaining` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`food_parcel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_parcels_for_issue`
--

LOCK TABLES `food_parcels_for_issue` WRITE;
/*!40000 ALTER TABLE `food_parcels_for_issue` DISABLE KEYS */;
INSERT INTO `food_parcels_for_issue` VALUES ('FP01','Normal diet',8,22),('FP02','Halal',0,20),('FP03','Normal diabetic',1,19),('FP04','Vegan',2,18),('FP05','Vegetarian',0,20);
/*!40000 ALTER TABLE `food_parcels_for_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incoming_food_parcels`
--

DROP TABLE IF EXISTS `incoming_food_parcels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incoming_food_parcels` (
  `food_parcel_id` varchar(20) NOT NULL,
  `date_received` date DEFAULT NULL,
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
INSERT INTO `incoming_food_parcels` VALUES ('FP01','2023-12-12',30),('FP04','2023-12-14',20),('FP02','2024-01-08',20),('FP03','2024-01-12',20),('FP05','2023-12-12',20);
/*!40000 ALTER TABLE `incoming_food_parcels` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods` AFTER INSERT ON `incoming_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP01';
    
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods` AFTER INSERT ON `incoming_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP02';
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food` AFTER INSERT ON `incoming_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP03';
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods` AFTER INSERT ON `incoming_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP04';
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods` AFTER INSERT ON `incoming_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP05';
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `incoming_laptop_computers`
--

DROP TABLE IF EXISTS `incoming_laptop_computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incoming_laptop_computers` (
  `laptop_computer_id` varchar(20) NOT NULL,
  `date_received` date DEFAULT NULL,
  `amount_of_laptops_received` int NOT NULL,
  KEY `FK_incoming_laptop_computers_Laptop_computer_id` (`laptop_computer_id`),
  CONSTRAINT `FK_incoming_laptop_computers_Laptop_computer_id` FOREIGN KEY (`laptop_computer_id`) REFERENCES `laptop_computers_for_issue` (`laptop_computer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incoming_laptop_computers`
--

LOCK TABLES `incoming_laptop_computers` WRITE;
/*!40000 ALTER TABLE `incoming_laptop_computers` DISABLE KEYS */;
INSERT INTO `incoming_laptop_computers` VALUES ('COMP01','2023-12-05',20),('COMP01','2024-01-29',10);
/*!40000 ALTER TABLE `incoming_laptop_computers` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_laptop_computer_stock_AFTER_receiving_more_laptops` AFTER INSERT ON `incoming_laptop_computers` FOR EACH ROW BEGIN
	DECLARE v_laptop_computer_id VARCHAR (20);
    SELECT laptop_computer_id
    INTO v_laptop_computer_id
    FROM laptop_computers_for_issue
    WHERE laptop_computer_id = 'COMP01';
    
	IF NEW.laptop_computer_id = v_laptop_computer_id THEN
		UPDATE laptop_computers_for_issue
		SET total_laptops_remaining = total_laptops_remaining + new.amount_of_laptops_received   
		WHERE laptop_computer_id = v_laptop_computer_id; 
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `laptop_computers_for_issue`
--

DROP TABLE IF EXISTS `laptop_computers_for_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laptop_computers_for_issue` (
  `laptop_computer_id` varchar(20) NOT NULL,
  `laptop_computer_type` varchar(30) NOT NULL,
  `total_laptops_issued` int NOT NULL DEFAULT '0',
  `total_laptops_remaining` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`laptop_computer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laptop_computers_for_issue`
--

LOCK TABLES `laptop_computers_for_issue` WRITE;
/*!40000 ALTER TABLE `laptop_computers_for_issue` DISABLE KEYS */;
INSERT INTO `laptop_computers_for_issue` VALUES ('COMP01','Dell Latitude 7390',2,28);
/*!40000 ALTER TABLE `laptop_computers_for_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_support_collection_point`
--

DROP TABLE IF EXISTS `main_support_collection_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_support_collection_point` (
  `collection_point_id` varchar(20) NOT NULL,
  `collection_point_name` varchar(100) NOT NULL,
  `collection_point_location` varchar(50) NOT NULL,
  `collection_point_city` varchar(50) NOT NULL,
  PRIMARY KEY (`collection_point_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_support_collection_point`
--

LOCK TABLES `main_support_collection_point` WRITE;
/*!40000 ALTER TABLE `main_support_collection_point` DISABLE KEYS */;
INSERT INTO `main_support_collection_point` VALUES ('BCC01','British heart foundation','City centre','Birmingham'),('DUD02','Good samaritans','Digbeth','Birmingham'),('ERD01','Church of the savior','Erdington','Birmingham'),('WAL01','Good samaritans','Plex','Walsall'),('WAL02','Swan bank church','Town centre','Walsall');
/*!40000 ALTER TABLE `main_support_collection_point` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `members_address` VALUES ('A01','20','Swingle Close','Halesowen','HH16 8DX','UK'),('A02','57','High Street','Erdington','E15 10BL','UK'),('A03','32','London Road','Birmingham','B15 6DL','UK'),('A04','33','Brixto Street','Walsal','WX2 7HX','UK'),('A05','91','Newtown Walk','Birmingham','B18 6HU','UK'),('A06','47','Bonn Stret','Birmingham','B9 5XU','UK'),('A07','195','Glasgow Street','Dudley','DL27 9JX','UK'),('A08','202','Plex Corner','Walsal','WX5 5BJ','UK'),('A09','115','Good Hope Street','Dudley','DL15 8BX','UK'),('A10','10','Gorsvenor Road','Erdington','E29 8NW','UK'),('A11','129','Daisy Road','Birmingham','B19 8PA','UK'),('ZZZ','No fixed abode','ZZZ','ZZZ','ZZZ','UK');
/*!40000 ALTER TABLE `members_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_issued_food_parcels`
--

DROP TABLE IF EXISTS `members_issued_food_parcels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_issued_food_parcels` (
  `member_id` varchar(10) NOT NULL,
  `food_parcel_id` varchar(20) NOT NULL,
  `collection_point_id` varchar(10) NOT NULL,
  `date_last_issued` date NOT NULL,
  `amount_issued` int NOT NULL,
  KEY `FK_members_issued_food_parcels_Member_id` (`member_id`),
  KEY `FK_members_issued_food_parcels_Food_parcel_id` (`food_parcel_id`),
  KEY `FK_members_issued_food_parcels_Collection_point_id` (`collection_point_id`),
  CONSTRAINT `FK_members_issued_food_parcels_Collection_point_id` FOREIGN KEY (`collection_point_id`) REFERENCES `main_support_collection_point` (`collection_point_id`),
  CONSTRAINT `FK_members_issued_food_parcels_Food_parcel_id` FOREIGN KEY (`food_parcel_id`) REFERENCES `food_parcels_for_issue` (`food_parcel_id`),
  CONSTRAINT `FK_members_issued_food_parcels_Member_id` FOREIGN KEY (`member_id`) REFERENCES `members_personal_details` (`member_id`),
  CONSTRAINT `members_issued_food_parcels_chk_1` CHECK ((`amount_issued` = 1)),
  CONSTRAINT `members_issued_food_parcels_chk_2` CHECK ((`amount_issued` = 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_issued_food_parcels`
--

LOCK TABLES `members_issued_food_parcels` WRITE;
/*!40000 ALTER TABLE `members_issued_food_parcels` DISABLE KEYS */;
INSERT INTO `members_issued_food_parcels` VALUES ('M01','FP01','ERD01','2024-01-22',1),('M02','FP01','ERD01','2024-01-22',1),('M04','FP01','DUD02','2024-01-25',1),('M05','FP01','DUD02','2024-01-18',1),('M06','FP01','WAL01','2023-12-21',1),('M07','FP01','WAL02','2024-01-25',1),('M08','FP01','BCC01','2024-01-23',1),('M09','FP04','WAL01','2024-01-24',1),('M10','FP04','DUD02','2024-01-23',1),('M03','FP01','BCC01','2023-12-21',1),('M10','FP03','DUD02','2025-01-02',1);
/*!40000 ALTER TABLE `members_issued_food_parcels` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_Do_not_issue_food_parcels_BEFORE_due_date` BEFORE INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
    DECLARE last_issue_date DATE;
    -- Ensure you have fetched the correct last issued date for the member
    SELECT MAX(date_last_issued) INTO last_issue_date 
    FROM members_issued_food_parcels
    WHERE member_id = NEW.member_id;
    
    -- Check if the last issue date is within 7 days
    IF last_issue_date IS NOT NULL AND DATEDIFF(curdate(), last_issue_date) < 7 THEN
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'you cannot issue a food parcel more than once within 7 days';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel` AFTER INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP02';
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food` AFTER INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP03';
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel` AFTER INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP04';
    
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel` AFTER INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP05';
    
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel` AFTER INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP01';
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  UNIQUE KEY `member_id` (`member_id`),
  KEY `FK_members_issued_laptop_computers_Laptop_computer_id` (`laptop_computer_id`),
  KEY `FK_members_issued_laptop_computers_Collection_point_id` (`collection_point_id`),
  CONSTRAINT `FK_members_issued_laptop_computers_Collection_point_id` FOREIGN KEY (`collection_point_id`) REFERENCES `main_support_collection_point` (`collection_point_id`),
  CONSTRAINT `FK_members_issued_laptop_computers_Laptop_computer_id` FOREIGN KEY (`laptop_computer_id`) REFERENCES `laptop_computers_for_issue` (`laptop_computer_id`),
  CONSTRAINT `FK_members_issued_laptop_computers_Member_id` FOREIGN KEY (`member_id`) REFERENCES `members_personal_details` (`member_id`),
  CONSTRAINT `members_issued_laptop_computers_chk_1` CHECK ((`amount_issued` = 1)),
  CONSTRAINT `members_issued_laptop_computers_chk_2` CHECK ((`amount_issued` = 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_issued_laptop_computers`
--

LOCK TABLES `members_issued_laptop_computers` WRITE;
/*!40000 ALTER TABLE `members_issued_laptop_computers` DISABLE KEYS */;
INSERT INTO `members_issued_laptop_computers` VALUES ('M01','COMP01','ERD01','2023-12-07',1),('M07','COMP01','WAL02','2024-01-29',1);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop` AFTER INSERT ON `members_issued_laptop_computers` FOR EACH ROW BEGIN
	DECLARE v_laptop_computer_id VARCHAR (20);
    SELECT laptop_computer_id
    INTO v_laptop_computer_id
    FROM laptop_computers_for_issue
    WHERE laptop_computer_id = 'COMP01';
 
	IF NEW.laptop_computer_id = v_laptop_computer_id THEN
		UPDATE laptop_computers_for_issue
		SET total_laptops_issued = total_laptops_issued + NEW.amount_issued   
		WHERE laptop_computer_id = v_laptop_computer_id;
    END IF;

	IF NEW.laptop_computer_id = v_laptop_computer_id THEN
		UPDATE laptop_computers_for_issue
		SET total_laptops_remaining = total_laptops_remaining - NEW.amount_issued   
		WHERE laptop_computer_id =  v_laptop_computer_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  CONSTRAINT `FK_members_personal_details_address_id` FOREIGN KEY (`address_id`) REFERENCES `members_address` (`address_id`),
  CONSTRAINT `members_personal_details_chk_1` CHECK ((`age_range` in (_utf8mb4'18-25',_utf8mb4'25-35',_utf8mb4'35-45',_utf8mb4'45-55',_utf8mb4'55-65',_utf8mb4'65-75',_utf8mb4'75-85',_utf8mb4'85-95',_utf8mb4'95-105',_utf8mb4'105-150',_utf8mb4'prefer not to say')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_personal_details`
--

LOCK TABLES `members_personal_details` WRITE;
/*!40000 ALTER TABLE `members_personal_details` DISABLE KEYS */;
INSERT INTO `members_personal_details` VALUES ('M01','Agatha','Benson','25-35',2,'678-896-1022','benson@mail.com','A01'),('M02','Lady','McBeth','65-75',0,'986-188-3124','mcbeth@mail.com','A02'),('M03','Naomi','Smith','prefer not to say',0,'unknown','unknown','A03'),('M04','Alan','Kuboka','45-55',2,'333-927-5126','kubokaalan@gmail.com','A04'),('M05','Sebastian','Ali','35-45',4,'253-168-7820','ali2@mail.com','A05'),('M06','Mohamed','Seladin','45-55',3,'582-343-9130','seladin.mohamed@mail.com','A06'),('M07','Maimuna','Kibeti','18-25',2,'891-134-8189','kibetienterprises@mail.co.uk','A07'),('M08','Ivy','Duncan','75-85',0,'672-104-1350','unknown','A08'),('M09','Michelle','Mohamed','25-35',1,'none','michellemohamed@mail.co.uk','A09'),('M10','Michael','Blantyre','55-65',2,'unknown','michael.blantyre@mail.co.uk','A10'),('M11','Brian','Kumalo','75-85',2,'unknown','brian.kumalo@mail.co.uk','A11'),('M12','Jack','Maideni','35-45',0,'none','unknown','ZZZ');
/*!40000 ALTER TABLE `members_personal_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations_log`
--

DROP TABLE IF EXISTS `migrations_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `script_name` varchar(255) NOT NULL,
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `script_name` (`script_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations_log`
--

LOCK TABLES `migrations_log` WRITE;
/*!40000 ALTER TABLE `migrations_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations_log` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `FK_other_support_requested_by_members_Member_id` FOREIGN KEY (`member_id`) REFERENCES `members_personal_details` (`member_id`),
  CONSTRAINT `FK_other_support_requested_by_members_Type_of_support_id` FOREIGN KEY (`type_of_support_id`) REFERENCES `other_types_of_support_available_for_members` (`type_of_support_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_support_requested_by_members`
--

LOCK TABLES `other_support_requested_by_members` WRITE;
/*!40000 ALTER TABLE `other_support_requested_by_members` DISABLE KEYS */;
INSERT INTO `other_support_requested_by_members` VALUES ('M01','SUP01','2024-01-18','awaiting allocation','awaiting allocation'),('M02','SUP02','2023-07-03','applied for benefits','referral closed'),('M02','SUP03','2023-12-12','referred to another agency','referral closed'),('M05','SUP12','2023-07-10','advice and information','referral closed'),('M08','SUP05','2023-12-20','allocated to a worker','support ongoing'),('M08','SUP06','2023-07-20','allocated to a worker','support ongoing'),('M06','SUP07','2024-01-26','awaiting allocation','awaiting allocation'),('M06','SUP08','2023-05-10','advice and information','referral closed'),('M03','SUP09','2023-06-12','referred to another agency','referral closed'),('M03','SUP10','2023-06-12','allocated to a worker','support ongoing'),('M05','SUP04','2023-08-31','applied for housing','referral closed'),('M05','SUP03','2023-12-12','awaiting allocation','awaiting allocation'),('M01','SUP02','2024-01-20','awaiting allocation','awaiting allocation'),('M10','SUP11','2023-05-10','allocated to a worker','support ongoing'),('M04','SUP06','2023-05-25','applied for debt relief','referral closed'),('M07','SUP06','2023-09-10','allocated to a worker','support ongoing'),('M12','SUP03','2024-01-24','awaiting allocation','awaiting allocation');
/*!40000 ALTER TABLE `other_support_requested_by_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `other_types_of_support_available_for_members`
--

DROP TABLE IF EXISTS `other_types_of_support_available_for_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_types_of_support_available_for_members` (
  `type_of_support_id` varchar(20) NOT NULL,
  `type_of_support` varchar(100) NOT NULL,
  PRIMARY KEY (`type_of_support_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_types_of_support_available_for_members`
--

LOCK TABLES `other_types_of_support_available_for_members` WRITE;
/*!40000 ALTER TABLE `other_types_of_support_available_for_members` DISABLE KEYS */;
INSERT INTO `other_types_of_support_available_for_members` VALUES ('SUP01','advice on welfare benefits'),('SUP02','applying for welfare benefits'),('SUP03','housing'),('SUP04','homelessness'),('SUP05','sourcing furniture'),('SUP06','debts advice'),('SUP07','register with a GP'),('SUP08','attending medical appointments'),('SUP09','caring for elderly, sick or disabled people'),('SUP10','carers support'),('SUP11','interpreter'),('SUP12','other');
/*!40000 ALTER TABLE `other_types_of_support_available_for_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_members_due_or_not_due_for_food_parcels`
--

DROP TABLE IF EXISTS `view_members_due_or_not_due_for_food_parcels`;
/*!50001 DROP VIEW IF EXISTS `view_members_due_or_not_due_for_food_parcels`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_members_due_or_not_due_for_food_parcels` AS SELECT 
 1 AS `member_id`,
 1 AS `members_name`,
 1 AS `post_code`,
 1 AS `type_of_food`,
 1 AS `collection_point`,
 1 AS `date_last_collected_a_food_parcel`,
 1 AS `days_since_last_collection`,
 1 AS `date_due_for_next_collection`,
 1 AS `Issue_a_food_parcel_today_or_Not`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_members_issued_or_not_issued_with_food_parcels`
--

DROP TABLE IF EXISTS `view_members_issued_or_not_issued_with_food_parcels`;
/*!50001 DROP VIEW IF EXISTS `view_members_issued_or_not_issued_with_food_parcels`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_members_issued_or_not_issued_with_food_parcels` AS SELECT 
 1 AS `member_id`,
 1 AS `members_name`,
 1 AS `post_code`,
 1 AS `type_of_food`,
 1 AS `collection_point_location`,
 1 AS `date_last_issued`,
 1 AS `days_since_last_issue`,
 1 AS `next_issue_due_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_members_issued_with_laptops`
--

DROP TABLE IF EXISTS `view_members_issued_with_laptops`;
/*!50001 DROP VIEW IF EXISTS `view_members_issued_with_laptops`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_members_issued_with_laptops` AS SELECT 
 1 AS `member_id`,
 1 AS `members_name`,
 1 AS `post_code`,
 1 AS `main_contact_number`,
 1 AS `email_address`,
 1 AS `laptop_computer_type`,
 1 AS `date_issued`,
 1 AS `collection_point_location`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_support_ongoing_or_awaiting_allocation`
--

DROP TABLE IF EXISTS `view_support_ongoing_or_awaiting_allocation`;
/*!50001 DROP VIEW IF EXISTS `view_support_ongoing_or_awaiting_allocation`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_support_ongoing_or_awaiting_allocation` AS SELECT 
 1 AS `member_id`,
 1 AS `members_name`,
 1 AS `post_code`,
 1 AS `type_of_support`,
 1 AS `date_requested`,
 1 AS `initial_outcome`,
 1 AS `current_status_of_request`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'beths_new_food_pantry'
--

--
-- Dumping routines for database 'beths_new_food_pantry'
--
/*!50003 DROP FUNCTION IF EXISTS `full_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `full_name`(first_name VARCHAR(20), last_name VARCHAR(20)) RETURNS varchar(55) CHARSET utf8mb4
    DETERMINISTIC
RETURN CONCAT(first_name, ' ', last_name); ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Sproc_issue_a_FOOD_parcel_IF_one_is_due` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sproc_issue_a_FOOD_parcel_IF_one_is_due`(IN member_id VARCHAR (10), IN food_parcel_id VARCHAR (20),
	IN collection_point_id VARCHAR (10), IN date_last_issued DATE, IN amount_issued INT)
BEGIN
	INSERT INTO members_issued_food_parcels
	(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
	VALUES    
	(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_members_due_or_not_due_for_food_parcels`
--

/*!50001 DROP VIEW IF EXISTS `view_members_due_or_not_due_for_food_parcels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_members_due_or_not_due_for_food_parcels` AS select `view_members_issued_or_not_issued_with_food_parcels`.`member_id` AS `member_id`,`view_members_issued_or_not_issued_with_food_parcels`.`members_name` AS `members_name`,`view_members_issued_or_not_issued_with_food_parcels`.`post_code` AS `post_code`,`view_members_issued_or_not_issued_with_food_parcels`.`type_of_food` AS `type_of_food`,`view_members_issued_or_not_issued_with_food_parcels`.`collection_point_location` AS `collection_point`,`view_members_issued_or_not_issued_with_food_parcels`.`date_last_issued` AS `date_last_collected_a_food_parcel`,`view_members_issued_or_not_issued_with_food_parcels`.`days_since_last_issue` AS `days_since_last_collection`,`view_members_issued_or_not_issued_with_food_parcels`.`next_issue_due_date` AS `date_due_for_next_collection`,if(((`view_members_issued_or_not_issued_with_food_parcels`.`date_last_issued` is null) or (`view_members_issued_or_not_issued_with_food_parcels`.`days_since_last_issue` >= 7)),'YES',concat('NO. Please ask the member to come back on or after ',`view_members_issued_or_not_issued_with_food_parcels`.`next_issue_due_date`)) AS `Issue_a_food_parcel_today_or_Not` from `view_members_issued_or_not_issued_with_food_parcels` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_members_issued_or_not_issued_with_food_parcels`
--

/*!50001 DROP VIEW IF EXISTS `view_members_issued_or_not_issued_with_food_parcels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_members_issued_or_not_issued_with_food_parcels` AS select `mpd`.`member_id` AS `member_id`,concat(`mpd`.`first_name`,' ',`mpd`.`last_name`) AS `members_name`,`ma`.`post_code` AS `post_code`,`fpfi`.`type_of_food` AS `type_of_food`,concat(`mscp`.`collection_point_name`,', ',`mscp`.`collection_point_location`,', ',`mscp`.`collection_point_city`) AS `collection_point_location`,`latest_issued`.`date_last_issued` AS `date_last_issued`,(to_days(curdate()) - to_days(`latest_issued`.`date_last_issued`)) AS `days_since_last_issue`,(`latest_issued`.`date_last_issued` + interval 7 day) AS `next_issue_due_date` from (((((`members_personal_details` `mpd` left join `members_address` `ma` on((`ma`.`address_id` = `mpd`.`address_id`))) left join (select `members_issued_food_parcels`.`member_id` AS `member_id`,max(`members_issued_food_parcels`.`date_last_issued`) AS `date_last_issued` from `members_issued_food_parcels` group by `members_issued_food_parcels`.`member_id`) `latest_issued` on((`mpd`.`member_id` = `latest_issued`.`member_id`))) left join `members_issued_food_parcels` `mifp` on(((`mpd`.`member_id` = `mifp`.`member_id`) and (`latest_issued`.`date_last_issued` = `mifp`.`date_last_issued`)))) left join `food_parcels_for_issue` `fpfi` on((`mifp`.`food_parcel_id` = `fpfi`.`food_parcel_id`))) left join `main_support_collection_point` `mscp` on((`mscp`.`collection_point_id` = `mifp`.`collection_point_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_members_issued_with_laptops`
--

/*!50001 DROP VIEW IF EXISTS `view_members_issued_with_laptops`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_members_issued_with_laptops` AS select `mpd`.`member_id` AS `member_id`,`full_name`(`mpd`.`first_name`,`mpd`.`last_name`) AS `members_name`,`ma`.`post_code` AS `post_code`,`mpd`.`main_contact_number` AS `main_contact_number`,`mpd`.`email_address` AS `email_address`,`lci`.`laptop_computer_type` AS `laptop_computer_type`,`milc`.`date_issued` AS `date_issued`,concat(`mscp`.`collection_point_name`,', ',`mscp`.`collection_point_location`,', ',`mscp`.`collection_point_city`) AS `collection_point_location` from ((((`members_personal_details` `mpd` join `members_address` `ma` on((`ma`.`address_id` = `mpd`.`address_id`))) join `members_issued_laptop_computers` `milc` on((`mpd`.`member_id` = `milc`.`member_id`))) join `laptop_computers_for_issue` `lci` on((`milc`.`laptop_computer_id` = `lci`.`laptop_computer_id`))) join `main_support_collection_point` `mscp` on((`mscp`.`collection_point_id` = `milc`.`collection_point_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_support_ongoing_or_awaiting_allocation`
--

/*!50001 DROP VIEW IF EXISTS `view_support_ongoing_or_awaiting_allocation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_support_ongoing_or_awaiting_allocation` AS select `mpd`.`member_id` AS `member_id`,`full_name`(`mpd`.`first_name`,`mpd`.`last_name`) AS `members_name`,`ma`.`post_code` AS `post_code`,`ots`.`type_of_support` AS `type_of_support`,`osr`.`date_requested` AS `date_requested`,`osr`.`initial_outcome_of_request` AS `initial_outcome`,`osr`.`current_status_of_request` AS `current_status_of_request` from (((`members_personal_details` `mpd` join `members_address` `ma` on((`ma`.`address_id` = `mpd`.`address_id`))) join `other_support_requested_by_members` `osr` on((`mpd`.`member_id` = `osr`.`member_id`))) join `other_types_of_support_available_for_members` `ots` on((`ots`.`type_of_support_id` = `osr`.`type_of_support_id`))) where ((`osr`.`current_status_of_request` = 'awaiting allocation') or (`osr`.`current_status_of_request` = 'support ongoing')) order by `osr`.`current_status_of_request`,`osr`.`date_requested` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-10 23:26:06
