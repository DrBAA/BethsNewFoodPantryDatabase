USE beths_new_food_pantry;


-- ====================================================================================================== --
-- This stored procedure generates a new unique member_id by locking and reading 
-- the highest existing member_id, then incrementing it safely under concurrency.

-- It attempts the insert up to three times, using a retry loop to handle deadlocks 
-- and ensuring the operation is resilient in high‑traffic environments.

-- It inserts a new member record into members_personal_details_testing using the 
-- provided personal details and the supplied address_id, all within a controlled 
-- transaction block.

-- It returns the newly created member_id along with all submitted member fields, 
-- plus an SQLSTATE code indicating success, duplicate‑key violation, or a generic error.

-- The stored procedure guarantees atomicity because the entire member‑creation
-- process is wrapped inside a single transaction using START TRANSACTION and COMMIT.
-- All operations inside the transaction either fully succeed and commit together,
-- or fully fail and roll back together, ensuring no partial or inconsistent updates.
-- Error handlers for duplicate keys, deadlocks, and generic SQL exceptions all call
-- ROLLBACK, which prevents any partial insert and preserves database consistency.


DROP PROCEDURE IF EXISTS SP_create_member

DELIMITER $$

CREATE PROCEDURE SP_create_member(
    IN p_first_name VARCHAR(20),
    IN p_last_name VARCHAR(20),
    IN p_age_range VARCHAR(20),
    IN p_dependants_under_18  int,
    IN p_main_contact_number VARCHAR(20),
    IN p_email_address VARCHAR(50),
    IN p_address_id VARCHAR(10),

    OUT o_member_id VARCHAR(10),
    OUT o_first_name VARCHAR(20),
    OUT o_last_name VARCHAR(20),
    OUT o_age_range VARCHAR(20),
    OUT o_dependants_under_18 INT,
    OUT o_main_contact_number VARCHAR(20),
    OUT o_email_address VARCHAR(50),
    OUT o_address_id VARCHAR(10),
    OUT o_sqlstate VARCHAR(10)
)
BEGIN
    DECLARE v_next_id VARCHAR(10);
    DECLARE v_max_num INT DEFAULT NULL;
    DECLARE v_attempts INT DEFAULT 0;
    DECLARE v_done INT DEFAULT 0;

    -- NEW: Set lock wait timeout to 5 seconds
    SET innodb_lock_wait_timeout = 5;

    -- NEW: Retry loop (max 3 attempts)
    WHILE v_done = 0 AND v_attempts < 3 DO
        SET v_attempts = v_attempts + 1;

        BEGIN        
			-- NEW: Duplicate key handler (SQLSTATE 23000)
			DECLARE EXIT HANDLER FOR SQLSTATE '23000'
			BEGIN
				ROLLBACK;
                
				-- Return attempted member details so Java can detect MEMBER EXISTS
				SET o_member_id = NULL;
				SET o_first_name = p_first_name;
				SET o_last_name = p_last_name;
				SET o_age_range = p_age_range;
				SET o_dependants_under_18 = p_dependants_under_18;
				SET o_main_contact_number = p_main_contact_number;
				SET o_email_address = p_email_address;
				SET o_address_id = p_address_id;

				SET o_sqlstate = '23000'; -- duplicate key
				SET v_done = 1;  -- Stop retrying
			END;

			-- Deadlock handler (SQLSTATE 40001)
-- 			DECLARE EXIT HANDLER FOR SQLSTATE '40001'
-- 			BEGIN
-- 				ROLLBACK;
-- 				-- Retry by continuing the loop
-- 			END;

-- 			-- Generic error handler
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				ROLLBACK;
				
				SET o_member_id = NULL;
				SET o_first_name = NULL;
				SET o_last_name = NULL;
				SET o_age_range = NULL;
				SET o_dependants_under_18 = NULL;
				SET o_main_contact_number = NULL;
				SET o_email_address = NULL;
				SET o_address_id = NULL;

				SET o_sqlstate = 'HY000'; -- other SQL error
				SET v_done = 1; -- Stop retrying
			END;
            
			START TRANSACTION;

			-- Row-level lock on the highest ID row (safe under concurrency)
			SELECT CAST(SUBSTRING(member_id, 2) AS UNSIGNED)
			INTO v_max_num
			FROM members_personal_details 
			ORDER BY CAST(SUBSTRING(member_id, 2) AS UNSIGNED) DESC
			LIMIT 1
			FOR UPDATE;

			-- Generate next ID using prefix M
			IF v_max_num IS NULL THEN
				SET v_next_id = 'M1';
			ELSE
				SET v_next_id = CONCAT('M', v_max_num + 1);
			END IF;

			-- Create new member
			INSERT INTO members_personal_details (
				member_id,
				first_name,
				last_name,
				age_range,
				dependants_under_18,
				main_contact_number,
				email_address,
				address_id
			)
			VALUES (
				v_next_id,
				p_first_name,
				p_last_name,
				p_age_range,
				p_dependants_under_18,
				p_main_contact_number,
				p_email_address,
				p_address_id
			);

			-- Return full inserted row
			SET o_member_id = v_next_id;
			SET o_first_name = p_first_name;
			SET o_last_name = p_last_name;
			SET o_age_range = p_age_range;
			SET o_dependants_under_18 = p_dependants_under_18;
			SET o_main_contact_number = p_main_contact_number;
			SET o_email_address = p_email_address;
			SET o_address_id = p_address_id;
            
			COMMIT;
			
			SET o_sqlstate = '00000'; -- success
			SET v_done = 1; -- Success, exit loop
		END;
	END WHILE;

    -- If all retries failed
    IF v_done = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'sp_create_member failed after 3 retry attempts.';
    END IF;
