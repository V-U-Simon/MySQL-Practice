-- Как основную баду используем предоставленную на уроке
-- vk_db_seed.sql
USE vk;


-- Task 1
-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя 
-- найдите человека, который больше всех общался с нашим пользователем.  
-- через джойн
select 
	IF(u1.id = 1,
	   u2.id,
	   u1.id) AS people_id,
   COUNT(*) AS total_messages
from messages m
join users u1 on (u1.id = from_user_id)
join users u2 on (u2.id = to_user_id)
JOIN friend_requests fr ON 
	(fr.initiator_user_id = m.from_user_id AND fr.target_user_id = m.to_user_id) OR 
	(fr.initiator_user_id = m.to_user_id AND fr.target_user_id = m.from_user_id)
WHERE fr.status = 'approved'
GROUP BY people_id
ORDER BY people_id DESC;


-- Task 2
-- Подсчитать общее количество лайков, 
-- которые получили пользователи младше 11 лет.
-- через джойн
SELECT 
	count(*)
FROM likes l -- лайки
JOIN media m ON l.media_id = m.id -- для определения владельца медиа
JOIN profiles p ON m.user_id = p.user_id -- добавляем дату рождения
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 11


-- Task 3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
-- через джойн
SELECT 
	p.gender,
	count(*)
FROM likes l -- лайки
JOIN profiles p ON l.user_id = p.user_id -- добавляем пользователей
GROUP BY gender

