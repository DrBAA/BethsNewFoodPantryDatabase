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
-- Temporary view structure for view `view_member_full_details`
--

DROP TABLE IF EXISTS `view_member_full_details`;
/*!50001 DROP VIEW IF EXISTS `view_member_full_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_member_full_details` AS SELECT 
 1 AS `member_id`,
 1 AS `members_name`,
 1 AS `age_range`,
 1 AS `dependants_under_18`,
 1 AS `main_contact_number`,
 1 AS `email_address`,
 1 AS `house_number`,
 1 AS `street_name`,
 1 AS `city_or_town`,
 1 AS `post_code`*/;
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
-- Temporary view structure for view `view_member_address_and_contact`
--

DROP TABLE IF EXISTS `view_member_address_and_contact`;
/*!50001 DROP VIEW IF EXISTS `view_member_address_and_contact`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_member_address_and_contact` AS SELECT 
 1 AS `member_id`,
 1 AS `members_name`,
 1 AS `age_range`,
 1 AS `dependants_under_18`,
 1 AS `main_contact_number`,
 1 AS `email_address`,
 1 AS `house_number`,
 1 AS `street_name`,
 1 AS `city_or_town`,
 1 AS `post_code`*/;
SET character_set_client = @saved_cs_client;

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

--
-- Final view structure for view `view_member_full_details`
--