END$$
DELIMITER ;





-- ====================================================================================================== --

-- To call the SP

SET @address_id = '';
SET @house_number_or_name = '';
SET @street_name = '';
SET @city_or_town = '';
SET @post_code = '';
SET @country = '';
SET @sqlstate = '';

CALL SP_create_address(
    '50',               -- p_house_number_or_name (IN)
    'drubbery road',      -- p_street_name (IN)
    'birmingham',       -- p_city_or_town (IN)
    'b17 9ds',          -- p_post_code (IN)
    'UK',               -- p_country (IN)

    @address_id,        -- o_address_id (OUT)
    @house_number_or_name, -- o_house_number_or_name (OUT)
    @street_name,       -- o_street_name (OUT)
    @city_or_town,      -- o_city_or_town (OUT)
    @post_code,         -- o_post_code (OUT)
    @country,           -- o_country (OUT)
    @sqlstate           -- o_sqlstate (OUT)
);

SELECT 
    @address_id,
    @house_number_or_name,
    @street_name,
    @city_or_town,
    @post_code,
    @country,
    @sqlstate;


/* RaceSafe Stored Procedure: SP_create_address - CREATED 02/8/2026
This procedure safely creates a new address inside MySQL using atomic transactions,
row‑level locking, timeout protection, deadlock handling, duplicate‑key detection,
explicit SQLSTATE signalling, and controlled retry logic.

The database locks the row containing the highest existing address_id.
It reads the current maximum ID, calculates the next sequential ID using prefix A,
and attempts to insert the new address.

If the address already exists, the UNIQUE constraint triggers SQLSTATE 23000 and the
duplicate handler returns the attempted address fields and sets o_sqlstate = '23000'
so the application can report “ADDRESS EXISTS”.

If a deadlock occurs (SQLSTATE 40001), the procedure rolls back and retries up to
three times. Deadlocks are never exposed to the caller unless all retries fail.

If any other SQL error occurs, the generic handler rolls back, clears all OUT
parameters, sets o_sqlstate = 'HY000', and stops execution cleanly.

On success, the transaction commits, returns the full inserted address, and sets
o_sqlstate = '00000'.

If all retry attempts fail, the procedure raises SQLSTATE 45000 to explicitly signal
retry exhaustion to the caller.

All critical operations happen inside MySQL, not in Java, ensuring correctness,
consistency, and safety under high concurrency.
*/


DROP PROCEDURE IF EXISTS SP_create_address

DELIMITER $$

