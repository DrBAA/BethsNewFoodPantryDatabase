USE beths_new_food_pantry;

************* TRIGGERS AFTER ISSUING FOOD PARCELS - UPDATED 05/6/2025 TO REMOVE REDUNDANT CODE FOR CHECKING FOOD PARCELS TWCIE *******************


-- ==============================================================================================================================

-- Stored procedure and trigger for automatically updating food parcel stock levels after ISSUING ANY TYPE OF FOOD parcel


DELIMITER $$

CREATE PROCEDURE SP_update_food_parcels_stock_levels_AFTER_issuing_ANY_food_parcel (
    IN p_food_parcel_id VARCHAR(20), 
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
    SELECT food_parcel_id 
    FROM food_parcels_for_issue 
    WHERE food_parcel_id = p_food_parcel_id
    FOR UPDATE;

    -- Perform the update after locking
    UPDATE food_parcels_for_issue
    SET total_food_parcels_issued = total_food_parcels_issued + p_amount_issued,
        total_food_parcels_remaining = total_food_parcels_remaining - p_amount_issued
    WHERE food_parcel_id = p_food_parcel_id;

    -- Commit if everything runs successfully
    COMMIT;
    
END $$

DELIMITER ;

-- ==============================================================================================================================
-- Trigger to Call the ABOVE Stored Procedure
DELIMITER $$

CREATE TRIGGER TR_update_food_parcels_stock_levels_AFTER_issuing_ANY_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
    CALL SP_update_food_parcels_stock_levels_AFTER_issuing_ANY_food_parcel(NEW.food_parcel_id, NEW.amount_issued);
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Stored procedure and trigger for automatically updating food parcel stock levels after receiving more parcels, ensuring rollback capabilities and dynamic row locking:

DELIMITER $$

CREATE PROCEDURE SP_update_food_parcels_stock_levels_AFTER_receiving_ANY_type_of_food_parcels (
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
    
END $$

DELIMITER ;


-- ==============================================================================================================================

-- Trigger to Call the ABOVE Stored Procedure
DELIMITER $$

CREATE TRIGGER TR_update_food_parcels_stock_levels_AFTER_receiving_ANY_type_of_food_parcel
AFTER INSERT ON incoming_food_parcels
FOR EACH ROW
BEGIN
    CALL SP_update_food_parcels_stock_levels_AFTER_receiving_ANY_type_of_food_parcels(NEW.food_parcel_id, NEW.amount_of_food_parcels_received);
END $$

DELIMITER ;



-- ==============================================================================================================================
-- Stored procedure and trigger for updating laptop stock levels after ISSUING new laptops while ensuring rollback capabilities and dynamic row locking:


DELIMITER $$

CREATE PROCEDURE SP_update_laptop_computers_stock_levels_AFTER_ISSUING_ANY_laptop (
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
    
END $$

DELIMITER ;

-- ==============================================================================================================================
-- Trigger to Call the ABOVE Stored Procedure
DELIMITER $$
CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_ISSUING_ANY_laptop
AFTER INSERT ON members_issued_laptop_computers
FOR EACH ROW
BEGIN
    CALL SP_update_laptop_computers_stock_levels_AFTER_ISSUING_ANY_laptop(NEW.laptop_computer_id, NEW.amount_issued);
END $$
DELIMITER;


-- ==============================================================================================================================
-- Stored procedure and trigger for updating laptop stock levels after RECEIVING new laptops while ensuring rollback capabilities and dynamic row locking:
DELIMITER $$

CREATE PROCEDURE SP_update_laptop_computers_stock_levels_AFTER_RECEIVING_more_laptops (
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
    
END $$

DELIMITER ;

-- ==============================================================================================================================
-- Trigger to Call the ABOVE Stored Procedure

DELIMITER $$

CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_RECEIVING_ANY_laptop
AFTER INSERT ON incoming_laptop_computers
FOR EACH ROW
BEGIN
    CALL SP_update_laptop_computers_stock_levels_AFTER_RECEIVING_more_laptops(NEW.laptop_computer_id, NEW.amount_of_laptops_received);
END $$

DELIMITER ;


-- ==============================================================================================================================
-- a TRIGGER which AUTOMATICALLY updates the ANY TYPE OF FOOD PARCELS STOCK LEVELS after issuing A FOOD PARCEL 
-- THIS TRIGGER UPDATES ALL TYPES OF FOOD PARCELS, REMOVING THE NEED FOR DIFFERENT TRIGGERS OR HARDCODING THE FOOD PARCEL CODE
-- 
-- ==============================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_ANY_type_of_food_parcel;

DELIMITER $$

CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_ANY_type_of_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
    -- Declare variables FIRST
    DECLARE v_food_parcel_id VARCHAR(20);
   
    -- Declare error handlers for rollback
    DECLARE EXIT HANDLER FOR SQLSTATE '40001'
    BEGIN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Deadlock detected: Transaction rolled back. Try again later.';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'An unexpected error occurred. Transaction rolled back.';
    END; 
    
	-- Set timeout to avoid long waits for locks
    SET innodb_lock_wait_timeout = 5; 

    -- Lock the correct row before updating  
    SELECT food_parcel_id INTO v_food_parcel_id 
    FROM food_parcels_for_issue 
    WHERE food_parcel_id = NEW.food_parcel_id
    FOR UPDATE;
     
    -- Ensure we're updating the correct parcel
    IF NEW.food_parcel_id = v_food_parcel_id THEN
        UPDATE food_parcels_for_issue
        SET total_food_parcels_issued = total_food_parcels_issued + NEW.amount_issued,
            total_food_parcels_remaining = total_food_parcels_remaining - NEW.amount_issued
        WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;




-- ==============================================================================================================================
-- a TRIGGER which AUTOMATICALLY updates the NORMAL DIET FOOD (FP01) PARCELS STOCK LEVELS after issuing A NORMAL DIET FOOD PARCEL 
-- ==============================================================================================================================


-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel
-- AFTER INSERT ON members_issued_food_parcels
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Set timeout to avoid long waits for locks. Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5; 

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP01'
--     FOR UPDATE;
--      
--     -- Perform the update   
-- 	IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
-- 			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;
--     
-- END $$

-- DELIMITER ;
--     
-- -- ==============================================================================================================================
-- -- A TRIGGER which AUTOMATICALLY updates the HALAL FOOD (FP02) PARCELS STOCK LEVELS after issuing A HALAL FOOD PARCEL 
-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel
-- AFTER INSERT ON members_issued_food_parcels
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5; 
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP02'
--     FOR UPDATE;
--     
--     -- Perform the update
-- 	IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
-- 			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;

--     -- Commit the transaction to finalize changes
--     COMMIT;    
--     
-- END $$

-- DELIMITER ;
--     
--     
-- -- ===============================================================================================================================

-- -- a TRIGGER which AUTOMATICALLY updates the NORMAL DIABETIC FOOD (FP03) PARCELS STOCK LEVELS after issuing
-- -- A NORMAL DIABETIC FOOD PARCEL  

-- -- ===============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food
-- AFTER INSERT ON members_issued_food_parcels
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP03'
--     FOR UPDATE;
--     
-- 	IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued), 
-- 			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;

--     -- Commit the transaction to finalize changes
--     COMMIT;
--     
-- END $$

-- DELIMITER ;
--     

-- -- ===============================================================================================================================
-- -- a TRIGGER which AUTOMATICALLY updates the VEGAN FOOD (FP04) PARCELS STOCK LEVELS after issuing A VEGAN FOOD PARCEL 
-- -- ===============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel
-- AFTER INSERT ON members_issued_food_parcels
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP04'
--     FOR UPDATE;    
--     
--     IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
-- 			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;
--     
--     -- Commit the transaction to finalize changes
--     COMMIT;    
--     
-- END $$

-- DELIMITER ;

-- -- =============================================================================================================================

-- -- a TRIGGER which AUTOMATICALLY updates the VEGETARIAN FOOD (FP05) PARCELS STOCK LEVELS after issuing A
-- VEGETARIAN FOOD PARCEL 

-- -- =============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel
-- AFTER INSERT ON members_issued_food_parcels
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP05'
--     FOR UPDATE;    
--     
--     IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
-- 			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;
--     
--     -- Commit the transaction to finalize changes
--     COMMIT;
--     
-- END $$

-- DELIMITER ;



-- -- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY
-- 						**** TRIGGERS AFTER INCOMING FOOD PARCELS  ****************
-- -- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY

-- - a TRIGGER which AUTOMATICALLY updates the NORMAL DIET (FP01) FOOD PARCELS STOCK LEVELS
-- AFTER RECEIVING MORE NORMAL DIET FOOD PARCELS

-- -- =======================================================================================================================

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods
AFTER INSERT ON incoming_food_parcels
FOR EACH ROW
BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     
    
    -- Start transaction
    START TRANSACTION;

    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP01'
    FOR UPDATE;    
    
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
    -- Commit the transaction to finalize changes
    COMMIT;    
    
END $$

DELIMITER ;


-- -- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY

-- - Create a TRIGGER which AUTOMATICALLY updates the HALAL (FP02) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE HALAL FOODS

-- -- =======================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods
-- AFTER INSERT ON incoming_food_parcels

-- FOR EACH ROW

-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP02'
--     FOR UPDATE;    
-- 	
--     IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;

--     -- Commit the transaction to finalize changes
--     COMMIT;
--     
-- END $$

-- DELIMITER ;


-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the NORMAL DIABETIC (FP03) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE NORMAL DIABETIC FOODS
-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food
-- AFTER INSERT ON incoming_food_parcels

-- FOR EACH ROW

-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP03'
--     FOR UPDATE;    
-- 	
--     IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;
--  
--      -- Commit the transaction to finalize changes
--     COMMIT;
--     
-- END $$

-- DELIMITER ;


-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the VEGAN (FP04) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE VEGAN FOODS
-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods
-- AFTER INSERT ON incoming_food_parcels

-- FOR EACH ROW

-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP04'
--     FOR UPDATE;    
-- 	
--     IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;
--     
--     -- Commit the transaction to finalize changes
--     COMMIT;
--     
-- END $$

-- DELIMITER ;

--     
-- SELECT * FROM beths_new_food_pantry.incoming_food_parcels;
-- SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;



-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the HALAL (FP05) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE VEGETARIAN FOODS
-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods

-- DELIMITER $$
-- CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods
-- AFTER INSERT ON incoming_food_parcels

-- FOR EACH ROW

-- BEGIN
-- 	DECLARE v_food_parcel_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT food_parcel_id
--     INTO v_food_parcel_id
--     FROM food_parcels_for_issue
--     WHERE food_parcel_id = 'FP05'
--     FOR UPDATE;    
-- 	
--     IF NEW.food_parcel_id = v_food_parcel_id THEN
-- 		UPDATE food_parcels_for_issue
-- 		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
-- 		WHERE food_parcel_id = v_food_parcel_id; 
--     END IF;

--     -- Commit the transaction to finalize changes
--     COMMIT;    
--     
-- END $$

-- DELIMITER ;



-- -- ==============================================================================================================================
-- 					*********************************	TRIGGERS FOR LAPTOPS ********************************
-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_laptop_computer_stock_AFTER_receiving_ANY_type_of_laptop;

-- DELIMITER $$

-- CREATE TRIGGER TR_update_laptop_computer_stock_AFTER_receiving_ANY_type_of_laptop
-- AFTER INSERT ON incoming_laptop_computers
-- FOR EACH ROW
-- BEGIN
--     -- Declare variables FIRST
--     DECLARE v_laptop_computer_id VARCHAR(20);
--    
--     -- Declare error handlers for deadlocks and unexpected failures
--     DECLARE EXIT HANDLER FOR SQLSTATE '40001'
--     BEGIN
--         SIGNAL SQLSTATE '45000' 
--         SET MESSAGE_TEXT = 'Deadlock detected: Transaction rolled back. Try again later.';
--     END;

--     DECLARE EXIT HANDLER FOR SQLEXCEPTION
--     BEGIN
--         SIGNAL SQLSTATE '45000' 
--         SET MESSAGE_TEXT = 'An unexpected error occurred. Transaction rolled back.';
--     END;

--     -- Set timeout to avoid long waits for locks
--     SET innodb_lock_wait_timeout = 5; 

--     -- Lock the correct row before updating  
--     SELECT laptop_computer_id INTO v_laptop_computer_id 
--     FROM laptop_computers_for_issue 
--     WHERE laptop_computer_id = NEW.laptop_computer_id
--     FOR UPDATE;

--     -- Ensure we're updating the correct laptop
--     IF NEW.laptop_computer_id = v_laptop_computer_id THEN
--         UPDATE laptop_computers_for_issue
--         SET total_laptops_remaining = total_laptops_remaining + NEW.amount_of_laptops_received
--         WHERE laptop_computer_id = v_laptop_computer_id; 
--     END IF;
--     
-- END $$

-- DELIMITER ;

-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_levels_AFTER_issuing_ANY_type_of_laptop;

-- DELIMITER $$

-- CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_issuing_ANY_type_of
-- AFTER INSERT ON members_issued_laptop_computers
-- FOR EACH ROW
-- BEGIN
--     -- Declare variables FIRST
--     DECLARE v_laptop_computer_id VARCHAR(20);
--     
--     -- Declare error handlers for deadlocks and unexpected failures
--     DECLARE EXIT HANDLER FOR SQLSTATE '40001'
--     BEGIN
--         SIGNAL SQLSTATE '45000' 
--         SET MESSAGE_TEXT = 'Deadlock detected: Transaction rolled back. Try again later.';
--     END;

--     DECLARE EXIT HANDLER FOR SQLEXCEPTION
--     BEGIN
--         SIGNAL SQLSTATE '45000' 
--         SET MESSAGE_TEXT = 'An unexpected error occurred. Transaction rolled back.';
--     END;

--     -- Set timeout to avoid long waits for locks
--     SET innodb_lock_wait_timeout = 5; 

--     -- Lock the correct row before updating  
--     SELECT laptop_computer_id INTO v_laptop_computer_id 
--     FROM laptop_computers_for_issue 
--     WHERE laptop_computer_id = NEW.laptop_computer_id
--     FOR UPDATE;

--     -- Ensure we're updating the correct laptop
--     IF NEW.laptop_computer_id = v_laptop_computer_id THEN
--         UPDATE laptop_computers_for_issue
--         SET total_laptops_issued = total_laptops_issued + NEW.amount_issued,
--             total_laptops_remaining = total_laptops_remaining - NEW.amount_issued
--         WHERE laptop_computer_id = v_laptop_computer_id; 
--     END IF;
--     
-- END $$

-- DELIMITER ;



-- ==============================================================================================================================


- Create a TRIGGER which AUTOMATICALLY updates the LAPTOP COMPUTERS STOCK LEVELS AFTER RECEIVING MORE LAPTOPS

DROP TRIGGER IF EXISTS TR_update_laptop_computer_stock_AFTER_receiving_more_laptops

DELIMITER $$
CREATE TRIGGER TR_update_laptop_computer_stock_AFTER_receiving_more_laptops
AFTER INSERT ON incoming_laptop_computers
FOR EACH ROW
BEGIN
	DECLARE v_laptop_computer_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     
    
    -- Lock the specific row for update    
    SELECT laptop_computer_id
    INTO v_laptop_computer_id
    FROM laptop_computers_for_issue
    WHERE laptop_computer_id = 'COMP01'
    FOR UPDATE;
    
	IF NEW.laptop_computer_id = v_laptop_computer_id THEN
		UPDATE laptop_computers_for_issue
		SET total_laptops_remaining = total_laptops_remaining + new.amount_of_laptops_received   
		WHERE laptop_computer_id = v_laptop_computer_id; 
	END IF;
       
END $$

DELIMITER ;

-- SELECT * FROM beths_new_food_pantry.incoming_laptop_computers;
-- SELECT * FROM beths_new_food_pantry.laptop_computers_for_issue;
-- -- ================================================================================================================================


-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the LAPTOP COMPUTERS STOCK LEVELS AFTER ISSUING A LAPTOP TO A MEMBER
-- -- ==============================================================================================================================

-- DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop

-- DELIMITER $$
-- CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop
-- AFTER INSERT ON members_issued_laptop_computers
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE v_laptop_computer_id VARCHAR (20);
--     
--     -- Wait for max 5 seconds before aborting
--     SET innodb_lock_wait_timeout = 5;     
--     
--     -- Start transaction
--     START TRANSACTION;

--     -- Lock the specific row for update    
--     SELECT laptop_computer_id
--     INTO v_laptop_computer_id
--     FROM laptop_computers_for_issue
--     WHERE laptop_computer_id = 'COMP01'
--     FOR UPDATE;    
--  
-- 	IF NEW.laptop_computer_id = v_laptop_computer_id THEN
-- 		UPDATE laptop_computers_for_issue
-- 		SET total_laptops_issued = total_laptops_issued + NEW.amount_issued   
-- 		WHERE laptop_computer_id = v_laptop_computer_id;
--     END IF;

-- 	IF NEW.laptop_computer_id = v_laptop_computer_id THEN
-- 		UPDATE laptop_computers_for_issue
-- 		SET total_laptops_remaining = total_laptops_remaining - NEW.amount_issued   
-- 		WHERE laptop_computer_id =  v_laptop_computer_id;
--     END IF;

--     -- Commit the transaction to finalize changes
--     COMMIT;
--     
-- END $$

-- DELIMITER ;

-- SELECT * FROM beths_new_food_pantry.members_issued_laptop_computers;
-- SELECT * FROM beths_new_food_pantry.laptop_computers_for_issue;


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



-- UPDATED STORED PROCEDURE TO ISSUE A FOOD PARCEL - WITH A CHECK FOR WHEN DATE AND AMOUNT ISSUED ARE NULL - ADDED 09/3/2025

DROP PROCEDURE IF EXISTS Sproc_issue_a_FOOD_parcel_IF_one_is_due;

DELIMITER $$
CREATE PROCEDURE Sproc_issue_a_FOOD_parcel_IF_one_is_due
    (IN member_id VARCHAR(10), IN food_parcel_id VARCHAR(20),
     IN collection_point_id VARCHAR(10), IN date_last_issued DATE, IN amount_issued INT)

BEGIN
-- Declare local variables
    DECLARE v_amount_issued INT;
    DECLARE v_date_last_issued DATE;
    
    -- Assign default value if amount_issued is NULL
    SET v_amount_issued = IFNULL(amount_issued, 1);
    
    -- Assign default value if date_last_issued is NULL
    SET v_date_last_issued = IFNULL(date_last_issued, CURDATE());

    -- Insert into the table
    INSERT INTO members_issued_food_parcels
    (member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
    VALUES
    (member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued);
END $$
DELIMITER ;


-- UPDATED STORED PROCEDURE TO ISSUE A FOOD PARCEL - WITH A CHECK FOR WHEN DATE AND AMOUNT ISSUED ARE NULL - ADDED 06/6/2025

DELIMITER $$

CREATE PROCEDURE Sproc_issue_a_FOOD_parcel_IF_one_is_due
    (IN member_id VARCHAR(10), IN food_parcel_id VARCHAR(20),
     IN collection_point_id VARCHAR(10), IN date_last_issued DATE, IN amount_issued INT)

BEGIN
    -- Declare local variables
    DECLARE v_amount_issued INT;
    DECLARE v_date_last_issued DATE;
    DECLARE v_available_stock INT;

    -- Error Handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'An error occurred while issuing a food parcel. Transaction rolled back.';
    END;

    -- Start transaction
    START TRANSACTION;

    -- Assign default values if NULL
    SET v_amount_issued = IFNULL(amount_issued, 1);
    SET v_date_last_issued = IFNULL(date_last_issued, CURDATE());

    -- Check stock availability
    SELECT total_food_parcels_remaining INTO v_available_stock
    FROM food_parcels_for_issue
    WHERE food_parcel_id = NEW.food_parcel_id
    FOR UPDATE;

    -- Abort if stock is insufficient
    IF v_available_stock < v_amount_issued THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient stock. Unable to issue the requested food parcel.';
        ROLLBACK;
    ELSE
        -- Proceed with issuing the food parcel
        INSERT INTO members_issued_food_parcels
        (member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
        VALUES
        (member_id, food_parcel_id, collection_point_id, v_date_last_issued, v_amount_issued);

        -- Commit transaction if everything is successful
        COMMIT;
    END IF;
    
END $$

DELIMITER ;



  
    
-- OLD STORED PROCEDURE TO ISSUE A FOOD PARCEL - WITH NO CHECKS FOR WHEN DATE AND AMOUNT ISSUED ARE NULL

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

    

