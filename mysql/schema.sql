-- This SQL file creates a schema for the hospital database management system.
-- you can run this script in a MySQL environment to set up the database and tables.
-- SOURCE schema.sql;
-- or in bash: mysql -u root -p < schema.sql 


CREATE DATABASE IF NOT EXISTS hospitaldb;
USE hospitaldb;


-- Drop tables if re-running
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS LabResult;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS DiseaseSpecialist;
DROP TABLE IF EXISTS DiseaseTreatment;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Hospital;
DROP TABLE IF EXISTS Medication;
DROP TABLE IF EXISTS Disease;
DROP TABLE IF EXISTS LabTest;

SET FOREIGN_KEY_CHECKS = 1;

-- Create the tables

CREATE TABLE IF NOT EXISTS Hospital (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    beds INT NOT NULL CHECK (beds > 0),
    accreditation_date DATE NOT NULL,
    has_emergency_department BOOLEAN NOT NULL,
    is_teaching_hospital BOOLEAN NOT NULL
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    FOREIGN KEY (hospital_id)
        REFERENCES Hospital(hospital_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    FOREIGN KEY (doctor_id)
        REFERENCES Doctor(doctor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication_id INT NOT NULL,
    prescribed_date DATE NOT NULL,
    dose_value INT,
    dose_units VARCHAR(50),
    dose_instructions VARCHAR(255),
    duration_days INT,
    route VARCHAR(150) NOT NULL,

    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctor(doctor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (medication_id)
        REFERENCES Medication(medication_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS Disease (
    disease_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,
    icd10_code VARCHAR(10)
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS DiseaseTreatment (
    disease_treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_id INT NOT NULL,
    medication_id INT NOT NULL,

    FOREIGN KEY (disease_id)
        REFERENCES Disease(disease_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (medication_id)
        REFERENCES Medication(medication_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE (disease_id, medication_id)
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS DiseaseSpecialist (
    disease_specialist_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_id INT NOT NULL,
    doctor_id INT NOT NULL,

    FOREIGN KEY (disease_id)
        REFERENCES Disease(disease_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctor(doctor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE (disease_id, doctor_id)
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    hospital_id INT NOT NULL,
    appointment_start DATETIME NOT NULL,
    duration_minutes INT NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50),

    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctor(doctor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (hospital_id)
        REFERENCES Hospital(hospital_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS LabTest (
    lab_test_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,
    units VARCHAR(20),
    reference_range VARCHAR(50),
    sample_type VARCHAR(50)
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS LabResult (
    lab_result_id INT AUTO_INCREMENT PRIMARY KEY,
    lab_test_id INT NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    requested_date DATE NOT NULL,
    result_date DATE,
    result_value VARCHAR(150),
    is_normal BOOLEAN,
    notes TEXT,

    FOREIGN KEY (lab_test_id)
        REFERENCES LabTest(lab_test_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctor(doctor_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- query for doctor with the most prescriptions

SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    COUNT(p.prescription_id) AS total_prescriptions
FROM doctor AS d
LEFT JOIN prescription AS p
    ON p.doctor_id = d.doctor_id
GROUP BY 
    d.doctor_id,
    d.first_name,
    d.last_name
ORDER BY 
    total_prescriptions DESC
LIMIT 1;



-- use this query to fetch doctors at the hospital with the largest number of beds

SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    h.name AS hospital_name,
    h.beds
FROM doctor AS d
JOIN hospital AS h
    ON d.hospital_id = h.hospital_id
WHERE h.beds = (
    SELECT MAX(beds)
    FROM hospital
);



-- this query prints hospitals accredited before 2015 that have an emergency department

SELECT 
    name AS hospital_name
FROM hospital
WHERE accreditation_date < '2015-01-01'
  AND has_emergency_department = 1;


-- this query returns patients whose doctors work at hospitals with fewer than 400 beds.

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    d.doctor_id,
    d.first_name  AS doctor_first_name,
    d.last_name   AS doctor_last_name,
    h.name        AS hospital_name,
    h.beds
FROM patient  AS p
JOIN doctor   AS d ON p.doctor_id   = d.doctor_id
JOIN hospital AS h ON d.hospital_id = h.hospital_id
WHERE h.beds < 400;




-- this query prints all lab results from hospitals accredited between 2013&2020
 

SELECT 
    lr.*,
    h.name AS hospital_name,
    h.accreditation_date
FROM labresult AS lr
JOIN doctor AS d ON lr.doctor_id = d.doctor_id
JOIN hospital AS h ON d.hospital_id = h.hospital_id
WHERE h.accreditation_date BETWEEN '2013-01-01' AND '2020-12-31';

