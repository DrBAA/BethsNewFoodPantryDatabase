USE beths_new_food_pantry;

***************************************    TRIGGERS AFTER ISSUING FOOD PARCELS     **********************************************

-- ==============================================================================================================================
-- a TRIGGER which AUTOMATICALLY updates the NORMAL DIET FOOD (FP01) PARCELS STOCK LEVELS after issuing A NORMAL DIET FOOD PARCEL 
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;
    
-- ==============================================================================================================================
-- A TRIGGER which AUTOMATICALLY updates the HALAL FOOD (FP02) PARCELS STOCK LEVELS after issuing A HALAL FOOD PARCEL 
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;
    
    
-- ===============================================================================================================================

-- a TRIGGER which AUTOMATICALLY updates the NORMAL DIABETIC FOOD (FP03) PARCELS STOCK LEVELS after issuing
-- A NORMAL DIABETIC FOOD PARCEL  

-- ===============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food

DELIMITER $$
CREATE TRIGGER TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;
    

-- ===============================================================================================================================
-- a TRIGGER which AUTOMATICALLY updates the VEGAN FOOD (FP04) PARCELS STOCK LEVELS after issuing A VEGAN FOOD PARCEL 
-- ===============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;

-- =============================================================================================================================

-- a TRIGGER which AUTOMATICALLY updates the VEGETARIAN FOOD (FP05) PARCELS STOCK LEVELS after issuing A
VEGETARIAN FOOD PARCEL 

-- =============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;



-- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY
						**** TRIGGERS AFTER INCOMING FOOD PARCELS  ****************
-- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY

- a TRIGGER which AUTOMATICALLY updates the NORMAL DIET (FP01) FOOD PARCELS STOCK LEVELS
AFTER RECEIVING MORE NORMAL DIET FOOD PARCELS

-- =======================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods
AFTER INSERT ON incoming_food_parcels
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;


-- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY

- Create a TRIGGER which AUTOMATICALLY updates the HALAL (FP02) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE HALAL FOODS

-- =======================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
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
END $$
DELIMITER ;


-- ==============================================================================================================================
- Create a TRIGGER which AUTOMATICALLY updates the NORMAL DIABETIC (FP03) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE NORMAL DIABETIC FOODS
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food

DELIMITER $$
CREATE TRIGGER TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
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
END $$
DELIMITER ;


-- ==============================================================================================================================
- Create a TRIGGER which AUTOMATICALLY updates the VEGAN (FP04) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE VEGAN FOODS
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
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
END $$
DELIMITER ;

    
SELECT * FROM beths_new_food_pantry.incoming_food_parcels;
SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;



-- ==============================================================================================================================
- Create a TRIGGER which AUTOMATICALLY updates the HALAL (FP05) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE VEGETARIAN FOODS
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
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
END $$
DELIMITER ;



-- ==============================================================================================================================
					*********************************	TRIGGERS FOR LAPTOPS ********************************
-- ==============================================================================================================================

- Create a TRIGGER which AUTOMATICALLY updates the LAPTOP COMPUTERS STOCK LEVELS AFTER RECEIVING MORE LAPTOPS

DROP TRIGGER IF EXISTS TR_update_laptop_computer_stock_AFTER_receiving_more_laptops


DELIMITER $$
CREATE TRIGGER TR_update_laptop_computer_stock_AFTER_receiving_more_laptops
AFTER INSERT ON incoming_laptop_computers
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;

SELECT * FROM beths_new_food_pantry.incoming_laptop_computers;
SELECT * FROM beths_new_food_pantry.laptop_computers_for_issue;
-- ================================================================================================================================


-- ==============================================================================================================================
- Create a TRIGGER which AUTOMATICALLY updates the LAPTOP COMPUTERS STOCK LEVELS AFTER ISSUING A LAPTOP TO A MEMBER
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop

DELIMITER $$
CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop
AFTER INSERT ON members_issued_laptop_computers
FOR EACH ROW
BEGIN
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
END $$
DELIMITER ;