CREATE PROCEDURE SP_create_address(
    IN p_house_number_or_name VARCHAR(255),
    IN p_street_name  VARCHAR(255),
    IN p_city_or_town VARCHAR(255),
    IN p_post_code    VARCHAR(255),
    IN p_country      VARCHAR(255),
    
    OUT o_address_id  VARCHAR(10),
    OUT o_house_number_or_name VARCHAR(15),
    OUT o_street_name  VARCHAR(50),
    OUT o_city_or_town VARCHAR(50),
    OUT o_post_code    VARCHAR(10),
    OUT o_country      VARCHAR(2),
    OUT o_sqlstate VARCHAR(20) -- returns SQLSTATE/ MySql error codes
)
BEGIN
	-- Declare variables
    DECLARE v_next_id VARCHAR(10);
    DECLARE v_max_num INT DEFAULT NULL;
    DECLARE v_attempts INT DEFAULT 0;
    DECLARE v_done INT DEFAULT 0;

    -- NEW: Set lock wait timeout to 5 seconds
    SET innodb_lock_wait_timeout = 5;

    -- NEW: Retry loop (max 3 attempts)
    WHILE v_done = 0 AND v_attempts < 3 DO
        SET v_attempts = v_attempts + 1;

        BEGIN        
			-- NEW: Duplicate key handler (MySQL error 1062)
            DECLARE EXIT HANDLER FOR 1062
			BEGIN
				ROLLBACK;

				-- Fetch the existing address_id based on the unique constraint
				SELECT address_id
				INTO o_address_id
				FROM members_address
				WHERE house_number_or_name = p_house_number_or_name
				  AND post_code = p_post_code
				LIMIT 1;

				-- Return the input values (they match the existing row)
				SET o_house_number_or_name = p_house_number_or_name;
				SET o_street_name = p_street_name;
				SET o_city_or_town = p_city_or_town;
				SET o_post_code = p_post_code;
				SET o_country = p_country;

				SET o_sqlstate = '1062'; -- duplicate address
				SET v_done = 1;
			END;
        
			-- Handle NOT NULL constraint violation (1048)
			DECLARE EXIT HANDLER FOR 1048
			BEGIN
				ROLLBACK;
				SET o_sqlstate = '1048';   -- NOT NULL violation
				SET v_done = 1;            -- stop retrying
			END;
        
			-- Handler for 1406 (Data too long)
			DECLARE EXIT HANDLER FOR 1406
			BEGIN
				ROLLBACK;
				SET o_sqlstate = '1406';   -- data too long
				SET v_done = 1;            -- stop retrying
			END;
            
            -- CHECK constraint violation
			DECLARE EXIT HANDLER FOR 3819
            handler_3819: BEGIN
				ROLLBACK;
                
				-- Count how many validation rules fail
				SET @error_count = 0;

				IF p_house_number_or_name IS NULL OR p_house_number_or_name = '' THEN
					SET @error_count = @error_count + 1;
				END IF;

				IF p_street_name IS NULL OR p_street_name = '' THEN
					SET @error_count = @error_count + 1;
				END IF;

				IF p_city_or_town IS NULL OR p_city_or_town = '' THEN
					SET @error_count = @error_count + 1;
				END IF;

				IF p_post_code IS NULL OR p_post_code = '' THEN
					SET @error_count = @error_count + 1;
				END IF;

				IF p_country IS NULL OR p_country = '' THEN
					SET @error_count = @error_count + 1;
				END IF;

				-- If more than one validation fails, return combined error
				IF @error_count > 1 THEN
					SET o_sqlstate = 'MULTI';
					SET v_done = 1;
                    LEAVE handler_3819;   -- ⭐ THIS STOPS THE SINGLE-FIELD CHECKS ⭐
				END IF;                

				-- Single-field checks
				IF p_house_number_or_name IS NULL OR p_house_number_or_name = '' THEN
					SET o_sqlstate = 'HOUSE_EMPTY';

				ELSEIF p_street_name IS NULL OR p_street_name = '' THEN
					SET o_sqlstate = 'STREET_EMPTY';

				ELSEIF p_city_or_town IS NULL OR p_city_or_town = '' THEN
					SET o_sqlstate = 'CITY_EMPTY';

				ELSEIF p_post_code IS NULL OR p_post_code = '' THEN
					SET o_sqlstate = 'POSTCODE_EMPTY';

				ELSEIF p_country IS NULL OR p_country = '' THEN
					SET o_sqlstate = 'COUNTRY_EMPTY';

				ELSEIF p_country <> 'UK' THEN
					SET o_sqlstate = 'COUNTRY_INVALID';

				ELSE
					SET o_sqlstate = '3819';
				END IF;

				SET v_done = 1;
			END;
       
            -- Deadlock handler (SQLSTATE 40001)
            DECLARE EXIT HANDLER FOR SQLSTATE '40001'
            BEGIN
                ROLLBACK;
                -- Retry by continuing the loop
            END;

            -- Generic error handler
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                SET o_address_id = NULL;
                SET o_house_number_or_name = NULL;
                SET o_street_name = NULL;
                SET o_city_or_town = NULL;
                SET o_post_code = NULL;
                SET o_country = NULL;
                SET o_sqlstate = 'HY000'; -- other SQL error
                SET v_done = 1; -- Stop retrying
            END;

            START TRANSACTION;

            -- Row-level lock on the highest ID row (safe under concurrency)
            SELECT CAST(SUBSTRING(address_id, 2) AS UNSIGNED)
            INTO v_max_num
            FROM members_address
            ORDER BY CAST(SUBSTRING(address_id, 2) AS UNSIGNED) DESC
            LIMIT 1
            FOR UPDATE;

            -- Generate next ID using prefix A
            IF v_max_num IS NULL THEN
                SET v_next_id = 'A0';
            ELSE
                SET v_next_id = CONCAT('A', v_max_num + 1);
            END IF;

            -- Insert new address
            INSERT INTO members_address (
                address_id,
                house_number_or_name,
                street_name,
                city_or_town,
                post_code,
                country
            )
            VALUES (
                v_next_id,
                p_house_number_or_name,
                p_street_name,
                p_city_or_town,
                p_post_code,
                p_country
            );

            -- Return full inserted row
            SET o_address_id   = v_next_id;
            SET o_house_number_or_name = p_house_number_or_name;
            SET o_street_name  = p_street_name;
            SET o_city_or_town = p_city_or_town;
            SET o_post_code    = p_post_code;
            SET o_country      = p_country;

            COMMIT;
            
            SET o_sqlstate = '00000'; -- success

            SET v_done = 1; -- Success, exit loop
        END;
    END WHILE;

    -- If all retries failed
    IF v_done = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'sp_create_address failed after 3 retry attempts.';
    END IF;

