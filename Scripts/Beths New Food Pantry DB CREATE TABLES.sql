CREATE DATABASE beths_new_food_pantry;

USE beths_new_food_pantry;


-- ===================================================================================  
-- TABLE 1

CREATE TABLE members_address(
	address_id VARCHAR(10) NOT NULL, 
    house_number VARCHAR(15), 
    street_name VARCHAR(50),
    city_or_town VARCHAR(50),
    post_code VARCHAR(10),
   	country VARCHAR(10),
	CONSTRAINT PK_members_post_code_Address_id PRIMARY KEY (address_id)
);

ALTER TABLE members_address
MODIFY house_number VARCHAR(15) NOT NULL;

ALTER TABLE members_address
MODIFY post_code VARCHAR(10) NOT NULL;

--
ALTER TABLE members_address
    CHANGE COLUMN house_number house_number_or_name VARCHAR(15) NOT NULL;

--

ALTER TABLE members_address
    MODIFY COLUMN street_name VARCHAR(50) NOT NULL;

ALTER TABLE members_address
    MODIFY COLUMN city_or_town VARCHAR(50) NOT NULL;

ALTER TABLE members_address
    ADD CONSTRAINT UQ_members_address_unique
        UNIQUE (house_number_or_name, post_code);

ALTER TABLE members_address
    MODIFY COLUMN country VARCHAR(10) NOT NULL;
--
ALTER TABLE members_address
    MODIFY country VARCHAR(2) NOT NULL DEFAULT 'UK',
    ADD CONSTRAINT CHK_country_only_uk CHECK (country = 'UK');
  
ALTER TABLE members_address
ADD CONSTRAINT uq_address_id UNIQUE (address_id);

  
--
UPDATE members_address
SET house_number_or_name = '39'
WHERE address_id = 'A21';
  
--
ALTER TABLE members_address
ADD CONSTRAINT CHK_no_empty_values
CHECK (
    TRIM(house_number_or_name) <> '' AND
    TRIM(street_name) <> '' AND
    TRIM(city_or_town) <> '' AND
    TRIM(post_code) <> '' AND
    TRIM(country) <> ''
);


ALTER TABLE members_address
ADD CONSTRAINT CHK_house_number_not_empty CHECK (TRIM(house_number_or_name) <> '');

ALTER TABLE members_address
ADD CONSTRAINT CHK_street_name_not_empty CHECK (TRIM(street_name) <> '');

ALTER TABLE members_address
ADD CONSTRAINT CHK_city_not_empty CHECK (TRIM(city_or_town) <> '');

ALTER TABLE members_address
ADD CONSTRAINT CHK_post_code_not_empty CHECK (TRIM(post_code) <> '');

ALTER TABLE members_address
ADD CONSTRAINT CHK_country_not_empty CHECK (TRIM(country) <> '');

ALTER TABLE members_address
DROP CONSTRAINT CHK_no_empty_values;

