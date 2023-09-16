USE DocumentsDB;


-- все субъекты
CREATE OR REPLACE VIEW AllSubjects AS
	SELECT 
		s.id,
		CONCAT(p.name, ' ', p.surname) AS Name,
		p.INN, 
		ib.OGRNIP AS OGRNIP_or_OGRN,
		p.Address 
	FROM Persons p
	JOIN Subject s ON p.subject_id = s.id
	LEFT JOIN IndividualBusinessman ib ON p.id = ib.person_id
	UNION
	SELECT
		s.id,
		c.name AS Name,
		c.INN, 
		c.OGRN AS OGRNIP_or_OGRN,
		c.Address 
	FROM Subject s
	JOIN Companies c ON s.id = c.subject_id
	ORDER BY id;
	


-- действующие на сегодня CEO
CREATE OR REPLACE VIEW CurrentCEOs AS
	SELECT 
	    CEO.id AS CEO_id, 
	    s.Name AS CEO_Name, 
	    c.name AS Company_Name,
	    CEO.start_date AS Start_Date, 
	    CEO.end_date AS End_Date
	FROM CEO
	JOIN AllSubjects s ON CEO.subject_id = s.id
	JOIN Companies c ON CEO.company_id = c.id
	WHERE CURDATE() BETWEEN CEO.start_date AND COALESCE(CEO.end_date, '9999-12-31');


-- действующие на сегодня CEO
CREATE OR REPLACE VIEW AllCEOs AS
	SELECT 
	    CEO.id AS CEO_id, 
	    s.Name AS CEO_Name, 
	    c.name AS Company_Name,
	    CEO.start_date AS Start_Date, 
	    CEO.end_date AS End_Date
	FROM CEO
	JOIN AllSubjects s ON CEO.subject_id = s.id
	JOIN Companies c ON CEO.company_id = c.id;


-- действующие на сегодня участники
CREATE OR REPLACE VIEW CurrentParticipants AS
SELECT 
    Participants.id AS Participant_id, 
    ASUB.Name AS Participant_Name, 
    Companies.name AS Company_Name,
    Participants.start_date AS Start_Date, 
    Participants.end_date AS End_Date
FROM Participants
JOIN AllSubjects AS ASUB ON Participants.subject_id = ASUB.id
JOIN Companies ON Participants.company_id = Companies.id
WHERE CURDATE() BETWEEN Participants.start_date AND COALESCE(Participants.end_date, '9999-12-31');


-- все участники
CREATE OR REPLACE VIEW AllParticipants AS
SELECT 
    Participants.id AS Participant_id, 
    ASUB.Name AS Participant_Name, 
    Companies.name AS Company_Name,
    Participants.start_date AS Start_Date, 
    Participants.end_date AS End_Date
FROM Participants
JOIN AllSubjects AS ASUB ON Participants.subject_id = ASUB.id
JOIN Companies ON Participants.company_id = Companies.id;



SELECT * FROM AllSubjects;

SELECT * FROM CurrentCEOs;

SELECT * FROM AllCEOs;

SELECT * FROM CurrentParticipants;

SELECT * FROM AllParticipants;
