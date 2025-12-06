SELECT 
    CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'beths_new_food_pantry'
    AND TABLE_NAME = 'members_personal_details';



SELECT 
    CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'beths_new_food_pantry'
    AND TABLE_NAME = 'members_issued_food_parcels';



SELECT 
    CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'beths_new_food_pantry'
    AND TABLE_NAME = 'members_issued_laptop_computers';

-- has member-id column name but no fk in that name

SELECT 
    CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'beths_new_food_pantry'
    AND TABLE_NAME = 'other_support_requested_by_members';

-- no member_id FK no member-id column