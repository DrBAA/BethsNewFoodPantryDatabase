
SELECT * FROM beths_new_food_pantry.members_address_testing;

SELECT *
FROM members_address
ORDER BY CAST(SUBSTRING(address_id, 2) AS UNSIGNED);

-- Explanation:
-- SUBSTRING(address_id, 2) removes the 'A' prefix
-- CAST(... AS UNSIGNED) converts the remaining string to a number
-- ORDER BY then sorts numerically: A1, A2, ..., A11

SELECT *
FROM members_personal_details
ORDER BY CAST(SUBSTRING(member_id, 2) AS UNSIGNED);


SELECT *
FROM view_member_address_and_contact
ORDER BY CAST(SUBSTRING(member_id, 2) AS UNSIGNED);

