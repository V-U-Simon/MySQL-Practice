USE DocumentsDB;


/* Получаем все одобренные договоры где ГД является лицо с определенным ИНН */
SELECT 
    d.id AS DocumentID,
    d.document_file_path AS DocumentFilePath,
    dt.document_type AS DocumentType,
    dr.`Role`,
    d.Date_created AS DateCreated,
    comp.name AS CompanyName,
    CONCAT(p.name, ' ', p.surname) AS CEO
FROM Documents d
JOIN DocumentTypes dt ON d.document_type_id = dt.id
JOIN DocumentsRole dr ON d.id = dr.document_id
JOIN CEO c ON dr.subject_id = c.subject_id
JOIN Persons p ON c.subject_id = p.subject_id
JOIN Companies comp ON c.company_id = comp.id
WHERE d.status = 'approved' AND p.INN = '123456789012';
