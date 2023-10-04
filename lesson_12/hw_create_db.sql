DROP DATABASE IF EXISTS DocumentsDB;
CREATE DATABASE DocumentsDB;

USE DocumentsDB;

/* созадние базы данных */	
CREATE TABLE Subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment VARCHAR(255)
    
);

CREATE TABLE Persons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT UNIQUE,
    INN VARCHAR(50) UNIQUE,
    name VARCHAR(100),
    surname VARCHAR(100),
    Address VARCHAR(255),
    FOREIGN KEY (subject_id) REFERENCES Subject(id)
);

CREATE TABLE IndividualBusinessman (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT UNIQUE,
    person_id INT,
    OGRNIP VARCHAR(50) UNIQUE,
    FOREIGN KEY (subject_id) REFERENCES Subject(id),
    FOREIGN KEY (person_id) REFERENCES Persons(id)
);

CREATE TABLE Companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT UNIQUE,
    name VARCHAR(100),
    INN VARCHAR(50) UNIQUE,
    OGRN VARCHAR(50) UNIQUE,
    address VARCHAR(255),
    FOREIGN KEY (subject_id) REFERENCES Subject(id)
);

CREATE TABLE CEO (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT,
    company_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (subject_id) REFERENCES Subject(id),
    FOREIGN KEY (company_id) REFERENCES Companies(id)
);

CREATE TABLE Participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT,
    company_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (subject_id) REFERENCES Subject(id),
    FOREIGN KEY (company_id) REFERENCES Companies(id)
);

CREATE TABLE DocumentTypes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    document_type VARCHAR(50)
);

CREATE TABLE Documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    document_type_id INT,
    document_file_path VARCHAR(255),
    status ENUM('draft', 'approved'),
    Date_created DATE,
    FOREIGN KEY (document_type_id) REFERENCES DocumentTypes(id)
);

CREATE TABLE DocumentsRole (
    id INT AUTO_INCREMENT PRIMARY KEY,
    document_id INT,
    subject_id INT,
    Role VARCHAR(50),
    FOREIGN KEY (document_id) REFERENCES Documents(id),
    FOREIGN KEY (subject_id) REFERENCES Subject(id)
);

