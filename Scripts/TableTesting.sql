USE beths_new_food_pantry;

-- TABLE 1

CREATE TABLE members_address_testing(
    address_id VARCHAR(10) NOT NULL,
    house_number_or_name VARCHAR(15) NOT NULL,
    street_name VARCHAR(50) NOT NULL,
    city_or_town VARCHAR(50) NOT NULL,
    post_code VARCHAR(10) NOT NULL,
    country VARCHAR(10) NOT NULL,

    CONSTRAINT PK_members_address_testing_Address_id PRIMARY KEY (address_id),

    -- Prevent duplicate addresses (full address must be unique)
    CONSTRAINT UQ_members_address_testing_full_address
        UNIQUE (house_number_or_name, street_name, city_or_town, post_code)
);

ALTER TABLE members_address_testing
    DROP INDEX UQ_members_address_testing_full_address;

ALTER TABLE members_address_testing
    ADD CONSTRAINT UQ_members_address_testing_full_address
        UNIQUE (house_number_or_name, post_code);


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


ALTER TABLE members_personal_details_testing
DROP FOREIGN KEY FK_members_personal_details_testing_Address_id;


ALTER TABLE members_personal_details_testing
    ADD CONSTRAINT FK_members_personal_details_testing_address_id
        FOREIGN KEY (address_id)
        REFERENCES members_address_testing (address_id);


ALTER TABLE members_personal_details_testing
    ADD CONSTRAINT UQ_members_personal_details_testing_member_id
        UNIQUE (member_id);
