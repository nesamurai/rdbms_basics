-- task 1
DELIMITER &&

CREATE FUNCTION hello ()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE greeting VARCHAR(255);
    DECLARE time_of_day DATETIME;
    SET time_of_day = HOUR(NOW());

    IF(time_of_day > 18) THEN
        SET greeting = 'Good evening!';
    ELSE IF(time_of_day > 12) THEN
        SET greeting = 'Good afternoon!';
    ELSE IF(time_of_day > 6) THEN
        SET greeting = 'Good morning!';
    ELSE IF(time_of_day > 0) THEN
        SET greeting = 'Good night!';
    END IF;
    RETURN greeting;
END&&

SELECT hello()&&


-- task 2
CREATE TRIGGER check_name_or_descript_filled
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
BEGIN
    IF (NEW.name IS NULL AND NEW.description IS NULL)
        OR (OLD.name IS NULL AND OLD.description IS NULL) THEN
        SIGNAL SQLSTATE '55555' SET message_text = 'Both values cannot be NULL';
    END IF;
END&&


-- task 3
CREATE FUNCTION fibonacci (num INT)
RETURNS INT DETERMINISTIC
BEGIN
    IF num = 0 THEN
        RETURN 0;
    ELSEIF num = 1 THEN
        RETURN 1;
    ELSE
        RETURN (SELECT fibonacci(num - 1) + fibonacci(num - 2));
    END IF;
END&&

SELECT fibonacci(10)&&
-- ERROR 1424 (HY000): Recursive stored functions and triggers are not allowed.
