BETHS NEW FOOD PANTRY DATA BASE PROJECT


CORE Q1, Q2, Q3, Q4, Q5 and Q6 - DONE
ADVANCED Q1, Q2, Q4 and Q5 - DONE
ADV Q3 NOT DOING IT

USE beths_new_food_pantry;

-- ==============================================================================================================================

CORE Q4). IN YOUR DATABASE, CREATE A stored function THAT CAN BE APPLIED TO A QUERY IN YOUR DB
-- CREATE A FUNCTION TO CONCAT 2 NAMES FROM 2 COLUMNS
-- ==============================================================================================================================

CREATE FUNCTION full_name(first_name VARCHAR(20), last_name VARCHAR(20))
RETURNS VARCHAR (55) DETERMINISTIC
RETURN CONCAT(first_name, ' ', last_name);

-- ==============================================================================================================================


-- ==============================================================================================================================
CORE Q3). USING ANY TYPE OF THE joins, CREATE A view THAT COMBINES MULTIPLE TABLES IN A LOGICAL WAY - DONE
-- ==============================================================================================================================

CREATE A LIST OF MEMBERS NAMES PLUS OTHER TYPES OF SUPPORT EACH MEMBER HAS REQUESTED FOR,
DATE REQUESTED, INITIAL OUTCOME OF REQUEST AND CURRENT STATUS OF THAT REQUEST
WHERE CURRENT STATUS OF REQUEST IS "AWAITING ALLOCATION" OR "SUPPORT ONGOING"
ORDERED BY CURRENT STATUS OF REQUEST AND DATE REQUESTED


CREATE OR REPLACE VIEW View_support_ongoing_OR_awaiting_allocation 
AS
	SELECT
		mpd.member_id,
        full_name(first_name, last_name) AS members_name,
        post_code,
        type_of_support,
		date_requested, initial_outcome_of_request AS initial_outome,
        current_status_of_request 
	FROM
		members_personal_details mpd
	INNER JOIN members_address AS ma    
	ON
		ma.address_id = mpd.address_id        
	INNER JOIN
		other_support_requested_by_members osr 
	ON
		mpd.member_id = osr.member_id
	INNER JOIN
		other_types_of_support_available_for_members ots
	ON
		ots.type_of_support_id = osr.type_of_support_id
	WHERE
		current_status_of_request  = 'awaiting allocation'
		OR current_status_of_request  = 'support ongoing'       
	ORDER BY
		current_status_of_request ASC, date_requested;

SELECT * FROM
	View_support_ongoing_OR_awaiting_allocation



-- ==============================================================================================================================
ADVANCED Q5). PREPARE AN EXAMPLE query WITH group by AND having TO DEMONSTRTE HOW TO EXTRACT DATA FROM YOUR DB FOR ANALYSIS 
-- ==============================================================================================================================

SHOW THE TOTAL NUMBER OF REQUESTS FOR OTHER TYPES OF SUPPORT
WHERE CURRENT STATUS OF REQUEST IS "AWAITING ALLOCATION" OR "SUPPORT ONGOING"

SELECT * FROM beths_new_food_pantry.other_support_requested_by_members
ORDER BY current_status_of_request ASC;


SELECT current_status_of_request, COUNT(current_status_of_request) AS total
FROM
	other_support_requested_by_members 
GROUP BY current_status_of_request
HAVING current_status_of_request = 'awaiting allocation' OR current_status_of_request = 'support ongoing';




-- ==============================================================================================================================
CORE Q5. PREPARE AN EXAMPLE query WITH A subquery TO DEMONSTRATE HOW TO EXTRACT DATA FROM YOUR DB FOR ANALYSIS 
-- ==============================================================================================================================
Show a list of MEMBERS who have NOT RECEIVED a LAPTOP COMPUTER. Include the members ID, FULL NAME, POST CODE,
MAIN_CONTACT_NUMBER AND EMAIL_ADDRESS

SELECT
	member_id,
	full_name(first_name, last_name) AS members_name,
	post_code,
	main_contact_number,
	email_address
FROM
	Beths_new_food_pantry.members_personal_details AS mpd 
LEFT JOIN
	Beths_new_food_pantry.members_address AS ma
ON
	ma.address_id = mpd.address_id 
WHERE   
	member_id NOT IN (SELECT member_id FROM beths_new_food_pantry.members_issued_laptop_computers)
ORDER BY member_id ASC;

