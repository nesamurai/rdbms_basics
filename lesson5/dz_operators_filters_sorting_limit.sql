-- task 1
UPDATE users
SET created_at = NOW() AND updated_at = NOW();


-- task 2
UPDATE users
SET created_at=STR_TO_DATE(created_at, "%d.%m.%Y %k:%i")
WHERE created_at IS NOT NULL;

UPDATE users
SET updated_at=STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i")
WHERE updated_at IS NOT NULL;

ALTER TABLE users
MODIFY COLUMN created_at DATETIME;
-- or
-- ALTER TABLE users CHANGE created_at created_at DATETIME;

ALTER TABLE users
MODIFY COLUMN updated_at DATETIME;
-- or
-- ALTER TABLE users CHANGE updated_at updated_at DATETIME;


-- task 3
SELECT * FROM storehouse_products
ORDER BY CASE WHEN value = 0 THEN 2 ELSE 1 END, value;


-- task 4
SELECT * FROM users
WHERE LCASE(MONTHNAME(birthday_at)) IN ('may', 'august');


-- task 5
SELECT * FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY (CASE id
        WHEN 5 THEN 1
        WHEN 1 THEN 2
        WHEN 2 THEN 3
        END);
