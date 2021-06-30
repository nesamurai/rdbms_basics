-- task 1
START TRANSACTION;

SELECT @everything := * FROM shop.users
WHERE id = 1;

INSERT INTO sample.users
VALUES (@everything);

DELETE FROM shop.users
WHERE id = 1;

COMMIT;


-- task 2
CREATE VIEW product_with_catalog (product_name, catalog_name)
AS SELECT p.name, c.name FROM products p
    JOIN catalogs c ON p.catalog_id = c.id;


-- task 4
START TRANSACTION;
DELETE FROM tbl
WHERE created_at NOT IN (
    SELECT created_at FROM (
        SELECT created_at FROM tbl
        ORDER BY created_at DESC
        LIMIT 5) AS five_newest
    );
COMMIT;