END$$

DELIMITER ;



-- ************* TRIGGERS AFTER ISSUING FOOD PARCELS - UPDATED 05/6/2025 TO REMOVE REDUNDANT CODE FOR CHECKING FOOD PARCELS TWCIE *******************


-- ==============================================================================================================================

-- Stored procedure and trigger for automatically updating food parcel stock levels after ISSUING ANY TYPE OF FOOD parcel

DROP PROCEDURE IF EXISTS SP_update_food_parcels_stock_AFTER_ISSUING_food_parcels;

DELIMITER $$

CREATE PROCEDURE SP_update_food_parcels_stock_AFTER_ISSUING_food_parcels(
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
    
END $$

DELIMITER ;
-- ==============================================================================================================================
-- Trigger to Call the ABOVE Stored Procedure
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_ISSUING_food_parcels;

DELIMITER $$

CREATE TRIGGER TR_update_food_parcels_stock_AFTER_ISSUING_food_parcels
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
    CALL SP_update_food_parcels_stock_AFTER_ISSUING_food_parcels(NEW.food_parcel_id, NEW.amount_issued);
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Stored procedure and trigger for automatically updating food parcel stock levels after receiving more parcels, ensuring rollback capabilities and dynamic row locking:

DROP PROCEDURE IF EXISTS SP_update_food_parcels_stock_AFTER_receiving_food_parcels;

DELIMITER $$

CREATE PROCEDURE SP_update_food_parcels_stock_AFTER_receiving_food_parcels (
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
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_RECEIVING_food_parcels;

DELIMITER $$

CREATE TRIGGER TR_update_food_parcels_stock_AFTER_RECEIVING_food_parcels
AFTER INSERT ON incoming_food_parcels
FOR EACH ROW
BEGIN
    CALL SP_update_food_parcels_stock_AFTER_receiving_food_parcels(NEW.food_parcel_id, NEW.amount_of_food_parcels_received);
END $$

DELIMITER ;

DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_RECEIVING_food_parcels;


-- ==============================================================================================================================
-- Stored procedure and trigger for updating laptop stock levels after ISSUING new laptops while ensuring rollback capabilities and dynamic row locking:
DROP PROCEDURE IF EXISTS SP_update_laptop_computers_stock_AFTER_ISSUING_laptops;

DELIMITER $$

CREATE PROCEDURE SP_update_laptop_computers_stock_AFTER_ISSUING_laptops (
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
DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_AFTER_ISSUING_laptops;

DELIMITER $$
CREATE TRIGGER TR_update_laptop_computers_stock_AFTER_ISSUING_laptops
AFTER INSERT ON members_issued_laptop_computers
FOR EACH ROW
BEGIN
    CALL SP_update_laptop_computers_stock_AFTER_ISSUING_laptops(NEW.laptop_computer_id, NEW.amount_issued);
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Stored procedure and trigger for updating laptop stock levels after RECEIVING new laptops while ensuring rollback capabilities and dynamic row locking:
DROP PROCEDURE IF EXISTS SP_update_laptop_computers_stock_AFTER_RECEIVING_laptops;

DELIMITER $$

CREATE PROCEDURE SP_update_laptop_computers_stock_AFTER_RECEIVING_laptops (
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
DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_AFTER_RECEIVING_laptops;

DELIMITER $$

CREATE TRIGGER TR_update_laptop_computers_stock_AFTER_RECEIVING_laptops
AFTER INSERT ON incoming_laptop_computers
FOR EACH ROW
BEGIN
    CALL SP_update_laptop_computers_stock_AFTER_RECEIVING_laptops(NEW.laptop_computer_id, NEW.amount_of_laptops_received);
END $$

DELIMITER ;


-- ==============================================================================================================================
-- a TRIGGER which AUTOMATICALLY updates the ANY TYPE OF FOOD PARCELS STOCK LEVELS after issuing A FOOD PARCEL 
-- THIS TRIGGER UPDATES ALL TYPES OF FOOD PARCELS, REMOVING THE NEED FOR DIFFERENT TRIGGERS OR HARDCODING THE FOOD PARCEL CODE
-- 
-- ==============================================================================================================================

/*
-- 01/10/2025 this trigger does not exist for now
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

*/


-- ==============================================================================================================================
-- a TRIGGER which AUTOMATICALLY updates the NORMAL DIET FOOD (FP01) PARCELS STOCK LEVELS after issuing A NORMAL DIET FOOD PARCEL 
-- ==============================================================================================================================

/*
 DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_NORMAL_diet_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Set timeout to avoid long waits for locks. Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5; 

    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP01'
    FOR UPDATE;
     
    -- Perform the update   
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;
*/     
-- -- ==============================================================================================================================
-- -- A TRIGGER which AUTOMATICALLY updates the HALAL FOOD (FP02) PARCELS STOCK LEVELS after issuing A HALAL FOOD PARCEL 
-- -- ==============================================================================================================================

/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_HALAL_diet_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5; 
    
    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP02'
    FOR UPDATE;
    
    -- Perform the update
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;  
    
END $$

DELIMITER ;
*/    
    
-- -- ===============================================================================================================================

-- -- a TRIGGER which AUTOMATICALLY updates the NORMAL DIABETIC FOOD (FP03) PARCELS STOCK LEVELS after issuing
-- -- A NORMAL DIABETIC FOOD PARCEL  

-- -- ===============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food

DELIMITER $$
CREATE TRIGGER TR_update_food_stock_AFTER_issue_NORMAL_DIABETIC_diet_food
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     
    
    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP03'
    FOR UPDATE;
    
	IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued), 
			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;
*/
-- -- ===============================================================================================================================
-- -- a TRIGGER which AUTOMATICALLY updates the VEGAN FOOD (FP04) PARCELS STOCK LEVELS after issuing A VEGAN FOOD PARCEL 
-- -- ===============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_VEGAN_food_parcel
AFTER INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     
    
    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP04'
    FOR UPDATE;    
    
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;
*/
-- -- =============================================================================================================================

-- -- a TRIGGER which AUTOMATICALLY updates the VEGETARIAN FOOD (FP05) PARCELS STOCK LEVELS after issuing A
-- VEGETARIAN FOOD PARCEL 

-- -- =============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_issue_VEGETARIAN_food_parcel
AFTER INSERT ON members_issued_food_parcels
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
    WHERE food_parcel_id = 'FP05'
    FOR UPDATE;    
    
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_issued = (total_food_parcels_issued + NEW.amount_issued),
			total_food_parcels_remaining = (total_food_parcels_remaining - NEW.amount_issued)
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
    -- Commit the transaction to finalize changes
    COMMIT;
    
END $$

DELIMITER ;
*/


-- -- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY
-- 						**** TRIGGERS AFTER INCOMING FOOD PARCELS  ****************
-- -- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY

-- - a TRIGGER which AUTOMATICALLY updates the NORMAL DIET (FP01) FOOD PARCELS STOCK LEVELS
-- AFTER RECEIVING MORE NORMAL DIET FOOD PARCELS

-- -- =======================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_NORMAL_DIET_foods
AFTER INSERT ON incoming_food_parcels
FOR EACH ROW
BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     

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
       
END $$

DELIMITER ;
*/

-- -- =======================================================================================================================  THIS ONE IS WORKING PERFECTLY

-- - Create a TRIGGER which AUTOMATICALLY updates the HALAL (FP02) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE HALAL FOODS

-- -- =======================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_HALAL_foods
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     

    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP02'
    FOR UPDATE;    
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;
*/


-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the NORMAL DIABETIC (FP03) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE NORMAL DIABETIC FOODS
-- -- ==============================================================================================================================

/*
DROP TRIGGER IF EXISTS TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food

DELIMITER $$
CREATE TRIGGER TR_update_food_stock_AFTER_receiving_NORMAL_DIABETIC_food
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     

    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP03'
    FOR UPDATE;    
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;
*/

-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the VEGAN (FP04) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE VEGAN FOODS
-- -- ==============================================================================================================================

/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_VEGAN_foods
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     

    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP04'
    FOR UPDATE;    
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF;
    
END $$

DELIMITER ;
*/
     
-- SELECT * FROM beths_new_food_pantry.incoming_food_parcels;
-- SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;



-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the HALAL (FP05) FOOD PARCELS STOCK LEVELS AFTER RECEIVING MORE VEGETARIAN FOODS
-- -- ==============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods

DELIMITER $$
CREATE TRIGGER TR_update_food_parcels_stock_AFTER_receiving_VEGETARIAN_foods
AFTER INSERT ON incoming_food_parcels

FOR EACH ROW

BEGIN
	DECLARE v_food_parcel_id VARCHAR (20);
    
    -- Wait for max 5 seconds before aborting
    SET innodb_lock_wait_timeout = 5;     

    -- Lock the specific row for update    
    SELECT food_parcel_id
    INTO v_food_parcel_id
    FROM food_parcels_for_issue
    WHERE food_parcel_id = 'FP05'
    FOR UPDATE;    
	
    IF NEW.food_parcel_id = v_food_parcel_id THEN
		UPDATE food_parcels_for_issue
		SET total_food_parcels_remaining = total_food_parcels_remaining + NEW.amount_of_food_parcels_received  
		WHERE food_parcel_id = v_food_parcel_id; 
    END IF; 
    
END $$

DELIMITER ;
*/


-- -- ==============================================================================================================================
-- 					*********************************	TRIGGERS FOR LAPTOPS ********************************
-- -- ==============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_laptop_computer_stock_AFTER_receiving_MORE_laptops;

DELIMITER $$

CREATE TRIGGER TR_update_laptop_computer_stock_AFTER_receiving_MORE_laptop
AFTER INSERT ON incoming_laptop_computers
FOR EACH ROW
BEGIN
    -- Declare variables FIRST
    DECLARE v_laptop_computer_id VARCHAR(20);
   
    -- Declare error handlers for deadlocks and unexpected failures
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
    SELECT laptop_computer_id INTO v_laptop_computer_id 
    FROM laptop_computers_for_issue 
    WHERE laptop_computer_id = NEW.laptop_computer_id
    FOR UPDATE;

    -- Ensure we're updating the correct laptop
    IF NEW.laptop_computer_id = v_laptop_computer_id THEN
        UPDATE laptop_computers_for_issue
        SET total_laptops_remaining = total_laptops_remaining + NEW.amount_of_laptops_received
        WHERE laptop_computer_id = v_laptop_computer_id; 
    END IF;
    
END $$

DELIMITER ;
*/
-- -- ==============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_levels_AFTER_issuing_ANY_laptop;

DELIMITER $$

CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_issuing_ANY_laptop
AFTER INSERT ON members_issued_laptop_computers
FOR EACH ROW
BEGIN
    -- Declare variables FIRST
    DECLARE v_laptop_computer_id VARCHAR(20);
    
    -- Declare error handlers for deadlocks and unexpected failures
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
    SELECT laptop_computer_id INTO v_laptop_computer_id 
    FROM laptop_computers_for_issue 
    WHERE laptop_computer_id = NEW.laptop_computer_id
    FOR UPDATE;

    -- Ensure we're updating the correct laptop
    IF NEW.laptop_computer_id = v_laptop_computer_id THEN
        UPDATE laptop_computers_for_issue
        SET total_laptops_issued = total_laptops_issued + NEW.amount_issued,
            total_laptops_remaining = total_laptops_remaining - NEW.amount_issued
        WHERE laptop_computer_id = v_laptop_computer_id; 
    END IF;
    
END $$

DELIMITER ;
*/


-- ==============================================================================================================================

/*
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
*/

-- SELECT * FROM beths_new_food_pantry.incoming_laptop_computers;
-- SELECT * FROM beths_new_food_pantry.laptop_computers_for_issue;
-- -- ================================================================================================================================


-- -- ==============================================================================================================================
-- - Create a TRIGGER which AUTOMATICALLY updates the LAPTOP COMPUTERS STOCK LEVELS AFTER ISSUING A LAPTOP TO A MEMBER
-- -- ==============================================================================================================================
/*
DROP TRIGGER IF EXISTS TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop

DELIMITER $$
CREATE TRIGGER TR_update_laptop_computers_stock_levels_AFTER_issuing_a_laptop
AFTER INSERT ON members_issued_laptop_computers
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
*/
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

-- ORIGINAL AND UPDATED STORED PROCEDURE TO ISSUE A FOOD PARCEL - WITH A CHECK FOR WHEN DATE AND AMOUNT ISSUED ARE NULL - ADDED 09/3/2025 - WORKING 
-- AMMENDED 17 8 2025 TO ENSURE MEMBER ID IS ADDED WITH A CAPITAL M.
-- DECLARE v_member_id_clean	Local variable to hold cleaned-up ID
-- SET v_member_id_clean = ...	Capitalizes m if needed
-- VALUES (v_member_id_clean, ...)	Uses cleaned ID in the insert


DROP PROCEDURE IF EXISTS Sproc_issue_a_FOOD_parcel_IF_one_is_due;

DELIMITER $$
CREATE PROCEDURE Sproc_issue_a_FOOD_parcel_IF_one_is_due
    (IN member_id VARCHAR(10), IN food_parcel_id VARCHAR(20),
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
END $$
DELIMITER ;


-- DROP PROCEDURE IF EXISTS Sproc_issue_a_FOOD_parcel_IF_one_is_due;

-- DELIMITER $$
-- CREATE PROCEDURE Sproc_issue_a_FOOD_parcel_IF_one_is_due
--     (IN member_id VARCHAR(10), IN food_parcel_id VARCHAR(20),
--      IN collection_point_id VARCHAR(10), IN date_last_issued DATE, IN amount_issued INT)

-- BEGIN
-- -- Declare local variables
--     DECLARE v_amount_issued INT;
--     DECLARE v_date_last_issued DATE;
--     
--     -- Assign default value if amount_issued is NULL
--     SET v_amount_issued = IFNULL(amount_issued, 1);
--     
--     -- Assign default value if date_last_issued is NULL
--     SET v_date_last_issued = IFNULL(date_last_issued, CURDATE());

--     -- Insert into the table
--     INSERT INTO members_issued_food_parcels
--     (member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
--     VALUES
--     (member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued);
-- END $$
-- DELIMITER ;


==========================================================================================================
-- TRIGGER TO CHECK FOOD PARCEL STOCK LEVELS BEFORE ISSUING A FOOD PARCEL - WORKING

DROP TRIGGER IF EXISTS TR_check_FOOD_PARCELS_stock_BEFORE_issue;

DELIMITER $$

CREATE TRIGGER TR_check_FOOD_PARCELS_stock_BEFORE_issue
BEFORE INSERT ON members_issued_food_parcels
FOR EACH ROW
BEGIN
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
END $$

DELIMITER ;

  
-- ==============================================================================================================================    
-- Stored Function - Converts a string so each space-separated word is in Title Case (John Smith)
-- Takes the input string (e.g. "john smith").
-- Finds the next space to isolate one word at a time.
-- For each word:
-- Makes the first letter uppercase.
-- Makes the rest of the letters lowercase.
-- Adds the cleaned word to the output.
-- Adds a space between words while there’s still more text to process.
-- When there’s no text left, returns the rebuilt string.
-- So:
-- "john smith" → John Smith
-- "mArY aNNe joNES" → Mary Anne Jones

DELIMITER $$

CREATE FUNCTION to_title_case(str VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE output VARCHAR(255) DEFAULT '';
    DECLARE space_pos INT;
    DECLARE word VARCHAR(255);

    WHILE str IS NOT NULL AND str <> '' DO
        SET space_pos = INSTR(str, ' ');

        IF space_pos = 0 THEN
            SET word = str;
            SET str = '';
        ELSE
            SET word = SUBSTRING(str, 1, space_pos - 1);
            SET str = SUBSTRING(str, space_pos + 1);
        END IF;

        SET output = CONCAT(
            output,
            UPPER(LEFT(word, 1)),
            LOWER(SUBSTRING(word, 2))
        );

        IF str <> '' THEN
            SET output = CONCAT(output, ' ');
        END IF;
    END WHILE;

    RETURN output;
END $$

DELIMITER ;

-- ==============================================================================================================================    
-- Trigger  -  Automatically converts first_name and last_name to Title Case before inserting a new row
DELIMITER $$

CREATE TRIGGER members_name_titlecase
BEFORE INSERT ON members_personal_details
FOR EACH ROW
BEGIN
    SET NEW.first_name = to_title_case(NEW.first_name);
    SET NEW.last_name  = to_title_case(NEW.last_name);
END $$

DELIMITER ;

-- ==============================================================================================================================    
-- Automatically converts first_name and last_name to Title Case before updating a row
DELIMITER $$

CREATE TRIGGER members_name_titlecase_update
BEFORE UPDATE ON members_personal_details
FOR EACH ROW
BEGIN
    SET NEW.first_name = to_title_case(NEW.first_name);
    SET NEW.last_name  = to_title_case(NEW.last_name);
END $$

DELIMITER ;


-- ==============================================================================================================================    
-- Trigger - Automatically converts street_name and city_or_town to Title Case before inserting a new row
DELIMITER $$

CREATE TRIGGER members_address_titlecase
BEFORE INSERT ON members_address
FOR EACH ROW
BEGIN
    SET NEW.street_name   = to_title_case(NEW.street_name);
    SET NEW.city_or_town  = to_title_case(NEW.city_or_town);
END $$

DELIMITER ;


-- ==============================================================================================================================    
-- Trigger - Automatically converts street_name and city_or_town to Title Case before updating a row
DELIMITER $$

CREATE TRIGGER members_address_titlecase_update
BEFORE UPDATE ON members_address
FOR EACH ROW
BEGIN
    SET NEW.street_name   = to_title_case(NEW.street_name);
    SET NEW.city_or_town  = to_title_case(NEW.city_or_town);
END $$

DELIMITER ;


-- ==============================================================================================================================    
/* 
    Trigger: trg_uppercase_postcode
    Purpose: Ensures ALL newly inserted postcodes are stored in uppercase,
             regardless of what the user enters in the UI.
             This guarantees consistent postcode formatting in the database.
*/

DELIMITER $$
CREATE TRIGGER trigger_uppercase_postcode_before_insert
BEFORE INSERT ON members_address
FOR EACH ROW
BEGIN
    SET NEW.post_code = UPPER(NEW.post_code);
END $$

DELIMITER ;

-- ==============================================================================================================================
/* 
    Trigger: trg_uppercase_postcode_update
    Purpose: Ensures ALL updated postcodes are stored in uppercase.
             If a user edits a member and enters a lowercase postcode,
             the database automatically converts it to uppercase before saving.
*/
DELIMITER $$

CREATE TRIGGER trigger_uppercase_postcode_before_update
BEFORE UPDATE ON members_address
FOR EACH ROW
BEGIN
    SET NEW.post_code = UPPER(NEW.post_code);
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Trigger: Automatically lowercases the email_address field before inserting a new row.
-- Purpose: Ensures all stored email addresses use consistent lowercase formatting.
-- Example: Input 'RAMAH@EMAIL.COM' will be saved as 'ramah@email.com'.

DELIMITER $$

CREATE TRIGGER members_email_lowercase
BEFORE INSERT ON members_personal_details
FOR EACH ROW
BEGIN
    IF NEW.email_address IS NOT NULL THEN
        SET NEW.email_address = LOWER(NEW.email_address);
    END IF;
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Trigger: Automatically lowercases the email_address field before updating a row.
-- Purpose: Ensures all stored email addresses remain consistently formatted in lowercase,
--          even when a user edits or changes their email.
-- Example: Updating 'RAMAH@EMAIL.COM' will save it as 'ramah@email.com'.

DELIMITER $$

CREATE TRIGGER members_email_lowercase_update
BEFORE UPDATE ON members_personal_details
FOR EACH ROW
BEGIN
    IF NEW.email_address IS NOT NULL THEN
        SET NEW.email_address = LOWER(NEW.email_address);
    END IF;
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Trigger: Prevents inserting a row if city_or_town or street_name contains any numbers.
-- Purpose: Ensures address fields remain valid text-only names (e.g., "London", "Valley Road").
-- Example: Input "Lon9don" or "Road 12" will cause the insert to fail.

DELIMITER $$

CREATE TRIGGER members_address_no_numbers_insert
BEFORE INSERT ON members_address
FOR EACH ROW
BEGIN
    IF NEW.city_or_town REGEXP '[0-9]' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'city_or_town cannot contain numbers';
    END IF;

    IF NEW.street_name REGEXP '[0-9]' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'street_name cannot contain numbers';
    END IF;
END $$

DELIMITER ;


-- ==============================================================================================================================
-- Trigger: Prevents updating a row if city_or_town or street_name contains numbers.
-- Purpose: Ensures address fields stay clean even when edited.
-- Example: Updating to "St0ke" or "Hill 9" will be rejected.

DELIMITER $$

CREATE TRIGGER Trigger_members_address_no_numbers_update
BEFORE UPDATE ON members_address
FOR EACH ROW
BEGIN
    IF NEW.city_or_town REGEXP '[0-9]' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'city_or_town cannot contain numbers';
    END IF;

    IF NEW.street_name REGEXP '[0-9]' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'street_name cannot contain numbers';
    END IF;
END $$

DELIMITER ;

-- ==============================================================================================================================
-- Trigger: Validates main_contact_number before inserting a new row.
-- Trigger: Validates the main_contact_number before inserting a new row.
-- Purpose: Ensures the contact number is either:
--          1) 'none'
--          2) 'unknown'
--          3) a numeric-only phone number (digits only, no spaces or symbols)
-- Behavior: Any value outside these rules will cause the INSERT to fail
-- Example: '1234567890' is allowed; '+44', '12-34', 'abc', or '123 abc' are rejected.

DELIMITER $$

CREATE TRIGGER Trigger_members_contact_number_validate_before_insert
BEFORE INSERT ON members_personal_details
FOR EACH ROW
BEGIN
    -- Normalise to lowercase
    SET NEW.main_contact_number = LOWER(NEW.main_contact_number);

    -- If it's NOT 'none' or 'unknown' AND NOT digits-only, reject it
    IF NOT (
        NEW.main_contact_number IN ('none', 'unknown')
        OR NEW.main_contact_number REGEXP '^[0-9]+$'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'main_contact_number must be ''none'', ''unknown'', or numeric digits only';
    END IF;
END $$

DELIMITER ;

DROP TRIGGER IF EXISTS Trigger_members_contact_number_validate_before_update;


-- ==============================================================================================================================

-- Trigger: Validates the main_contact_number before updating an existing row.
-- Purpose: Ensures edits also follow the same strict rules:
--          'none', 'unknown', or digits-only phone numbers.
-- Behavior: Any invalid value will cause the UPDATE to fail.
-- Example: Changing 'none' to '12345' is allowed; changing to '12-34' or '+4477' is rejected.

DELIMITER $$

CREATE TRIGGER Trigger_members_contact_number_validate_before_update
BEFORE UPDATE ON members_personal_details
FOR EACH ROW
BEGIN
    SET NEW.main_contact_number = LOWER(NEW.main_contact_number);

    IF NOT (
        NEW.main_contact_number IN ('none', 'unknown')
        OR NEW.main_contact_number REGEXP '^[0-9]+$'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'main_contact_number must be ''none'', ''unknown'', or numeric digits only';
    END IF;
END $$

DELIMITER ;