/*!50001 DROP VIEW IF EXISTS `view_member_full_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_member_full_details` AS select `mpd`.`member_id` AS `member_id`,concat(`mpd`.`first_name`,' ',`mpd`.`last_name`) AS `members_name`,`mpd`.`age_range` AS `age_range`,`mpd`.`dependants_under_18` AS `dependants_under_18`,`mpd`.`main_contact_number` AS `main_contact_number`,`mpd`.`email_address` AS `email_address`,`ma`.`house_number` AS `house_number`,`ma`.`street_name` AS `street_name`,`ma`.`city_or_town` AS `city_or_town`,`ma`.`post_code` AS `post_code` from (`members_personal_details` `mpd` join (select `members_address`.`address_id` AS `address_id`,`members_address`.`house_number` AS `house_number`,`members_address`.`street_name` AS `street_name`,`members_address`.`city_or_town` AS `city_or_town`,`members_address`.`post_code` AS `post_code` from `members_address`) `ma` on((`mpd`.`address_id` = `ma`.`address_id`))) */;
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
/*!50001 VIEW `view_members_due_or_not_due_for_food_parcels` AS select `view_members_issued_or_not_issued_with_food_parcels`.`member_id` AS `member_id`,`view_members_issued_or_not_issued_with_food_parcels`.`members_name` AS `members_name`,`view_members_issued_or_not_issued_with_food_parcels`.`post_code` AS `post_code`,`view_members_issued_or_not_issued_with_food_parcels`.`type_of_food` AS `type_of_food`,`view_members_issued_or_not_issued_with_food_parcels`.`collection_point_location` AS `collection_point`,`view_members_issued_or_not_issued_with_food_parcels`.`date_last_issued` AS `date_last_collected_a_food_parcel`,`view_members_issued_or_not_issued_with_food_parcels`.`days_since_last_issue` AS `days_since_last_collection`,`view_members_issued_or_not_issued_with_food_parcels`.`next_issue_due_date` AS `date_due_for_next_collection`,if(((`view_members_issued_or_not_issued_with_food_parcels`.`date_last_issued` is null) or (`view_members_issued_or_not_issued_with_food_parcels`.`days_since_last_issue` >= 7)),'YES, issue a food parcel',concat('NO. Please come back on or after ',`view_members_issued_or_not_issued_with_food_parcels`.`next_issue_due_date`)) AS `Issue_a_food_parcel_today_or_Not` from `view_members_issued_or_not_issued_with_food_parcels` order by `view_members_issued_or_not_issued_with_food_parcels`.`members_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_member_address_and_contact`
--

/*!50001 DROP VIEW IF EXISTS `view_member_address_and_contact`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_member_address_and_contact` AS select `view_member_full_details`.`member_id` AS `member_id`,`view_member_full_details`.`members_name` AS `members_name`,`view_member_full_details`.`age_range` AS `age_range`,`view_member_full_details`.`dependants_under_18` AS `dependants_under_18`,`view_member_full_details`.`main_contact_number` AS `main_contact_number`,`view_member_full_details`.`email_address` AS `email_address`,`view_member_full_details`.`house_number` AS `house_number`,`view_member_full_details`.`street_name` AS `street_name`,`view_member_full_details`.`city_or_town` AS `city_or_town`,`view_member_full_details`.`post_code` AS `post_code` from `view_member_full_details` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sproc_issue_a_FOOD_parcel_IF_one_is_due`(IN member_id VARCHAR(10), IN food_parcel_id VARCHAR(20),
     IN collection_point_id VARCHAR(10), IN date_last_issued DATE, IN amount_issued INT)
BEGIN
-- Declare local variables
    DECLARE v_amount_issued INT;
    DECLARE v_date_last_issued DATE;
    DECLARE v_member_id_clean VARCHAR(10); -- added 17/8/2025
    
    -- Assign default value if amount_issued is NULL
    SET v_amount_issued = IFNULL(amount_issued, 1);
    
    -- Assign default value if date_last_issued is NULL
    SET v_date_last_issued = IFNULL(date_last_issued, CURDATE());

	-- Capitalize 'm' if needed -- added 17/8/2025
		SET v_member_id_clean = 
			CASE 
				WHEN LOWER(LEFT(member_id, 1)) = 'm' THEN 
					CONCAT('M', SUBSTRING(member_id, 2))
				ELSE member_id
			END;
            
    -- Insert into the table
    INSERT INTO members_issued_food_parcels
    (member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
    VALUES
    (v_member_id_clean, food_parcel_id, collection_point_id, date_last_issued, amount_issued); -- changed from member_id to v_member_id_clean added 17/8/2025
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_update_food_parcels_stock_AFTER_ISSUING_food_parcels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_update_food_parcels_stock_AFTER_ISSUING_food_parcels`(
    IN p_food_parcel_id VARCHAR(20), 
    IN p_amount_issued INT
)
BEGIN
    -- Declare variables
    DECLARE dummy_var VARCHAR(20);
    
    -- Declare error handlers (without rollback)
    DECLARE EXIT HANDLER FOR SQLSTATE '40001'
    BEGIN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Deadlock detected: Operation stopped.';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Unexpected error occurred.';
    END;
    
    -- Lock row before updating
    SELECT food_parcel_id INTO dummy_var
    FROM food_parcels_for_issue
    WHERE food_parcel_id = p_food_parcel_id
    FOR UPDATE;
       
    -- Perform the update
    UPDATE food_parcels_for_issue
    SET total_food_parcels_issued = total_food_parcels_issued + p_amount_issued,
        total_food_parcels_remaining = total_food_parcels_remaining - p_amount_issued
    WHERE food_parcel_id = p_food_parcel_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_update_food_parcels_stock_AFTER_receiving_food_parcels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_update_food_parcels_stock_AFTER_receiving_food_parcels`(
    IN p_food_parcel_id VARCHAR(20), 
    IN p_amount_received INT
)
BEGIN
    -- Declare error handlers for rollback
    DECLARE EXIT HANDLER FOR SQLSTATE '40001'
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Deadlock detected: Transaction rolled back. Try again later.';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'An unexpected error occurred. Transaction rolled back.';
    END;
    
    -- Set timeout to avoid long waits for locks
    SET innodb_lock_wait_timeout = 5; 
    
    -- Start transaction explicitly
    START TRANSACTION;

    -- Lock the correct row before updating
    SELECT food_parcel_id 
    FROM food_parcels_for_issue 
    WHERE food_parcel_id = p_food_parcel_id
    FOR UPDATE;

    -- Perform the update after locking
    UPDATE food_parcels_for_issue
    SET total_food_parcels_remaining = total_food_parcels_remaining + p_amount_received
    WHERE food_parcel_id = p_food_parcel_id;

    -- Commit if everything runs successfully
    COMMIT;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_update_laptop_computers_stock_AFTER_ISSUING_laptops` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_update_laptop_computers_stock_AFTER_ISSUING_laptops`(
    IN p_laptop_computer_id VARCHAR(20), 
    IN p_amount_issued INT
)
BEGIN
    -- Declare error handlers for rollback
    DECLARE EXIT HANDLER FOR SQLSTATE '40001'
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Deadlock detected: Transaction rolled back. Try again later.';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'An unexpected error occurred. Transaction rolled back.';
    END;
    
    -- Set timeout to avoid long waits for locks
    SET innodb_lock_wait_timeout = 5; 
    
    -- Start transaction explicitly
    START TRANSACTION;

    -- Lock the correct row before updating
    SELECT laptop_computer_id 
    FROM laptop_computers_for_issue 
    WHERE laptop_computer_id = p_laptop_computer_id
    FOR UPDATE;

    -- Perform the update after locking
    UPDATE laptop_computers_for_issue
    SET total_laptops_issued = total_laptops_issued + p_amount_issued,
        total_laptops_remaining = total_laptops_remaining - p_amount_issued
    WHERE laptop_computer_id = p_laptop_computer_id;

    -- Commit if everything runs successfully
    COMMIT;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_update_laptop_computers_stock_AFTER_RECEIVING_laptops` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_update_laptop_computers_stock_AFTER_RECEIVING_laptops`(
    IN p_laptop_computer_id VARCHAR(20), 
    IN p_amount_received INT
)
BEGIN
    -- Declare error handlers for rollback
    DECLARE EXIT HANDLER FOR SQLSTATE '40001'
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Deadlock detected: Transaction rolled back. Try again later.';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'An unexpected error occurred. Transaction rolled back.';
    END;
    
    -- Set timeout to avoid long waits for locks
    SET innodb_lock_wait_timeout = 5; 
    
    -- Start transaction explicitly
    START TRANSACTION;

    -- Lock the correct row before updating
    SELECT laptop_computer_id 
    FROM laptop_computers_for_issue 
    WHERE laptop_computer_id = p_laptop_computer_id
    FOR UPDATE;

    -- Perform the update after locking
    UPDATE laptop_computers_for_issue
    SET total_laptops_remaining = total_laptops_remaining + p_amount_received
    WHERE laptop_computer_id = p_laptop_computer_id;

    -- Commit if everything runs successfully
    COMMIT;
    
END ;;
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

-- Dump completed on 2025-12-06 19:37:10
