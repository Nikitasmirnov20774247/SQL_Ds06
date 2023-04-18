DROP DATABASE IF EXISTS sql_ds06;
CREATE DATABASE IF NOT EXISTS sql_ds06;
USE sql_ds06;

# 1. Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS time_conversion;
DELIMITER $$
CREATE FUNCTION time_conversion(seconds INT)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    DECLARE days INT default 0;
    DECLARE hours INT default 0;
    DECLARE minutes INT default 0;
    DECLARE result VARCHAR(45);

    WHILE seconds >= 86400 DO
		SET days = seconds / 86400;
		SET seconds = seconds % 86400;
    END WHILE;

    WHILE seconds >= 3600 DO
		SET hours = seconds / 3600;
		SET seconds = seconds % 3600;
    END WHILE;

    WHILE seconds >= 60 DO
		SET minutes = seconds / 60;
		SET seconds = seconds % 60;
    END WHILE;
	SET result = concat(days, ' days, ', hours, ' hours, ', minutes, ' minutes, ', seconds, ' seconds ');
	
    RETURN result;
END $$
DELIMITER ;
SELECT time_conversion(536354);

# 2. Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)

DROP PROCEDURE IF EXISTS get_numbers;
DELIMITER $$
CREATE PROCEDURE get_numbers()
BEGIN
    DECLARE n INT default 0;
    DROP TABLE IF EXISTS numbers;
    CREATE TABLE numbers (even_numbers INT);

    WHILE n < 10 DO
		SET n = n + 2;
		INSERT INTO numbers VALUES(n);
    END WHILE;

	SELECT * 
	FROM numbers;
END $$
DELIMITER ;
CALL get_numbers();