SELECT * FROM View_members_issued_with_laptops;


                                       



-- ==============================================================================================================================
ADVANCED Q4A). CREATE A view THAT USES AT LEAST 3-4 base tables, THEN PREPARE AND DEMONSTRATE A query 
THAT USES THE view TO PRODUCE A logically arranged result SET FOR ANALYSIS		
-- ==============================================================================================================================

Create a list of ALL MEMBERS who have BEEN ISSUED OR NOT BEEN ISSUED A FOOD PARCEL.
include the MEMBERS NAME, MEMBERS ID, POST CODE, DATE LAST ISSUED, COLLECTION POINT NAME,
COLLECTION POINT LOCATION, COLLECTION POINT CITY, NUMBER OF DAYS SINCE LAST ISSUE AND DATE DUE FOR
NEXT ISSUE WHICH SHOULD BE 7 DAYS AFTER THE LAST ISSUE 

-- AMENDED CODE 02/1/2025 - introduced a subquery within the below vew that selects the maximum issue date for each member.
-- This subquery was then joined with other tables to ensure the View includes only the most recent date of issue, avoiding historical dates.

CREATE OR REPLACE VIEW View_members_Issued_or_Not_issued_with_food_parcels AS
SELECT 
    mpd.member_id,
    CONCAT(mpd.first_name, ' ', mpd.last_name) AS members_name,
    ma.post_code,
    fpfi.type_of_food,
    CONCAT(mscp.collection_point_name, ', ', mscp.collection_point_location, ', ', mscp.collection_point_city) AS collection_point_location,
    latest_issued.date_last_issued,
    DATEDIFF(curdate(), latest_issued.date_last_issued) AS days_since_last_issue,
    DATE_ADD(latest_issued.date_last_issued, INTERVAL 7 DAY) AS next_issue_due_date
FROM
    Beths_new_food_pantry.members_personal_details AS mpd
LEFT JOIN
    Beths_new_food_pantry.members_address AS ma ON ma.address_id = mpd.address_id
LEFT JOIN
    (SELECT 
         member_id, 
         MAX(date_last_issued) AS date_last_issued
     FROM 
         Beths_new_food_pantry.members_issued_food_parcels 
     GROUP BY 
         member_id) AS latest_issued ON mpd.member_id = latest_issued.member_id
LEFT JOIN 
    Beths_new_food_pantry.members_issued_food_parcels AS mifp ON mpd.member_id = mifp.member_id AND latest_issued.date_last_issued = mifp.date_last_issued
LEFT JOIN 
    Beths_new_food_pantry.food_parcels_for_issue AS fpfi ON mifp.food_parcel_id = fpfi.food_parcel_id
LEFT JOIN
    Beths_new_food_pantry.main_support_collection_point AS mscp ON mscp.collection_point_id = mifp.collection_point_id;


SELECT * FROM View_members_Issued_or_Not_issued_with_food_parcels

-- ==============================================================================================================================
ADVANCED Q4B). CREATE A QUERY THAT USES THE ABOVE VIEW TO FIND OUT WHICH MEMBERS CAN HAVE OR NOT HAVE A FOOD PARCEL TODAY
OR WHETHER A SPECIFIC MEMBER CAN HAVE A FOOD PARCEL TODAY OR NEEDS TO COME BACK NEXT WEEK 
INCLUDE the MEMBER ID, MEMBERS NAME, POST CODE, TYPE OF FOOD ISSUED, COLLECTION POINT LOCATION, DATE LAST ISSUED AND NEXT ISSUE DUE DATE

CREATE OR REPLACE VIEW View_members_due_or_not_due_for_food_parcels AS
SELECT
    member_id,
    members_name,
    post_code,
    type_of_food,
    collection_point_location AS collection_point,
    date_last_issued AS date_last_collected_a_food_parcel,
    days_since_last_issue AS days_since_last_collection,
    next_issue_due_date AS date_due_for_next_collection,
    IF((date_last_issued IS NULL) OR (days_since_last_issue >= 7), 'YES', 
       CONCAT('NO. Please ask the member to come back on or after ', next_issue_due_date)) AS Issue_a_food_parcel_today_or_Not
FROM View_members_Issued_or_Not_issued_with_food_parcels;

      
SELECT * FROM View_members_due_or_not_due_for_food_parcels;

