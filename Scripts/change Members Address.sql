
UPDATE beths_new_food_pantry.members_address
SET address_id = 
  CASE 
    WHEN address_id LIKE 'A%' THEN CONCAT('A', CAST(SUBSTRING(address_id, 2) AS UNSIGNED))
    ELSE address_id
  END;



ALTER TABLE beths_new_food_pantry.members_personal_details
DROP FOREIGN KEY FK_members_personal_details_address_id;


ALTER TABLE beths_new_food_pantry.members_personal_details
ADD CONSTRAINT FK_members_personal_details_address_id
FOREIGN KEY (address_id)
REFERENCES beths_new_food_pantry.members_address(address_id)
ON UPDATE CASCADE;


SELECT *
FROM members_address
ORDER BY CAST(SUBSTRING(address_id, 2) AS UNSIGNED);

UPDATE members_address
SET address_id = 'A0'
WHERE post_code = 'ZZZ';

