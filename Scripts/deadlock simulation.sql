-- DEADLOCK

-- LOCK THE ROW
START TRANSACTION;

SELECT * 
FROM members_address_testing 
ORDER BY address_id DESC 
LIMIT 1 
FOR UPDATE;


-- UNLOCK THE ROW

COMMIT;



-- 1‑session deadlock that DOES work
START TRANSACTION;

SELECT *
FROM members_address_testing
ORDER BY address_id DESC
LIMIT 1
FOR UPDATE;

SAVEPOINT sp1;

SELECT *
FROM members_address_testing
ORDER BY address_id DESC
LIMIT 1
FOR UPDATE;


ROLLBACK;
UNLOCK TABLES;

-- 1‑session method that reliably triggers retry‑exhaustion (45000)
START TRANSACTION;

-- Acquire a metadata lock
ALTER TABLE members_address_testing COMMENT = 'locktest';