SELECT * FROM beths_new_food_pantry.members_issued_laptop_computers;
SELECT * FROM beths_new_food_pantry.laptop_computers_for_issue;


-- ==============================================================================================================================
-- A TRIGGER TO ENSURE THAT A MEMBER IS NOT ISSUED A FOOD PARCEL MORE THAN ONCE IN THE SPACE OF 7 DAYS
-- ==============================================================================================================================

/* 02/1/2024 - AMENDED TRIGGER - To ensure the trigger fetched the correct last issued date, I used a query to select the maximum
date_last_issued for a member. This allowed the trigger to identify the most recent date and compare it to the current date in order
to check if the difference between the current date and the last issue date was less than 7 days. This enforced the rule that a member
couldn't receive a food parcel more than once within 7 days.
*/
DROP TRIGGER IF EXISTS TR_Do_not_issue_food_parcels_BEFORE_due_date;

DELIMITER $$
CREATE TRIGGER TR_Do_not_issue_food_parcels_BEFORE_due_date
BEFORE INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
    DECLARE last_issue_date DATE;
    -- Ensure you have fetched the correct last issued date for the member
    SELECT MAX(date_last_issued) INTO last_issue_date 
    FROM members_issued_food_parcels
    WHERE member_id = NEW.member_id;
    
    -- Check if the last issue date is within 7 days
    IF last_issue_date IS NOT NULL AND DATEDIFF(curdate(), last_issue_date) < 7 THEN
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'you cannot issue a food parcel more than once within 7 days';
    END IF;
END $$
DELIMITER ;

-- PREVIOUS TRIGGER - was fetching the wrong issue date if people had been issued a food parcel more than once
/*
DROP TRIGGER IF EXISTS TR_Do_not_issue_food_parcels_BEFORE_due_date;
DELIMITER $$
CREATE TRIGGER TR_Do_not_issue_food_parcels_BEFORE_due_date
BEFORE INSERT
ON members_issued_food_parcels
FOR EACH ROW
BEGIN
IF DATEDIFF(curdate(), NEW.date_last_issued) < 7 THEN
	SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'you cannot issue a food parcel more than once within 7 days';
END IF;
END $$
DELIMITER ;
*/

 


-- ==============================================================================================================================
     *********************************************** STORED PROCEDURES **************************************************
-- ==============================================================================================================================



-- STORED PROCEDURE TO ISSUE A FOOD PARCEL

DROP PROCEDURE IF EXISTS Sproc_issue_a_FOOD_parcel_IF_one_is_due

DELIMITER $$
CREATE PROCEDURE  Sproc_issue_a_FOOD_parcel_IF_one_is_due
	(IN member_id VARCHAR (10), IN food_parcel_id VARCHAR (20),
	IN collection_point_id VARCHAR (10), IN date_last_issued DATE, IN amount_issued INT)

BEGIN
	INSERT INTO members_issued_food_parcels
	(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
	VALUES    
	(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued);
END $$
DELIMITER ;

-- ====================================================================================================== UNDER CONSTRUCTION
-- STORED PROCEDURE TO CHECK IF ONE CAN HAVE A FOOD PARCEL TODAY THEN ISSUE ONE IF THEY ARE DUE

-- DELIMITER $$
-- CREATE PROCEDURE  Sproc_Check_and_Issue_a_FOOD_parcel_IF_one_is_due
-- (IN member_id VARCHAR (10), IN food_parcel_id VARCHAR (20),
-- IN collection_point_id VARCHAR (10), IN date_last_issued DATE, IN amount_issued INT)
-- OUT member_id VARCHAR (10), OUT food_parcel_id VARCHAR (20), OUT collection_point_id VARCHAR (10), OUT date_last_issued DATE, OUT amount_issued INT)

-- BEGIN
-- 	INSERT INTO members_issued_food_parcels
-- 	(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
-- 	VALUES    
-- 		(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued);  
-- END $$
-- DELIMITER ;
