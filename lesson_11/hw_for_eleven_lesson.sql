/* 1. Создайте таблицу logs типа Archive.
   Пусть при каждом создании записи в таблицах 
   - users, 
   - catalogs и 
   - products 

   в таблицу logs помещаетс:
   - время и дата создания записи, 
   - название таблицы, 
   - идентификатор первичного ключа и 
   - содержимое поля name.*/

USE shop;

/* таблица логироваия */
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id SERIAL,
    created_at DATETIME NOT NULL,
    nametable VARCHAR(50) NOT NULL,
    row_id BIGINT NOT NULL,
    row_name VARCHAR(50) NOT NULL
) ENGINE = ARCHIVE;
DROP TRIGGER IF EXISTS user_trigger;


/* триггер для логирования вставки пользователей */
DROP TRIGGER IF EXISTS LogInsertUsers;
DELIMITER //
CREATE TRIGGER LogInsertUsers
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs
        (created_at, nametable, row_id, row_name)
    VALUES
        (NOW(), 'users', NEW.id, NEW.name);
END;
//

DELIMITER ;

/* триггер для логирования вставки катологов продуктов */
DROP TRIGGER IF EXISTS LogInsertCatalogs;
DELIMITER //
CREATE TRIGGER LogInsertCatalogs
AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs
        (created_at, nametable, row_id, row_name)
    VALUES
        (NOW(), 'users', NEW.id, NEW.name);
END;
//
DELIMITER ;

/* триггер для логирования вставки продуктов */
DROP TRIGGER IF EXISTS LogInsertProducts;
DELIMITER //
CREATE TRIGGER LogInsertProducts
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs
        (created_at, nametable, row_id, row_name)
    VALUES
        (NOW(), 'users', NEW.id, NEW.name);
END;
//
DELIMITER ;

/* пример использования */
SELECT * FROM logs;

INSERT INTO users (name) VALUES ('mike'), ('joe');
INSERT INTO catalogs (name) VALUES ('catalog_1'), ('catalog_2');
INSERT INTO products (name) VALUES ('ptoduct_1'), ('product_2');

SELECT * FROM logs;




/* 2. Создайте SQL-запрос, который помещает в таблицу users миллион записей. */
USE shop;


DROP PROCEDURE IF EXISTS InsertMillionUsers;

DELIMITER //

CREATE PROCEDURE InsertMillionUsers()
BEGIN
    DECLARE i INT DEFAULT 0;

    START TRANSACTION;
    WHILE i < 1000000 DO 
        INSERT INTO users (name) VALUES (CONCAT('User', i));
        SET i = i + 1;
    END WHILE;
    COMMIT;
END;
//

DELIMITER ;


SELECT COUNT(*) FROM users;

CALL InsertMillionUsers;

SELECT COUNT(*) FROM users;