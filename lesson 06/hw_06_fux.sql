-- Как основную баду используем предоставленную на уроке
-- vk_db_seed.sql
USE vk;

-- Task 1
-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя 
-- найдите человека, который больше всех общался с нашим пользователем.  
-- решение через селект
SELECT
	count(*) AS cnt,
	from_user_id,
	to_user_id
FROM
	messages
WHERE
	to_user_id = 1
GROUP BY
	from_user_id
ORDER BY
	cnt DESC
LIMIT
	1;

-- Task 2
-- Подсчитать общее количество лайков, 
-- которые получили пользователи младше 11 лет.
-- через селект
SELECT
	count(*) as 'количество лайков'
from
	likes
where
	user_id IN (
		SELECT
			user_id
		from
			profiles
		WHERE
			TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10
	);

-- Task 3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
-- через селект
SELECT
	(
		SELECT
			gender
		FROM
			profiles p
		WHERE
			p.user_id = l.user_id
	) AS gender,
	COUNT(*)
FROM
	likes l -- лайки
GROUP BY
	gender;