--   DATA IMPORT SQL SCRIPT
--   Loads all synthetic CSV data from data/ into the database

USE hospitaldb;

-- Allow local CSV loading
SET GLOBAL local_infile = 1;
SET LOCAL local_infile = 1;

-- Clean tables first
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE DiseaseSpecialist;
TRUNCATE TABLE DiseaseTreatment;
TRUNCATE TABLE LabResult;
TRUNCATE TABLE Appointment;
TRUNCATE TABLE Prescription;
TRUNCATE TABLE Patient;
TRUNCATE TABLE Doctor;
TRUNCATE TABLE Hospital;
TRUNCATE TABLE Medication;
TRUNCATE TABLE Disease;
TRUNCATE TABLE LabTest;
SET FOREIGN_KEY_CHECKS = 1;


-- Import tables with foreign key safe order
LOAD DATA LOCAL INFILE 'data/hospitals.csv'
INTO TABLE Hospital
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(hospital_id, name, address, beds, accreditation_date,
 has_emergency_department, is_teaching_hospital);


LOAD DATA LOCAL INFILE 'data/doctors.csv'
INTO TABLE Doctor
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(doctor_id, hospital_id, first_name, last_name,
 date_of_birth, address);


LOAD DATA LOCAL INFILE 'data/patients.csv'
INTO TABLE Patient
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(patient_id, doctor_id, first_name, last_name,
 date_of_birth, address, gender);


LOAD DATA LOCAL INFILE 'data/medications.csv'
INTO TABLE Medication
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(medication_id, name);


LOAD DATA LOCAL INFILE 'data/diseases.csv'
INTO TABLE Disease
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(disease_id, name, description, icd10_code);


LOAD DATA LOCAL INFILE 'data/disease_treatments.csv'
INTO TABLE DiseaseTreatment
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(disease_treatment_id, disease_id, medication_id);


LOAD DATA LOCAL INFILE 'data/disease_specialists.csv'
INTO TABLE DiseaseSpecialist
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(disease_specialist_id, disease_id, doctor_id);


LOAD DATA LOCAL INFILE 'data/lab_tests.csv'
INTO TABLE LabTest
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(lab_test_id, name, description, units,
 reference_range, sample_type);


-- Import transactional and dependent data last

LOAD DATA LOCAL INFILE 'data/prescriptions.csv'
INTO TABLE Prescription
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(prescription_id, patient_id, doctor_id, medication_id,
 prescribed_date, dose_value, dose_units, dose_instructions,
 duration_days, route);


LOAD DATA LOCAL INFILE 'data/appointments.csv'
INTO TABLE Appointment
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(appointment_id, patient_id, doctor_id, hospital_id,
 appointment_start, duration_minutes, reason, status);


LOAD DATA LOCAL INFILE 'data/lab_results.csv'
INTO TABLE LabResult
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(lab_result_id, lab_test_id, patient_id, doctor_id,
 requested_date, result_date, result_value,
 is_normal, notes);

-- Confirm completion
SELECT 'Data import completed successfully.' AS status;
