USE DocumentsDB;



DROP PROCEDURE IF EXISTS CreateOrUpdateIB;

DELIMITER //

/* Добавляем физическому лицу статус ИП */
CREATE PROCEDURE CreateOrUpdateIB(IN INN_param VARCHAR(12), IN OGRNIP_param VARCHAR(20))
BEGIN
    DECLARE person_id INT;
    DECLARE subject_id INT;
    
    -- Проверяем существование персоны с указанным ИНН
    SELECT id, subject_id INTO person_id, subject_id FROM Persons WHERE INN = INN_param;
    
    IF person_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No person found with the provided INN';
    END IF;
    
    -- Проверяем существование ИП с указанным ОГРНИП
    IF EXISTS (SELECT 1 FROM IndividualBusinessman WHERE OGRNIP = OGRNIP_param) THEN
        -- Если ИП найден, обновляем данные
        UPDATE IndividualBusinessman 
        SET 
            person_id = person_id, 
            subject_id = subject_id
        WHERE 
            OGRNIP = OGRNIP_param;
           
       SELECT name, INN, OGRNIP_or_OGRN, 'OGRNIP is updated' AS STATUS FROM allsubjects
       WHERE OGRNIP_or_OGRN = OGRNIP_param;
    ELSE
        -- Если ИП не найден, создаем новую запись
        INSERT INTO IndividualBusinessman (subject_id, person_id, OGRNIP) 
        VALUES (subject_id, person_id, OGRNIP_param);
       
	    SELECT name, INN, OGRNIP_or_OGRN, 'OGRNIP is created' AS STATUS FROM allsubjects
	    WHERE OGRNIP_or_OGRN = OGRNIP_param;
    END IF;
END;
//

DELIMITER ;




SELECT * FROM allsubjects;

-- Если такого ИНН не существует, будет исключение 45000
CALL CreateOrUpdateIB('000000000000', '1234567890122345');

SELECT * FROM allsubjects;

-- такой такого ОГРНИП не существует, ОГРНИП будет создан
CALL CreateOrUpdateIB('123456789014', '72345678901234');

-- Если такой ОГРНИП уже существует, ОГРНИП будет обновлен
CALL CreateOrUpdateIB('123456789012', '43215678901234');

