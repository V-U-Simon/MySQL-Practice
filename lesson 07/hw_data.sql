-- Тут создание таблиц и внесение данных для решения задач
-- РЕШЕНИЕ ДЗ находится ниже
DROP DATABASE IF EXISTS db_for_homework7;

CREATE DATABASE db_for_homework7;

USE db_for_homework7;

DROP TABLE IF EXISTS db_for_homework7.users;

CREATE TABLE db_for_homework7.users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS db_for_homework7.orders;

CREATE TABLE db_for_homework7.orders (
    id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users (id) ON DELETE
    SET
        NULL ON UPDATE CASCADE,
        product VARCHAR(100)
);

INSERT INTO
    users (name, birthday_at)
VALUES
    ('Геннадий', '1990-10-05'),
    ('Наталья', '1984-11-12'),
    ('Александр', '1985-05-20'),
    ('Сергей', '1988-02-14'),
    ('Иван', '1998-01-12'),
    ('Мария', '1992-08-29');

INSERT
    orders (user_id, product)
VALUES
    (1, 'стикер 1'),
    (1, 'стикер 2'),
    (2, 'стикер 3'),
    (5, 'стикер 4'),
    (3, 'стикер 5'),
    (7, 'стикер 6');

DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO
    catalogs
VALUES
    (NULL, 'Процессоры'),
    (NULL, 'Материнские платы'),
    (NULL, 'Видеокарты'),
    (NULL, 'Жесткие диски'),
    (NULL, 'Оперативная память');

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    `desription` TEXT COMMENT 'Описание',
    price DECIMAL (11, 2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO
    products (name, `desription`, price, catalog_id)
VALUES
    (
        'Intel Core i3-8100',
        'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
        7890.00,
        1
    ),
    (
        'Intel Core i5-7400',
        'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
        12700.00,
        1
    ),
    (
        'AMD FX-8320E',
        'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',
        4780.00,
        1
    ),
    (
        'AMD FX-8320',
        'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',
        7120.00,
        1
    ),
    (
        'ASUS ROG MAXIMUS X HERO',
        'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
        19310.00,
        2
    ),
    (
        'Gigabyte H310M S2H',
        'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
        4790.00,
        2
    ),
    (
        'MSI B250M GAMING PRO',
        'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',
        5060.00,
        2
    );

DROP TABLE IF EXISTS db_for_homework7.flights;

CREATE TABLE db_for_homework7.flights (
    id SERIAL PRIMARY KEY,
    `from` VARCHAR(255),
    `to` VARCHAR(255)
);

DROP TABLE IF EXISTS db_for_homework7.cities;

CREATE TABLE db_for_homework7.cities (`label` VARCHAR(255), `name` VARCHAR(255));

INSERT
    flights (`from`, `to`)
VALUES
    ('moscow', 'omsk'),
    ('novgorod', 'kazan'),
    ('irkutsk', 'moskow'),
    ('omsk', 'irkutsk'),
    ('moscow', 'kazan');

INSERT
    cities (label, `name`)
VALUES
    ('moscow', 'Москва'),
    ('irkutsk', 'Иркутск'),
    ('novgorod', 'Новгород'),
    ('kazan', 'Казань'),
    ('omsk', 'Омск');