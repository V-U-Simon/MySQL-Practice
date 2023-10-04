-- Практическое задание по теме “Введение в проектирование БД”
-- Написать cкрипт, добавляющий в БД vk, которую создали на 3 вебинаре, 3-4 новые таблицы (с перечнем полей, указанием индексов и внешних ключей).
-- (по желанию: организовать все связи 1-1, 1-М, М-М)
USE vk;

DROP TABLE IF EXISTS folder;

DROP TABLE if EXISTS music_genre;

DROP TABLE IF EXISTS music;

DROP TABLE IF EXISTS genre;

DROP TABLE if EXISTS watched;

DROP TABLE IF EXISTS video;

-- связь 1-1 (бинарный файл - видео)
-- предпологается, что в медиа лежит бинарный файл
-- одному бинарнику(media), соответствует одина запись в видео
CREATE TABLE video (
	media_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	raiting ENUM('1', '2', '3', '4', '5'),
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE on DELETE CASCADE
);

-- связь 1-1 (колличество просмотров - "расширение" таблицы видео)
CREATE Table watched (
	video_id serial PRIMARY KEY,
	`count` BIGINT UNSIGNED,
	FOREIGN KEY (video_id) REFERENCES video(media_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- связь 1-1 (бинарный файл - песня)
-- предпологается, что в медиа лежит бинарный файл
-- одному бинарнику(media), соответствует одина запись песни
-- связь М-М (1 песня - несколько жанров + 1 жанр - несколько песен)
CREATE TABLE music (
	media_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	-- в формате enum (1, 2, 3, 4, 5) - не завелось
	raiting ENUM('1', '2', '3', '4', '5'),
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- связь М-М (1 песня - несколько жанров + 1 жанр - несколько песен)
create table genre (id serial PRIMARY KEY, `name` VARCHAR (40));

-- Промежуточная таблица для связи
create table music_genre (
	id serial PRIMARY KEY,
	genre_id BIGINT UNSIGNED NOT NULL,
	music_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (genre_id) REFERENCES genre(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (music_id) REFERENCES music(media_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- связь 1-M (множество файлов - папка)
-- связь 1-M (папка - множество папок)
CREATE Table folder (
	id serial PRIMARY KEY,
	path_name VARCHAR(255) NOT NULL COMMENT 'имя папки (часть пути)',
	media_id BIGINT UNSIGNED NOT NULL COMMENT 'ссылка на файл',
	nested_folder BIGINT UNSIGNED COMMENT 'ссылка на родительскую папку, если такая есть',
	FOREIGN KEY (nested_folder) REFERENCES folder(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);