-- =================================================================================================================
-- INSERTING INFORMATION INTO THE TABLES ON BETH'S FOOD PANTRY DATABASE 1
-- =================================================================================================================

USE beths_new_food_pantry;

-- TABLE 1 - members_address

INSERT INTO members_address
(address_id, house_number, street_name, city_or_town, post_code, country)

	VALUES
	('ZZZ', 'No fixed abode', 'ZZZ' , 'ZZZ', 'ZZZ', 'UK'),
	('A01', 20, 'Swingle Close', 'Halesowen', 'HH16 8DX', 'UK'),
	('A02', 57, 'High Street', 'Erdington', 'E15 10BL',  'UK'),
	('A03', 32, 'London Road', 'Birmingham', 'B15 6DL', 'UK'),
	('A04', 33, 'Brixto Street','Walsal', 'WX2 7HX',  'UK'),
	('A05', 91, 'Newtown Walk', 'Birmingham', 'B18 6HU',  'UK'),
	('A06', 47, 'Bonn Stret', 'Birmingham', 'B9 5XU', 'UK'),
	('A07', 195, 'Glasgow Street', 'Dudley', 'DL27 9JX', 'UK'),
	('A08', 202, 'Plex Corner', 'Walsal', 'WX5 5BJ', 'UK'),
	('A09', 115, 'Good Hope Street', 'Dudley', 'DL15 8BX',  'UK'),
	('A10', 10, 'Gorsvenor Road', 'Erdington', 'E29 8NW', 'UK'),
    ('A11', 129, 'Daisy Road', 'Birmingham', 'B19 8PA', 'UK');
    
   -- =================================================================================================================
   
   -- TABLE 2 - members_personal_details

INSERT INTO members_personal_details
(member_id, first_name, last_name, age_range, dependants_under_18, main_contact_number, email_address, address_id)

	VALUES
	('M01', 'Agatha', 'Benson', '25-35', 2, '678-896-1022', 'benson@mail.com', 'A01'),
	('M02', 'Lady', 'McBeth', '65-75', 0, '986-188-3124', 'mcbeth@mail.com', 'A02'),
	('M03', 'Naomi', 'Smith', 'prefer not to say', 0, 'unknown', 'unknown', 'A03'),
	('M04', 'Alan', 'Kuboka', '45-55', 2, '333-927-5126', 'kubokaalan@gmail.com', 'A04'),
	('M05', 'Sebastian', 'Ali', '35-45', 4, '253-168-7820', 'ali2@mail.com', 'A05'),
	('M06', 'Mohamed', 'Seladin', '45-55', 3, '582-343-9130', 'seladin.mohamed@mail.com', 'A06'),
	('M07', 'Maimuna', 'Kibeti', '18-25', 2, '891-134-8189', 'kibetienterprises@mail.co.uk', 'A07'),
	('M08', 'Ivy', 'Duncan', '75-85', 0, '672-104-1350', 'unknown', 'A08'),
	('M09', 'Michelle', 'Mohamed', '25-35', 1, 'none', 'michellemohamed@mail.co.uk', 'A09'),
	('M10', 'Michael', 'Blantyre', '55-65', 2, 'unknown', 'michael.blantyre@mail.co.uk', 'A10'),
	('M11', 'Brian', 'Kumalo', '75-85', 2, 'unknown', 'brian.kumalo@mail.co.uk', 'A11'),
    ('M12', 'Jack', 'Maideni', '35-45', 0, 'none', 'unknown', 'ZZZ');

-- =================================================================================================================

-- TABLE 3 food_parcels_for_issue

INSERT INTO food_parcels_for_issue
(food_parcel_id, type_of_food, total_food_parcels_issued, total_food_parcels_remaining)
	VALUES 
	('FP01', 'Normal diet', 0, 0),    
 	('FP02', 'Halal', 0, 0),
	('FP03', 'Normal diabetic', 0, 0),
	('FP04', 'Vegan', 0, 0), 
	('FP05', 'Vegetarian', 0, 0); 

UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 0;

UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 22 WHERE food_parcel_id = 'FP01';
UPDATE food_parcels_for_issue
SET total_food_parcels_issued = 8 WHERE food_parcel_id = 'FP01';

UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 20 WHERE food_parcel_id = 'FP02';
UPDATE food_parcels_for_issue
SET total_food_parcels_issued = 0 WHERE food_parcel_id = 'FP02';

UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 20 WHERE food_parcel_id = 'FP03';
UPDATE food_parcels_for_issue
SET total_food_parcels_issued = 0 WHERE food_parcel_id = 'FP03';

UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 20 WHERE food_parcel_id = 'FP05';
UPDATE food_parcels_for_issue
SET total_food_parcels_issued = 0 WHERE food_parcel_id = 'FP05';


UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 18 WHERE food_parcel_id = 'FP04';
UPDATE food_parcels_for_issue
SET total_food_parcels_issued = 2 WHERE food_parcel_id = 'FP04';



UPDATE food_parcels_for_issue
SET total_food_parcels_remaining = 0
WHERE food_parcel_id IN ('FP02', 'FP03', 'FP05');

SELECT * FROM beths_new_food_pantry.food_parcels_for_issue;


-- =================================================================================================================

-- TABLE 4 incoming_food_parcels 

INSERT INTO incoming_food_parcels
(food_parcel_id, date_received, amount_of_food_parcels_received)
	VALUES
	('FP01', CURDATE(), 5),
    ('FP02', CURDATE(), 5),
    ('FP03', CURDATE(), 5),
    ('FP04', CURDATE(), 5),
    ('FP05', CURDATE(), 5);

# INITIAL INSERTS ON DATABASE CREATION    
	('FP01','2023-12-12', 30),
  	('FP04', '2023-12-14', 20),
	('FP02', '2024-01-08', 20),
	('FP03', '2024-01-12', 20),   
	('FP05', '2023-12-12', 20);

    

   
DELETE FROM incoming_food_parcels
WHERE food_parcel_id = 'FP04';

 -- =================================================================================================================
 
 -- TABLE 5

INSERT INTO laptop_computers_for_issue
(laptop_computer_id, laptop_computer_type, total_laptops_issued, total_laptops_remaining)
	VALUES
    ('COMP01', 'Dell Latitude 7390', 0, 0); -- -- inserted


 -- =================================================================================================================

 -- TABLE 6
 
INSERT INTO incoming_laptop_computers
(laptop_computer_id, date_received, amount_of_laptops_received)
	VALUES
	('COMP01', CURDATE(), 10),    -- inserted
    ('COMP01', '2023-12-05', 20);    -- inserted
 

 -- =================================================================================================================
 
 -- TABLE 7 - main_support_collection_point 

INSERT INTO main_support_collection_point
(collection_point_id, collection_point_name, collection_point_location, collection_point_city)
	VALUES
    ('ERD01', 'Church of the savior', 'Erdington', 'Birmingham'),
	('DUD02', 'Good samaritans', 'Digbeth', 'Birmingham'),
 	('BCC01', 'British heart foundation', 'City centre', 'Birmingham'),
	('WAL01', 'Good samaritans', 'Plex', 'Walsall'),
	('WAL02', 'Swan bank church', 'Town centre', 'Walsall');    
 
    
 -- =================================================================================== 
 
  -- TABLE 8
  