-- PREVIOUS CODE 02/1/2025 - this was adding all the dates of issue including history dates 
/*
CREATE OR REPLACE VIEW View_members_Issued_or_Not_issued_with_food_parcels
AS
	(SELECT 
		mpd.member_id,
        full_name(first_name, last_name) AS members_name,
        post_code, type_of_food,
        CONCAT(collection_point_name, ', ', collection_point_location, ', ', collection_point_city) AS collection_point_location,
        date_last_issued,
        DATEDIFF(curdate(), mifp.date_last_issued) AS days_since_last_issue,
        DATE_ADD(mifp.date_last_issued, INTERVAL 7 DAY) AS next_issue_due_date
	FROM
		Beths_new_food_pantry.members_personal_details AS mpd 
	LEFT JOIN
		Beths_new_food_pantry.members_address AS ma
	ON
		ma.address_id = mpd.address_id
	LEFT JOIN
		Beths_new_food_pantry.members_issued_food_parcels AS mifp 
	ON
		mpd.member_id = mifp.member_id
	LEFT JOIN 
		Beths_new_food_pantry.food_parcels_for_issue AS fpfi  
	ON
		mifp.food_parcel_id = fpfi.food_parcel_id
	LEFT JOIN
		Beths_new_food_pantry.main_support_collection_point AS mscp 
	ON
		mscp.collection_point_id = mifp.collection_point_id);
 */ 

SELECT * FROM
	(SELECT
		member_id,
		members_name,
		post_code,
		type_of_food,
		collection_point_location,
		date_last_issued,
		days_since_last_issue,        
		next_issue_due_date,
		IF((date_last_issued IS NULL) OR (days_since_last_issue >= 7), 'Yes', 'Come back next week') AS Issue_a_food_parcel_or_Not
		FROM View_members_Issued_or_Not_issued_with_food_parcels) all_members
WHERE members_name LIKE '%MOHAMED SELADIN%' OR members_name LIKE '%MICHAEL BLANTYRE%'
OR members_name LIKE '%IVY DUNCAN%' OR members_name LIKE '%JACK MAIDENI%' OR members_name LIKE '%MICHELLE MOHAMED%'
ORDER BY Issue_a_food_parcel_or_Not DESC;


SELECT * FROM
	(SELECT
		member_id,
		members_name,
		post_code,
		type_of_food,
		collection_point_location,
		date_last_issued,
		days_since_last_issue,        
		next_issue_due_date,
		IF((date_last_issued IS NULL) OR (days_since_last_issue >= 7), 'Yes', 'Come back next week') AS Issue_a_food_parcel_or_Not
		FROM View_members_Issued_or_Not_issued_with_food_parcels) all_members
WHERE members_name LIKE '%MOHAMED SELADIN%' && member_id = 'M06';

-- ==============================================================================================================================
ADVANCED Q1). IN YOUR DATABASE, CREATE a stored procedure AND DEMONSTRATE HOW IT RUNS
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


-- ==============================================================================================================================
ADVANCED Q2). IN YOUR DATABASE, CREATE A trigger AND DEMONSTRATE HOW IT RUNS - DONE

-- Create a TRIGGER which AUTOMATICALLY updates the FOOD PARCELS STOCK LEVELS AFTER a FOOD PARCEL IS ISSUED TO A MEMBER

-- Create a TRIGGER which AUTOMATICALLY updates the NORMAL DIET (FP01) FOOD PARCELS STOCK LEVELS
 AFTER a NORMAL DIET (FPO1) FOOD PARCEL IS ISSUED TO A MEMBER

-- ==============================================================

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
    
-- ==============================================================


-- ==============================================================================================================================
USE A STORED PROCEDURE TO ISSUE A FOOD PARCEL TO 
MOHAMED SELADIN MEMBER ID M06 - HALAL FOOD
MICHAEL BLANTYRE MEMBER ID M10 - NORMAL DIABETIC DIET
IVY DUNCAN MEMBER ID M08 - VEGETARIAN
JACK MAIDENI MEMBER ID M12 - VEGAN
THE TRIGGER WILL AUTOMATICALLY UPDATE THE FOOD PARCELS STOCK LEVELS ON the FOOD PARCELS FOR ISSUE TABLE

