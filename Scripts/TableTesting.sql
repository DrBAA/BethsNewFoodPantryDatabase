USE beths_new_food_pantry;

-- TABLE 1

CREATE TABLE members_address_testing(
	address_id VARCHAR(10) NOT NULL, 
    house_number VARCHAR(15), 
    street_name VARCHAR(50),
    city_or_town VARCHAR(50),
    post_code VARCHAR(10),
   	country VARCHAR(10),
	CONSTRAINT PK_members_address_testing_Address_id PRIMARY KEY (address_id)
);


-- TABLE 2

CREATE TABLE members_personal_details_testing(
	member_id VARCHAR(10) NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age_range VARCHAR(20),
	dependants_under_18 INT,
    main_contact_number VARCHAR(20) NOT NULL,
    email_address VARCHAR(50),
	address_id VARCHAR(10) NOT NULL,    
	CONSTRAINT PK_members_personal_details_testing_Member_id PRIMARY KEY (member_id),
    CONSTRAINT FK_members_personal_details_testing_Address_id FOREIGN KEY (address_id) REFERENCES members_address_testing (address_id) 
);