INSERT INTO members_issued_food_parcels
(member_id, food_parcel_id, collection_point_id, date_last_issued, amount_issued)
	VALUES

 -- already inserted   
	('M01', 'FP01', 'ERD01', '2024-01-22', 1),
    ('M02', 'FP01', 'ERD01', '2024-01-22', 1),
	('M03', 'FP01', 'BCC01', '2023-12-21', 1),
	('M04', 'FP01', 'DUD02', '2024-01-25', 1),
	('M05', 'FP01', 'DUD02', '2024-01-18', 1),
 	('M06', 'FP01', 'WAL01', '2023-12-21', 1), 
    ('M07', 'FP01', 'WAL02', '2024-01-25', 1), 
	('M08', 'FP01', 'BCC01', '2024-01-25', 1),  
  	('M09', 'FP04', 'WAL01', '2024-01-24', 1),   
	('M10', 'FP04', 'DUD02', '2024-01-23', 1), 
    
    -- TO INSERT LATER
    ('M12', 'FP04', 'ERD01', CURDATE(), 1),  
 	('M06', 'FP04', 'WAL01', CURDATE(), 1), 
 	('M03', 'FP01', 'BCC01', CURDATE(), 1);  
    
  DELETE FROM members_issued_food_parcels
  WHERE member_id = 'M08' AND date_last_issued = CURDATE();
  
  SELECT * FROM beths_new_food_pantry.members_issued_food_parcels;
  
 -- =================================================================================== 
 
 -- TABLE 9

INSERT INTO members_issued_laptop_computers
(member_id, laptop_computer_id, collection_point_id, date_issued, amount_issued)
	VALUES 

-- already added     
	('M01', 'COMP01', 'ERD01', CURDATE(), 1),   
   	('M07', 'COMP01', 'WAL02', CURDATE(), 1),   
-- TO INSERT LATER
   	('M05', 'COMP01', 'DUD02', '2023-12-14', 1),    
   	('M03', 'COMP01', 'BCC01', '2023-12-14', 1);
    
  
    
 -- =================================================================================== 
 
-- TABLE 10) - other_types_of_support

INSERT INTO other_types_of_support_available_for_members
(type_of_support_id, type_of_support)
	VALUES
	('SUP01', 'advice on welfare benefits'),
	('SUP02', 'applying for welfare benefits'),
	('SUP03', 'housing'),
	('SUP04', 'homelessness'),
	('SUP05', 'sourcing furniture'),
	('SUP06', 'debts advice'),
	('SUP07', 'register with a GP'),
	('SUP08', 'attending medical appointments'),
	('SUP09', 'caring for elderly, sick or disabled people'),
	('SUP10', 'carers support'),
	('SUP11', 'interpreter'),
	('SUP12', 'other');

-- ===================================================================================    
    

-- TABLE 11) - other_requested_support

INSERT INTO other_support_requested_by_members
(member_id, type_of_support_id, date_requested, initial_outcome_of_request, current_status_of_request)
	VALUES
	('M01', 'SUP01', '2024-01-18', 'awaiting allocation', 'awaiting allocation'),
	('M02', 'SUP02', '2023-07-03', 'applied for benefits', 'referral closed'),
	('M02', 'SUP03', '2023-12-12', 'referred to another agency', 'referral closed'),
	('M05', 'SUP12', '2023-07-10', 'advice and information', 'referral closed'),
	('M08', 'SUP05', '2023-12-20', 'allocated to a worker', 'support ongoing'),
	('M08', 'SUP06', '2023-07-20', 'allocated to a worker', 'support ongoing'),
	('M06', 'SUP07', '2024-01-26', 'awaiting allocation', 'awaiting allocation'),
	('M06', 'SUP08', '2023-05-10', 'advice and information', 'referral closed'),
	('M03', 'SUP09', '2023-06-12', 'referred to another agency', 'referral closed'),
	('M03', 'SUP10', '2023-06-12', 'allocated to a worker', 'support ongoing'),
	('M05', 'SUP04', '2023-08-31', 'applied for housing', 'referral closed'),
	('M05', 'SUP03', '2023-12-12', 'awaiting allocation', 'awaiting allocation'),
	('M01', 'SUP02', '2024-01-20', 'awaiting allocation', 'awaiting allocation'),
	('M10', 'SUP11', '2023-05-10', 'allocated to a worker', 'support ongoing'),
	('M04', 'SUP06', '2023-05-25', 'applied for debt relief', 'referral closed'),
	('M07', 'SUP06', '2023-09-10', 'allocated to a worker', 'support ongoing'),
    ('M12', 'SUP03', '2024-01-24', 'awaiting allocation', 'awaiting allocation');
    
    
    
 -- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 