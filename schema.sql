-- This SQL file creates a schema for the hospital database management system.
-- you can run this script in a MySQL environment to set up the database and tables.
-- SOURCE schema.sql;
-- or in bash: mysql -u root -p < schema.sql 


CREATE DATABASE IF NOT EXISTS hospitaldb;
USE hospitaldb;


CREATE TABLE IF NOT EXISTS Hospital (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    size_beds INT NOT NULL CHECK (size_beds > 0),
    hospital_type VARCHAR(100),
    accreditation_status VARCHAR(100)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    specialty VARCHAR(100),
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
    result_value VARCHAR(50),
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
