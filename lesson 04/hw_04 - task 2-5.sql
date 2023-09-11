-- Практическое задание по теме “CRUD - операции”
USE vk;

-- task 2
-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.
SELECT
     DISTINCT firstname
FROM
     users
ORDER BY
     -- сортировка по возратанию (ASC) по умолчанию
     firstname ASC;

-- task 3
-- Первые пять пользователей пометить как удаленные.
ALTER TABLE
     users
ADD
     COLUMN is_deleted ENUM('true', 'false') DEFAULT 'false';

UPDATE
     users
SET
     is_deleted = TRUE
ORDER BY
     id
LIMIT
     5;

-- check that first five users is marked like deleted
SELECT
     firstname,
     is_deleted
FROM
     users
LIMIT
     5;

-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).
-- add few items with date from future
UPDATE
     messages
SET
     created_at = STR_TO_DATE('2030-05-20 22:10:19', '%Y-%m-%d %H:%i:%s')
WHERE
     id IN (5, 6, 7, 8, 9);

-- delete futere massages
DELETE FROM
     messages
WHERE
     created_at > NOW();

-- check that future masseges is deleted
SELECT
     *
FROM
     messages
WHERE
     created_at > NOW();

--task 4
-- Написать название темы курсового проекта.
-- Тема курсовой:
-- система подготовки и согласования документов (корпоративное право)