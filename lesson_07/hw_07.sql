-- Task 1
-- Составьте список пользователей users, 
-- которые осуществили хотя бы один заказ orders в интернет магазине.
select
  u.id,
  u.name
from
  users as u
  join orders as o on u.id = o.id;

-- Task 2
-- Выведите список товаров products и разделов catalogs, 
-- который соответствует товару.
SELECT
  c.name,
  p.name
from
  products AS p
  join catalogs AS c on p.catalog_id = c.id;

-- еще один вариант
SELECT
  products.name,
  (
    select
      catalogs.name
    from
      catalogs
    where
      products.catalog_id = catalogs.id
  )
from
  products;

-- Task 3
-- (по желанию) Пусть имеется 
-- таблица рейсов flights (id, from, to) и 
-- таблица городов cities (label, name). 
-- 
-- Поля from, to и label содержат английские названия городов, 
-- поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
select
  *
from
  flights;

select
  *
from
  cities;

-- c update названия городов заменились без проблем
update
  flights
  join cities as c_1 on flights.from = c_1.label
  join cities as c_2 on flights.to = c_2.label
set
  flights.from = c_1.name,
  flights.to = c_2.name;

select
  *
from
  flights;

-- вывод с русскоязычным названием
-- с select названия городов отображаются в неверном порядке
-- не оч понимаю почему так
-- с указанием отдельных имен
-- пробовал с where, но с ним вообще не работает(((
select
  *
from
  flights
  join cities as c_1 on flights.from = c_1.label
  join cities as c_2 on flights.to = c_2.label;