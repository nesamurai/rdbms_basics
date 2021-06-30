-- task 1
CREATE USER shop_read IDENTIFIED BY 'select';
GRANT SELECT ON shop.* TO shop_read;

CREATE USER shop_user_2 IDENTIFIED BY 'crud';
GRANT ALL ON shop.* TO shop_user_2;


-- task 2
CREATE VIEW username AS
SELECT id, name FROM accounts;

CREATE USER user_read IDENTIFIED BY 'noaccounts';
GRANT SELECT ON *.username TO user_read;