SHOW CREATE TABLE members_address;
# Table, Create Table
-- 'members_address', 'CREATE TABLE `members_address` 
-- (\n  `address_id` varchar(10) NOT NULL,
-- \n  `house_number_or_name` varchar(15) NOT NULL,
-- \n  `street_name` varchar(50) NOT NULL,
-- \n  `city_or_town` varchar(50) NOT NULL,
-- \n  `post_code` varchar(10) NOT NULL,
-- \n  `country` varchar(2) NOT NULL DEFAULT \'UK\',
-- \n  PRIMARY KEY (`address_id`),\n  UNIQUE KEY `UQ_members_address_unique` (`house_number_or_name`,`post_code`),
-- \n  CONSTRAINT `CHK_city_not_empty` CHECK ((trim(`city_or_town`) <> _utf8mb4\'\')),
-- \n  CONSTRAINT `CHK_country_not_empty` CHECK ((trim(`country`) <> _utf8mb4\'\')),
-- \n  CONSTRAINT `CHK_house_number_not_empty` CHECK ((trim(`house_number_or_name`) <> _utf8mb4\'\')),
-- \n  CONSTRAINT `CHK_street_name_not_empty` CHECK ((trim(`street_name`) <> _utf8mb4\'\'))\n) 
-- \n  CONSTRAINT `CHK_post_code_not_empty` CHECK ((trim(`post_code`) <> _utf8mb4\'\')),
-- \n  CONSTRAINT `CHK_country_only_uk` CHECK ((`country` = _utf8mb4\'UK\')),
-- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'


--
ALTER TABLE members_address
ADD CONSTRAINT chk_street_name_no_numbers
CHECK (street_name NOT REGEXP '[0-9]');

ALTER TABLE members_address
ADD CONSTRAINT chk_city_or_town_no_numbers
CHECK (city_or_town NOT REGEXP '[0-9]');


-- Add a CHECK constraint:
ALTER TABLE members_address
ADD CONSTRAINT chk_postcode_format
CHECK (
    post_code = 'ZZZ'
    OR post_code REGEXP '^[A-Z]{1,2}[0-9][0-9A-Z]? ?[0-9][A-Z]{2}$'
);




-- ===================================================================================  

-- TABLE 2

CREATE TABLE members_personal_details(
	member_id VARCHAR(10) NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age_range VARCHAR(20),
	dependants_under_18 INT,
    main_contact_number VARCHAR(20) NOT NULL,
    email_address VARCHAR(50),
	address_id VARCHAR(10) NOT NULL,    
	CONSTRAINT PK_members_personal_details_Member_id PRIMARY KEY (member_id),
    CONSTRAINT FK_members_personal_details_address_id FOREIGN KEY (address_id) REFERENCES members_address (address_id) 
);

ALTER TABLE members_personal_details
MODIFY first_name VARCHAR(20) NOT NULL;

ALTER TABLE members_personal_details
MODIFY last_name VARCHAR(20) NOT NULL;

ALTER TABLE members_personal_details
MODIFY age_range VARCHAR(20) CHECK (age_range IN ('18-25', '25-35', '35-45', '45-55', '55-65', '65-75',
'75-85', '85-95', '95-105', '105-150', 'prefer not to say')) NOT NULL;

-- DROP THE ADDRESS_ID FOREIGN KEY // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.members_personal_details
DROP FOREIGN KEY FK_members_personal_details_address_id;

-- CHANGE ADDRESS IDS FROM A01 TO A1 // DONE 17 8 2025
UPDATE beths_new_food_pantry.members_address
SET address_id = 
  CASE 
    WHEN address_id LIKE 'A%' THEN CONCAT('A', CAST(SUBSTRING(address_id, 2) AS UNSIGNED))
    ELSE address_id
  END;

-- ADD THE ADDRESS_ID FOREIGN KEY AGAIN // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.members_personal_details
ADD CONSTRAINT FK_members_personal_details_address_id
FOREIGN KEY (address_id)
REFERENCES beths_new_food_pantry.members_address(address_id)
ON UPDATE CASCADE;

-- CHANGE MEMBER ID FROM M01 TO M1
-- DROP FK on member_id from members_personal_details
ALTER TABLE beths_new_food_pantry.members_personal_details
DROP FOREIGN KEY FK_members_personal_details_member_id;

-- CHANGE MEMBER IDS FROM M1 TO M01 // DONE 17 8 2025

-- DISABLE SAFE MODE TO ALLOW UPDATE
SET SQL_SAFE_UPDATES = 0;

-- UPDATE MEMBER_ID FORMAT IN PARENT TABLE
UPDATE beths_new_food_pantry.members_personal_details
SET member_id = 
  CASE 
    WHEN member_id LIKE 'M%' AND LENGTH(member_id) = 2 THEN CONCAT('M0', SUBSTRING(member_id, 2))
    ELSE member_id
  END;

-- RE-ENABLE SAFE MODE
SET SQL_SAFE_UPDATES = 1;



-- CHANGE MEMBER IDS FROM M01 TO M1 // DONE 17 8 2025
-- DISABLE SAFE MODE TO ALLOW UPDATE
SET SQL_SAFE_UPDATES = 0;

-- UPDATE MEMBER_ID FORMAT IN PARENT TABLE
UPDATE beths_new_food_pantry.members_personal_details
SET member_id = 
  CASE 
    WHEN member_id LIKE 'M0%' AND LENGTH(member_id) = 3 THEN CONCAT('M', SUBSTRING(member_id, 3))
    ELSE member_id
  END;

-- RE-ENABLE SAFE MODE
SET SQL_SAFE_UPDATES = 1;




-- ===================================================================================  

-- TABLE 3

CREATE TABLE food_parcels_for_issue (
	food_parcel_id VARCHAR(20) NOT NULL,
	type_of_food VARCHAR(50) NOT NULL,
    total_food_parcels_issued INT,
    total_food_parcels_remaining INT,
	CONSTRAINT PK_food_parcels_for_issue_Food_parcel_id PRIMARY KEY (food_parcel_id )
);

ALTER TABLE food_parcels_for_issue
MODIFY total_food_parcels_issued INT NOT NULL;

ALTER TABLE food_parcels_for_issue
MODIFY  total_food_parcels_remaining INT NOT NULL;

ALTER TABLE food_parcels_for_issue
ALTER total_food_parcels_issued SET DEFAULT 0;

ALTER TABLE food_parcels_for_issue
ALTER total_food_parcels_remaining SET DEFAULT 0;

ALTER TABLE food_parcels_for_issue
MODIFY type_of_food VARCHAR (50) CHECK (type_of_food IN ('Normal diet', 'Halal', 'Normal diabetic', 'Vegan', 'Vegetarian')) NOT NULL;




SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;

-- ===================================================================================   
-- TABLE 4

CREATE TABLE incoming_food_parcels (
	food_parcel_id VARCHAR(20) NOT NULL,
    date_received DATE,
	amount_of_food_parcels_received INT,
	CONSTRAINT FK_incoming_food_parcels_Food_parcel_id FOREIGN KEY (food_parcel_id) REFERENCES food_parcels_for_issue (food_parcel_id) 
);

ALTER TABLE incoming_food_parcels
MODIFY amount_of_food_parcels_received INT NOT NULL;

ALTER TABLE incoming_food_parcels
MODIFY date_received DATE NOT NULL;


-- ===================================================================================   

-- TABLE 5

CREATE TABLE laptop_computers_for_issue (
	laptop_computer_id VARCHAR(20) NOT NULL,
	laptop_computer_type VARCHAR(30) NOT NULL,
    total_laptops_issued INT,
    total_laptops_remaining INT,
	CONSTRAINT PK_laptop_computers_for_issue_Laptop_computer_id PRIMARY KEY (laptop_computer_id)
);

ALTER TABLE laptop_computers_for_issue
MODIFY total_laptops_issued INT NOT NULL;

ALTER TABLE laptop_computers_for_issue
MODIFY  total_laptops_remaining INT NOT NULL;

ALTER TABLE laptop_computers_for_issue
ALTER total_laptops_issued SET DEFAULT 0;

ALTER TABLE laptop_computers_for_issue
ALTER total_laptops_remaining SET DEFAULT 0;

-- ===================================================================================   

-- TABLE 6

CREATE TABLE incoming_laptop_computers (
	laptop_computer_id VARCHAR(20) NOT NULL,
	date_received DATE,
	amount_of_laptops_received INT,
	CONSTRAINT FK_incoming_laptop_computers_Laptop_computer_id FOREIGN KEY (laptop_computer_id) REFERENCES laptop_computers_for_issue (laptop_computer_id)     
);

ALTER TABLE incoming_laptop_computers
MODIFY amount_of_laptops_received INT NOT NULL;

ALTER TABLE incoming_laptop_computers
MODIFY date_received DATE NOT NULL;

-- ===================================================================================  

-- TABLE 7

CREATE TABLE main_support_collection_point (
	collection_point_id VARCHAR(20) NOT NULL,
	collection_point_name VARCHAR(100) NOT NULL,
	collection_point_location VARCHAR(50) NOT NULL,
	collection_point_city VARCHAR(50) NOT NULL,
	CONSTRAINT PK_main_support_collection_point_Collection_point_id PRIMARY KEY (collection_point_id)   
);

-- ===================================================================================     

-- TABLE 8

CREATE TABLE members_issued_food_parcels (
	member_id VARCHAR(10) NOT NULL,
    food_parcel_id VARCHAR(20) NOT NULL,
    collection_point_id VARCHAR(10) NOT NULL,
    date_last_issued DATE,
    amount_issued INT CHECK (amount_issued IN (1)),
	CONSTRAINT FK_members_issued_food_parcels_Member_id FOREIGN KEY (member_id) REFERENCES members_personal_details (member_id), 
    CONSTRAINT FK_members_issued_food_parcels_Food_parcel_id FOREIGN KEY (food_parcel_id) REFERENCES food_parcels_for_issue (food_parcel_id),
    CONSTRAINT FK_members_issued_food_parcels_Collection_point_id FOREIGN KEY (collection_point_id) REFERENCES main_support_collection_point (collection_point_id)
); 

ALTER TABLE members_issued_food_parcels
MODIFY date_last_issued DATE NOT NULL;

ALTER TABLE members_issued_food_parcels
MODIFY amount_issued INT CHECK (amount_issued IN (1)) NOT NULL;

-- DROP FK: FK_members_issued_food_parcels_Member_id // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.members_issued_food_parcels
DROP FOREIGN KEY FK_members_issued_food_parcels_Member_id;

-- RE-ADD FK: FK_members_issued_food_parcels_Member_id // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.members_issued_food_parcels
ADD CONSTRAINT FK_members_issued_food_parcels_Member_id
FOREIGN KEY (member_id)
REFERENCES beths_new_food_pantry.members_personal_details(member_id)
ON UPDATE CASCADE;


-- ===================================================================================    
-- TABLE 9

CREATE TABLE members_issued_laptop_computers (
	member_id VARCHAR(10) NOT NULL,
    laptop_computer_id VARCHAR(20) NOT NULL,
    collection_point_id VARCHAR(10) NOT NULL,
    date_last_issued DATE,
    amount_issued INT CHECK (amount_issued IN (1)),
	CONSTRAINT FK_members_issued_laptop_computers_Member_id FOREIGN KEY (member_id) REFERENCES members_personal_details (member_id), 
    CONSTRAINT FK_members_issued_laptop_computers_Laptop_computer_id FOREIGN KEY (laptop_computer_id) REFERENCES laptop_computers_for_issue (laptop_computer_id),
    CONSTRAINT FK_members_issued_laptop_computers_Collection_point_id FOREIGN KEY (collection_point_id) REFERENCES main_support_collection_point (collection_point_id)
); 

ALTER TABLE members_issued_laptop_computers
RENAME COLUMN date_last_issued TO date_issued;

ALTER TABLE members_issued_laptop_computers
ADD UNIQUE (member_id);

ALTER TABLE members_issued_laptop_computers
MODIFY date_last_issued DATE NOT NULL;

ALTER TABLE members_issued_laptop_computers
MODIFY amount_issued INT CHECK (amount_issued IN (1)) NOT NULL;

ALTER TABLE members_issued_laptop_computers
DROP FOREIGN KEY FK_members_issued_laptop_computers_Member_id;


ALTER TABLE members_issued_laptop_computers
DROP INDEX member_id;

ALTER TABLE members_issued_laptop_computers
ADD CONSTRAINT FK_members_issued_laptop_computers_Member_id
FOREIGN KEY (member_id)
REFERENCES members_personal_details(member_id)
ON UPDATE CASCADE;


SHOW CREATE TABLE members_issued_laptop_computers;

SHOW INDEX FROM members_issued_laptop_computers;


-- DROP FK: FK_members_issued_laptop_computers_Member_id // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.members_issued_laptop_computers
DROP FOREIGN KEY FK_members_issued_laptop_computers_Member_id;

-- RE-ADD FK: FK_members_issued_food_parcels_Member_id // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.members_issued_laptop_computers
ADD CONSTRAINT FK_members_issued_laptop_computers_Member_id
FOREIGN KEY (member_id)
REFERENCES beths_new_food_pantry.members_personal_details(member_id)
ON UPDATE CASCADE;




-- ===================================================================================   
-- TABLE 10

CREATE TABLE other_types_of_support_available_for_members(
	type_of_support_id VARCHAR(20) NOT NULL,
	type_of_support VARCHAR(100),
	CONSTRAINT PK_other_types_of_support_available_for_members_ PRIMARY KEY (type_of_support_id) -- Type_of_support_id
);

ALTER TABLE other_types_of_support_available_for_members
MODIFY type_of_support VARCHAR(100) NOT NULL;

-- ====================================================================================================================================================================

-- TABLE 11

CREATE TABLE other_support_requested_by_members(
	member_id VARCHAR(10) NOT NULL,	
    type_of_support_id VARCHAR(20) NOT NULL,
    date_requested DATE,
    initial_outcome_of_request VARCHAR(100),
    current_status_of_request VARCHAR(100),
	CONSTRAINT FK_other_support_requested_by_members_Type_of_support_id FOREIGN KEY (type_of_support_id) REFERENCES other_types_of_support_available_for_members (type_of_support_id), 
	CONSTRAINT FK_other_support_requested_by_members_Member_id FOREIGN KEY (member_id) REFERENCES members_personal_details (member_id) 
);

-- DROP FK: FK_other_support_requested_by_members_Member_id // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.other_support_requested_by_members
DROP FOREIGN KEY FK_other_support_requested_by_members_Member_id;

-- RE-ADD FK: FK_members_issued_food_parcels_Member_id // DONE 17 8 2025
ALTER TABLE beths_new_food_pantry.other_support_requested_by_members
ADD CONSTRAINT FK_other_support_requested_by_members_Member_id
FOREIGN KEY (member_id)
REFERENCES beths_new_food_pantry.members_personal_details(member_id)
ON UPDATE CASCADE;



-- ====================================================================================================================================================================

ALTER TABLE other_support_requested_by_members
MODIFY date_requested DATE NOT NULL;

ALTER TABLE other_support_requested_by_members
MODIFY initial_outcome_of_request VARCHAR(100) NOT NULL;

ALTER TABLE other_support_requested_by_members
MODIFY current_status_of_request VARCHAR(100) NOT NULL;

-- ====================================================================================================================================================================
ALTER TABLE other_support_requested_by_members
ADD COLUMN progress_notes LONGTEXT NULL,
ADD COLUMN last_progress_update_date DATETIME NULL;

-- progress_notes stores the append-only support history.
-- last_progress_update_date starts as NULL.
-- The backend updates last_progress_update_date only when a new progress note is added.
-- Status changes such as:
-- awaiting allocation → support ongoing
-- support ongoing → referral closed
-- do not affect last_progress_update_date.
-- The frontend will use a status dropdown to update current_status_of_request.


-- ===================================================================================================
-- Make key columns mandatory and provide sensible defaults for new support requests
-- MySQL automatically insert today's date when the date_requested column is omitted from an INSERT
-- ===================================================================================================

ALTER TABLE other_support_requested_by_members
MODIFY COLUMN date_requested DATE NOT NULL DEFAULT (CURRENT_DATE),
MODIFY COLUMN initial_outcome_of_request VARCHAR(100)
    NOT NULL DEFAULT 'awaiting initial decision',
MODIFY COLUMN current_status_of_request VARCHAR(100)
    NOT NULL DEFAULT 'awaiting initial decision';


-- ====================================================================================================================================================================

CREATE TABLE temp_search_results_after_check_eligiblity_for_food_parcel (
    search_id CHAR(36) NOT NULL PRIMARY KEY,         -- UUID for search session
    user_id VARCHAR(255) NOT NULL,                   -- Authenticated user ID
    member_list_json JSON NOT NULL                   -- Serialized list of members
);

