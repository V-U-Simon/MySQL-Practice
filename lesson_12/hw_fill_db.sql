USE DocumentsDB;

-- Заполнение таблицы Subject
INSERT INTO Subject (comment) VALUES 
('1. ИП: ГД'), 
('2. ФЛ: участник'), 
('3. ФЛ: ГД, участник'), 
('4. ЮЛ: участник'), 
('5. ЮЛ: ');


-- Заполнение таблицы Persons
INSERT INTO Persons (subject_id, INN, name, surname, Address) VALUES 
(1, '123456789012', 'Алексей', 'Иванов', 'Москва, ул. Ленина, 1'), 
(2, '123456789013', 'Борис', 'Петров', 'Санкт-Петербург, пр. Ветеранов, 10'), 
(3, '123456789014', 'Виктор', 'Сидоров', 'Казань, ул. Кремлевская, 15');

-- Заполнение таблицы IndividualBusinessman
INSERT INTO IndividualBusinessman (subject_id, person_id, OGRNIP) VALUES 
(1, 1, '12345678901234')

-- Заполнение таблицы Companies
INSERT INTO Companies (subject_id, name, INN, OGRN, address) VALUES 
(4, 'ООО Ромашка', '123456789017', '123456789012345', 'Москва, Кутузовский проспект, 1'), 
(5, 'ООО Барс', '123456789018', '123456789012346', 'Санкт-Петербург, Невский проспект, 10');

-- Заполнение таблицы CEO
INSERT INTO CEO (subject_id, company_id, start_date, end_date) VALUES 
(1, 1, '2020-01-01', '2025-12-31'), 
(3, 2, '2020-02-01', '2025-12-31');

-- Заполнение таблицы Participants
INSERT INTO Participants (subject_id, company_id, start_date, end_date) VALUES 
(2, 1, '2020-01-05', '2023-02-04'), 
(3, 1, '2023-02-05', NULL), 
(4, 2, '2023-03-01', '2025-12-31');

-- Заполнение таблицы DocumentTypes
INSERT INTO DocumentTypes (document_type) VALUES 
('Договор'), 
('Доверенность');

-- Заполнение таблицы Documents
INSERT INTO Documents (document_type_id, document_file_path, status, Date_created) VALUES 
(1, '/path/to/document1.doc', 'draft', '2023-09-01'), 
(1, '/path/to/document2.doc', 'approved', '2023-09-02'), 
(1, '/path/to/document3.doc', 'draft', '2023-09-03'), 
(1, '/path/to/document4.doc', 'approved', '2023-09-04'), 
(1, '/path/to/document5.doc', 'draft', '2023-09-05');

-- Заполнение таблицы DocumentsRole
INSERT INTO DocumentsRole (document_id, subject_id, Role) VALUES 
(1, 1, 'Заказчик'), 
(1, 2, 'Исполнитель'), 
(2, 1, 'Заказчик'), 
(2, 2, 'Исполнитель'),
(3, 2, 'Подрядчик'), 
(3, 4, 'Субподрядчик'),
(3, 2, 'Подрядчик'), 
(3, 5, 'Субподрядчик');


SELECT * FROM Subject;
SELECT * FROM Persons;
SELECT * FROM IndividualBusinessman;
SELECT * FROM Companies;
SELECT * FROM CEO;
SELECT * FROM Participants;
SELECT * FROM DocumentTypes;
SELECT * FROM DocumentsRole;
SELECT * FROM Documents;
