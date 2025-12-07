-- 1. Print a list of all doctors as a particular hospital

SELECT d.doctor_id, d.first_name, d.last_name
    FROM doctor d
    JOIN hospital h ON d.hospital_id = h.hospital_id
    WHERE h.hospital_id = 2;

-- 2. Print a list of all prescriptions for a particular patient, ordered by the prescription date.

SELECT *
    FROM prescription
    WHERE patient_id = 101
    ORDER BY prescribed_date ASC;

-- 3. Print a list of all prescriptions that a particular doctor has prescribed

SELECT *
    FROM prescription
    WHERE doctor_id = 58
    ORDER BY prescription_id ASC;


-- 4. Print a table showing all prescriptions ordered by the patient’s name alphabetically 

SELECT *
    FROM prescription pr
    JOIN patient p ON pr.patient_id=p.patient_id
    JOIN medication m ON pr.medication_id=m.medication_id
    ORDER BY 
    p.last_name ASC,
    p.first_name ASC;

-- 5. Add a new customer to the database, including being registered with one of the doctors

INSERT INTO patient (patient_id, doctor_id, first_name, last_name, date_of_birth, address, gender)
VALUES
    (602, 10, 'John', 'Walker', '1988-03-12', '12 Marine Road, Exeter, EX21AB', 'Male');


-- 6. Modify address details of an existing customer

SELECT first_name, last_name, address
    FROM Patient
    WHERE Patient_id = 300;

UPDATE Patient
    SET address = '132 DIGBY Road, EXMOUTH, OX171NZ, United Kingdom'
    WHERE patient_id = 300;


-- 7. Print a list of all patient names and addresses for patients registered to doctors based at one particular hospital – that could be used for posting information mail to all of the hospitals registered patients

SELECT 
    p.first_name,
    p.last_name,
    p.address
FROM patient p
JOIN doctor d
    ON p.doctor_id = d.doctor_id
WHERE d.hospital_id = 39;

-- 8.	Print a list of all doctors based at teaching hospitals that were accredited between 2015 – 2024

SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    h.name AS hospital_name,
    h.accreditation_date
FROM doctor d
JOIN Hospital h
    ON d.hospital_id = h.hospital_id
WHERE h.is_teaching_hospital = 1
  AND h.accreditation_date BETWEEN '2015-01-01' AND '2024-12-31'
ORDER BY h.accreditation_date ASC, d.first_name ASC, d.last_name ASC;
 

-- 9.	List all patient who may have a particular disease based on which medication they have been pre7scribed 

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.address,
    m.name AS medication_name
FROM patient p
JOIN prescription pr
    ON p.patient_id = pr.patient_id
JOIN medication m
    ON pr.medication_id = m.medication_id
WHERE m.name = 'Tramadol'
ORDER BY p.last_name ASC, p.first_name ASC;


-- 10. Print a list of all doctors who specialize in treating a particular disease at a particular hospital.

SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    h.name AS hospital_name,
    ds.disease_id,
    di.name AS disease_name
FROM Doctor d
JOIN Hospital h 
    ON d.hospital_id = h.hospital_id
JOIN DiseaseSpecialist ds
    ON d.doctor_id = ds.doctor_id
JOIN Disease di
    ON ds.disease_id = di.disease_id
WHERE h.hospital_id = 18
  AND di.disease_id = 1;


-- 11. List all lab results for all patients over the age of 60 

SELECT 
    lr.lab_result_id,
    p.patient_id,
    p.first_name,
    p.last_name,
    lr.lab_test_id,
    lr.requested_date,
    lr.result_date,
    lr.result_value,
    lr.is_normal,
    lr.notes
FROM LabResult lr
JOIN patient p
    ON lr.patient_id = p.patient_id
WHERE TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) > 60
ORDER BY p.last_name ASC, p.first_name ASC, lr.result_date DESC;

-- 12 Print a list of all appointments for a given patient. 

SELECT 
    a.appointment_id,
    a.appointment_start,
    a.duration_minutes,
    a.reason,
    a.status,
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    h.name AS hospital_name
FROM Appointment a
JOIN Patient p   ON a.patient_id = p.patient_id
JOIN Doctor d    ON a.doctor_id = d.doctor_id
JOIN Hospital h  ON a.hospital_id = h.hospital_id
WHERE a.patient_id = 46
ORDER BY a.appointment_start DESC;


-- 13 Print a list of all appointments for a given doctor. 

 SELECT 
    a.appointment_id, 
    a.appointment_start, 
    a.duration_minutes, 
    a.reason, 
    a.status, 
    a.patient_id, 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name, 
    p.date_of_birth AS patient_dob 
    FROM Appointment a 
    JOIN Patient p ON a.patient_id = p.patient_id 
    WHERE a.doctor_id = 46 
    ORDER BY a.appointment_start DESC; 

-- 14 Print all prescription made from particular hospital ordered pe include only these 4 columns: the medication name, the name of doctor who prescribed it, the name of the patient, and the name of hospital. 

SELECT  
    m.name AS medication_name, 
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name, 
    h.name AS hospital_name 
    FROM Prescription pr 
    JOIN Doctor d  
        ON pr.doctor_id = d.doctor_id 
    JOIN Patient p  
        ON pr.patient_id = p.patient_id 
    JOIN Medication m  
        ON pr.medication_id = m.medication_id 
    JOIN Hospital h 
        ON d.hospital_id = h.hospital_id 
    WHERE h.name = 'Talaton Clinic';    

 