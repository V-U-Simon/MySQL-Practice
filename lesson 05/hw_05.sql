-- Как основную баду используем предоставленную на уроке
-- vk_db_seed.sql
USE vk;

-- Task 1
-- Пусть в таблице users поля created_at и updated_at 
-- оказались незаполненными. 
-- Заполните их текущими датой и временем.
-- добавим недостоющие столцы
-- и сразу заполним их текущей датой и временем
ALTER TABLE
     users
ADD
     COLUMN created_at DATETIME DEFAULT NOW(),
ADD
     COLUMN updated_at DATETIME DEFAULT NOW();

-- альтернативный вариант
-- ALTER TABLE users ADD COLUMN (
-- created_at DATETIME DEFAULT NOW(),
-- ubpdated_at DATETIME DEFAULT NOW()
-- );
-- Task 2
-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
-- Приводим к условию задачи (created_at и updated_at должны быть VARCHAR)
ALTER TABLE
     users
MODIFY
     COLUMN created_at VARCHAR(255),
MODIFY
     COLUMN updated_at VARCHAR(255);

UPDATE
     USERS
SET
     created_at = '20.10.2017 8:10',
     updated_at = '20.10.2017 8:10';

-- РЕШЕНИЕ, перед записью проверяем на select
select
     created_at,
     STR_TO_DATE(created_at, '%d.%m.%Y %H:%i') -- STR_TO_DATE('20.10.2017 8:10', '%d.%m.%Y %H:%i')
from
     users;

-- Преобразуем данные к перевариваемому формату DATETIME
UPDATE
     USERS
SET
     created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
     updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

-- Преобразовать поля к в колонках к типу DATETIME
ALTER TABLE
     users
MODIFY
     COLUMN created_at DATETIME,
MODIFY
     COLUMN updated_at DATETIME;

SELECT
     *
FROM
     users;

-- Task 3
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако нулевые запасы должны выводиться в конце, после всех записей.
-- Создание таблицы для последующейго решения
DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE storehouses_products(
     id SERIAL PRIMARY KEY,
     `value` INT(10) UNSIGNED NOT NULL,
     product VARCHAR(150)
);

-- Рандомные данные
INSERT
     storehouses_products (`value`, product)
VALUES
     (123, 'product_1'),
     (112, 'product_2'),
     (17, 'product_3'),
     (80, 'product_4'),
     (0, 'product_5'),
     (0, 'product_6');

-- Решение - сортируем 
SELECT
     `value`
FROM
     storehouses_products
ORDER BY
     IF(`value` = 0, 1, 0),
     `value`;

-- Task 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, 
-- родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий (may, august)
SELECT
     user_id,
     (
          SELECT
               CONCAT(firstname, ' ', lastname)
          FROM
               users
          WHERE
               id = profile.user_id
     ) AS user,
     DATE_FORMAT(birthday, '%M') AS birth_month
FROM
     profile
WHERE
     MONTH(birthday) IN(5, 8);

-- Task 5
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
-- Подготовка к решению задачи
DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (id INT(10));

INSERT
     catalogs
VALUES
     (1),
     (2),
     (5);

-- РЕШЕНИЕ
SELECT
     *
FROM
     catalogs
WHERE
     id IN (5, 1, 2)
ORDER BY
     FIELD(id, 5, 1, 2);

-- Task 1
-- Подсчитайте средний возраст пользователей в таблице users.
SELECT
     ROUND(
          AVG(
               (
                    SELECT
                         TIMESTAMPDIFF(YEAR, birthday, NOW())
                    FROM
                         profile
                    WHERE
                         user_id = users.id
               )
          ),
          2
     ) AS Average_age
FROM
     users;

-- Task 2
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT
     COUNT(*),
     (
          SELECT
               DATE_FORMAT(DATE_FORMAT(birthday, '2022-%m-%d'), '%W')
          FROM
               profile
          WHERE
               user_id = users.id
     ) AS week_day
FROM
     users
GROUP BY
     week_day WITH ROLLUP;

-- Task 3
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы.
DROP TABLE IF EXISTS multiply;

CREATE TABLE multiply (id SERIAL PRIMARY KEY, num INT(10));

INSERT
     multiply (num)
VALUES
     (1),
     (2),
     (3),
     (4),
     (5);

SELECT
     exp(sum(ln(num)))
FROM
     multiply;