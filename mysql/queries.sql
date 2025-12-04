-- Print a list of all doctors as a particular hospital

SELECT 'List of Doctors at Harberton Urgent Care Centre' AS title;
SELECT d.doctor_id, d.first_name, d.last_name
    FROM doctor d
    JOIN hospital h ON d.hospital_id = h.hospital_id
    WHERE h.name = 'Harberton Urgent Care Centre';

-- Print a list of all prescriptions for a particular patient, ordered by the prescription date.
SELECT 'All Prescriptions for Patient ordered by date' AS title;
SELECT p.prescription_id, p.prescribed_date, m.name AS medication_name, p.dose_value, p.dose_units, p.dose_instructions, p.duration_days, p.route
    FROM prescription p
    JOIN patient pt ON p.patient_id = pt.patient_id
    JOIN medication m ON p.medication_id = m.medication_id
    WHERE pt.patient_id = 299
    ORDER BY p.prescribed_date DESC;

-- Print a list of all prescriptions that a particular doctor has written.
SELECT 'All Prescriptions written by Doctor Isabella Moore' AS title;
SELECT
    p.prescription_id,
    p.prescribed_date,
    pt.first_name AS patient_first_name,
    pt.last_name AS patient_last_name,
    m.name AS medication_name, p.dose_value,
    p.dose_units,
    p.dose_instructions,
    p.duration_days,
    p.route
    FROM prescription p
    JOIN doctor d ON p.doctor_id = d.doctor_id
    JOIN patient pt ON p.patient_id = pt.patient_id
    JOIN medication m ON p.medication_id = m.medication_id
    WHERE d.first_name = 'Isabella' AND d.last_name = 'Moore'
    ORDER BY p.prescribed_date DESC;

-- Print a table showing all prescriptions ordered by the patient name alphabetically.
SELECT 'All Prescriptions ordered by Patient Name' AS title;
SELECT
    p.prescription_id,
    pt.first_name AS patient_first_name,
    pt.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    m.name AS medication_name,
    p.prescribed_date,
    p.dose_value,
    p.dose_units,
    p.dose_instructions,
    p.duration_days,
    p.route
    FROM prescription p
    JOIN patient pt ON p.patient_id = pt.patient_id
    JOIN doctor d ON p.doctor_id = d.doctor_id
    JOIN medication m ON p.medication_id = m.medication_id
    ORDER BY pt.last_name, pt.first_name;

-- Add a new patient to the database
INSERT INTO Patient (
    doctor_id,
    first_name,
    last_name,
    date_of_birth,
    address,
    gender
) VALUES (
    4,
    'Extra',
    'Patient',
    '1995-08-21',
    '24 Park Road, Exeter, UK',
    'Male'
);