CALL Sproc_issue_a_FOOD_parcel_IF_one_is_due ('M06', 'FP02', 'WAL01', CURDATE(), 1); 
CALL Sproc_issue_a_FOOD_parcel_IF_one_is_due ('M10', 'FP03', 'DUD02', CURDATE(), 1); 
CALL Sproc_issue_a_FOOD_parcel_IF_one_is_due ('M08', 'FP05', 'BCC01', CURDATE(), 1); 
CALL Sproc_issue_a_FOOD_parcel_IF_one_is_due ('M12', 'FP04', 'ERD01', CURDATE(), 1);

SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;    

SELECT * FROM beths_new_food_pantry.members_issued_food_parcels
order by date_last_issued desc; 


SELECT *,
IF((date_last_issued IS NULL) OR (days_since_last_issue >= 7), 'Yes', 'Come back another day') AS Issue_a_food_parcel_or_Not
FROM View_members_Issued_or_Not_issued_with_food_parcels
WHERE members_name LIKE '%MOHAMED SELADIN%' OR members_name LIKE '%MICHAEL BLANTYRE%'
	OR members_name LIKE '%IVY DUNCAN%' OR members_name LIKE '%JACK MAIDENI%' OR members_name LIKE '%MICHELLE MOHAMED%' 
ORDER BY Issue_a_food_parcel_or_Not DESC, member_id;




*********************************************************    THE END  ************************************************************












-- ============================================================================================================== BELOW CODE IS CORRECT BUT NOT IN USE 


    

-- =============================================================================================================

Show a list of MEMBERS who have NOT RECEIVED a LAPTOP COMPUTER. Include the members NAME ID and POST CODE,
MAIN_CONTACT_NUMBER AND EMAIL_ADDRESS

-- OTHER METHODS


-- ======================================================
 -- SECOND METHOD
 
SELECT 
	member_id,
	members_name,
	post_code,
	main_contact_number,
	email_address
FROM    
	(SELECT
			mpd.member_id,
			full_name(first_name, last_name) AS members_name,
			post_code,
			main_contact_number,
			email_address,
			laptop_computer_type,
			date_issued,
			CONCAT(collection_point_name, ', ', collection_point_location, ', ', collection_point_city) AS collection_point_location
		FROM
			Beths_new_food_pantry.members_personal_details AS mpd 
		LEFT JOIN
			Beths_new_food_pantry.members_address AS ma
		ON
			ma.address_id = mpd.address_id
		LEFT JOIN
			Beths_new_food_pantry.members_issued_laptop_computers AS milc 
		ON
			mpd.member_id = milc.member_id
		LEFT JOIN 
			Beths_new_food_pantry.laptop_computers_for_issue AS lci  
		ON
			milc.laptop_computer_id = lci.laptop_computer_id
		LEFT JOIN
			Beths_new_food_pantry.main_support_collection_point AS mscp 
		ON
			mscp.collection_point_id = milc.collection_point_id) AS all_members
      
WHERE
	laptop_computer_type IS NULL OR date_last_issued IS NULL;  
      



-- =====================================================
-- THIRD METHOD

SELECT
	member_id,
	full_name(first_name, last_name) AS members_name,
	post_code,
	main_contact_number,
	email_address
FROM
	Beths_new_food_pantry.members_personal_details AS mpd 
LEFT JOIN
	Beths_new_food_pantry.members_address AS ma
ON
	ma.address_id = mpd.address_id 
WHERE
		member_id NOT IN (SELECT member_id FROM View_members_issued_with_laptops);

CREATE OR REPLACE VIEW View_members_issued_with_laptops
AS
	(SELECT
			mpd.member_id,
			full_name(first_name, last_name) AS members_name,
			post_code,
			main_contact_number,
			email_address,
			laptop_computer_type,
			date_issued,
			CONCAT(collection_point_name, ', ', collection_point_location, ', ', collection_point_city) AS collection_point_location
		FROM
			Beths_new_food_pantry.members_personal_details AS mpd 
		INNER JOIN
			Beths_new_food_pantry.members_address AS ma
		ON
			ma.address_id = mpd.address_id
		INNER JOIN
			Beths_new_food_pantry.members_issued_laptop_computers AS milc 
		ON
			mpd.member_id = milc.member_id
		INNER JOIN 
			Beths_new_food_pantry.laptop_computers_for_issue AS lci  
		ON
			milc.laptop_computer_id = lci.laptop_computer_id
		INNER JOIN
			Beths_new_food_pantry.main_support_collection_point AS mscp 
		ON
			mscp.collection_point_id = milc.collection_point_id); 
      

-- ========================================================================================================

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