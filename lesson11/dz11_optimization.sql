-- task 1 Одновременно смотрел разбор и делал задание, поэтому все аналогично
-- как в разобранном примере, только названия свои взял.

CREATE TABLE logs (
    created_at DATETIME DEFAULT NOW(),
    table_name VARCHAR(50),
    pk_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(255)
) ENGINE=Archive;

DELIMITER &&

CREATE TRIGGER log_after_insert_to_users
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, pk_id, name)
    VALUES ('users', NEW.id, NEW.name);
END&&

CREATE TRIGGER log_after_insert_to_catalogs
AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, pk_id, name)
    VALUES ('catalogs', NEW.id, NEW.name);
END&&

CREATE TRIGGER log_after_insert_to_products
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, pk_id, name)
    VALUES ('products', NEW.id, NEW.name);
END&&
