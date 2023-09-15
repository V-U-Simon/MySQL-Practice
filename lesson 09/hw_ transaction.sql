/* 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
 Используйте транзакции. */
INSERT INTO sample.users (name)
    SELECT name
    FROM shop.users
    WHERE id = 1;
    
SELECT * FROM sample.users;



/* 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
и соответствующее название каталога name из таблицы catalogs. */

CREATE OR REPLACE VIEW name_product_catalog AS
	SELECT p.name AS product_name, c.name AS catalog_name 
	FROM products p, catalogs c
	WHERE p.catalog_id = c.id;

SELECT * FROM name_product_catalog;