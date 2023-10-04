USE DocumentsDB;

DELIMITER //
/* при создании физ.лица создаем сущность субъекта */
CREATE TRIGGER BeforePersonInsert
BEFORE INSERT ON Persons
FOR EACH ROW
BEGIN
    INSERT INTO Subject (comment) VALUES (NULL);
    SET NEW.subject_id = LAST_INSERT_ID();
END;
//

/* при создании юр.лица создаем сущность субъекта */
CREATE TRIGGER BeforeCompanyInsert
BEFORE INSERT ON Companies
FOR EACH ROW
BEGIN
    INSERT INTO Subject (comment) VALUES (NULL);
    SET NEW.subject_id = LAST_INSERT_ID();
END;
//

DELIMITER ;


SELECT COUNT(*) FROM Subject;

-- Заполнение таблицы Persons
INSERT INTO Persons (INN, name, surname, Address) VALUES 
('123456789015', 'Дмитрий', 'Смирнов', 'Новосибирск, ул. Советская, 3'), 
('123456789016', 'Евгений', 'Волков', 'Екатеринбург, ул. Ленина, 20'), 
('123456789019', 'Анна', 'Соколова', 'Краснодар, ул. Ставропольская, 33');

-- Заполнение таблицы Companies
INSERT INTO Companies (name, INN, OGRN, address) VALUES 
('ООО Лилия', '123456789021', '123456789012347', 'Нижний Новгород, проспект Гагарина, 11'), 
('ООО Тигр', '123456789022', '123456789012348', 'Ростов-на-Дону, ул. Большая Садовая, 5');

SELECT COUNT(*) FROM Subject;
