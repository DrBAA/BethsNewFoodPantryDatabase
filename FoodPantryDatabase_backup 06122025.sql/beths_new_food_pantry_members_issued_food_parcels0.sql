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
  CONSTRAINT `FK_members_issued_food_parcels_Member_id` FOREIGN KEY (`member_id`) REFERENCES `members_personal_details` (`member_id`) ON UPDATE CASCADE,
  CONSTRAINT `members_issued_food_parcels_chk_1` CHECK ((`amount_issued` = 1)),
  CONSTRAINT `members_issued_food_parcels_chk_2` CHECK ((`amount_issued` = 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_issued_food_parcels`
--

LOCK TABLES `members_issued_food_parcels` WRITE;
/*!40000 ALTER TABLE `members_issued_food_parcels` DISABLE KEYS */;
INSERT INTO `members_issued_food_parcels` VALUES ('M1','FP01','ERD01','2024-01-22',1),('M2','FP01','ERD01','2024-01-22',1),('M4','FP01','DUD02','2024-01-25',1),('M5','FP01','DUD02','2024-01-18',1),('M6','FP01','WAL01','2023-12-21',1),('M7','FP01','WAL02','2024-01-25',1),('M8','FP01','BCC01','2024-01-23',1),('M9','FP04','WAL01','2024-01-24',1),('M10','FP04','DUD02','2024-01-23',1),('M3','FP01','BCC01','2023-12-21',1),('M10','FP03','DUD02','2025-01-02',1),('M1','FP01','ERD01','2025-03-09',1),('M6','FP02','WAL01','2025-03-09',1),('M10','FP05','ERD01','2025-03-09',1),('M6','FP02','WAL01','2025-05-16',1),('M10','FP05','ERD01','2025-05-17',1),('M8','FP01','BCC01','2025-05-18',1),('M6','FP02','WAL01','2025-05-31',1),('M1','FP01','ERD01','2025-05-31',1),('M7','FP01','WAL02','2025-06-05',1),('M10','FP03','DUD02','2025-06-05',1),('M12','FP04','ERD01','2025-06-05',1),('M8','FP05','BCC01','2025-06-05',1),('M9','FP02','WAL02','2025-06-05',1),('M5','FP05','DUD02','2025-06-06',1),('M4','FP04','DUD02','2025-06-06',1),('M6','FP02','WAL01','2025-06-07',1),('M6','FP02','WAL01','2025-06-16',1),('M6','FP02','WAL01','2025-07-06',1),('M3','FP01','BCC01','2025-07-11',1),('M12','FP04','ERD01','2025-07-17',1),('M6','FP02','WAL01','2025-07-19',1),('M5','FP05','DUD02','2025-07-21',1),('M6','FP02','BCC01','2025-08-11',1),('M21','FP02','BCC01','2025-08-23',1),('M6','FP02','BCC01','2025-08-23',1),('M22','FP02','BCC01','2025-08-23',1),('M14','FP01','WAL02','2025-08-28',1),('M20','FP03','BCC01','2025-09-13',1),('M21','FP02','BCC01','2025-09-25',1),('M19','FP04','DUD02','2025-09-27',1),('M16','FP05','WAL02','2025-09-27',1),('M8','FP03','WAL01','2025-09-28',1),('M18','FP03','BCC01','2025-09-28',1),('M2','FP01','ERD01','2025-10-01',1),('M23','FP04','BCC01','2025-10-01',1),('M13','FP03','WAL01','2025-10-01',1),('M1','FP01','ERD01','2025-10-05',1),('M17','FP04','DUD02','2025-10-05',1),('M15','FP03','WAL01','2025-10-05',1),('M11','FP05','BCC01','2025-10-05',1),('M7','FP01','BCC01','2025-10-05',1),('M10','FP03','WAL01','2025-10-05',1),('M9','FP02','WAL02','2025-10-05',1),('M4','FP04','DUD02','2025-10-05',1),('M5','FP05','DUD02','2025-10-06',1),('M22','FP02','BCC01','2025-10-07',1),('M6','FP02','WAL02','2025-10-07',1),('M16','FP05','WAL02','2025-10-08',1),('M21','FP02','DUD02','2025-10-08',1),('M19','FP04','WAL01','2025-10-22',1),('M4','FP06','BCC01','2025-10-25',1),('M15','FP06','BCC01','2025-10-25',1),('M23','FP04','BCC01','2025-11-08',1),('M1','FP01','ERD01','2025-12-04',1),('M5','FP05','DUD02','2025-12-04',1);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_check_FOOD_PARCELS_stock_BEFORE_issue` BEFORE INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
    DECLARE available_stock INT;

    -- Check stock level before allowing the insert
    SELECT total_food_parcels_remaining INTO available_stock
    FROM food_parcels_for_issue
    WHERE food_parcel_id = NEW.food_parcel_id;

    -- If stock is insufficient, prevent insertion and rollback
    IF available_stock < NEW.amount_issued THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock available to issue requested food parcel';
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_update_food_parcels_stock_AFTER_ISSUING_food_parcels` AFTER INSERT ON `members_issued_food_parcels` FOR EACH ROW BEGIN
    CALL SP_update_food_parcels_stock_AFTER_ISSUING_food_parcels(NEW.food_parcel_id, NEW.amount_issued);
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

-- Dump completed on 2025-12-06 19:36:31
