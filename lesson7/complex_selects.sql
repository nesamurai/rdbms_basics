-- task 1
SELECT u.name, COUNT(o.id) AS amount_orders FROM users u, orders o
WHERE u.id = o.user_id
GROUP BY u.name
HAVING amount_orders >= 1;

-- task 2
SELECT prd.name, ctlg.name FROM products prd, catalogs ctlg
WHERE prd.catalog_id = ctlg.id;

-- task 3
SELECT id,
(SELECT name FROM cities WHERE label = `from`) AS otkuda,
(SELECT name FROM cities WHERE label = `to`) AS kuda
FROM flights;
