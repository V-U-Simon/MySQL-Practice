/* 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
   Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
   второму пользователю shop — любые операции в пределах базы данных shop. */

use shop;

CREATE USER 'shop_read'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'shop_any'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT PRIVILEGES ON shop.* TO 'shop_read'@'localhost';
GRANT ALL PRIVILEGES ON shop.* TO 'shop_any'@'localhost';

FLUSH PRIVILEGES; 


/* 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца:
   - id (первичный ключ)
   - name (имя пользователя)
   - password (его пароль)
Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name.
Создайте пользователя user_read, который бы не имел доступа к таблице accounts, 
однако, мог бы извлекать записи из представления username. */


USE shop;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    password VARCHAR(100)
);

CREATE OR REPLACE VIEW username AS
	SELECT id, name FROM accounts;

	

CREATE USER 'user_read'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT PRIVILEGES ON shop.username TO 'user'@'localhost';
