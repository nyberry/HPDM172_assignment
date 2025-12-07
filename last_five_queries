-- ==========================================================================
-- query for doctor with the most prescriptions
-- ==========================================================================

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



=============================================================================
-- use this query to fetch doctors at the hospital with the largest number of beds
=============================================================================

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


==============================================================================

-- this query prints hospitals accredited before 2015 that have an emergency department
==============================================================================

SELECT 
    name AS hospital_name
FROM hospital
WHERE accreditation_date < '2015-01-01'
  AND has_emergency_department = 1;


==============================================================================

-- this query returns patients whose doctors work at hospitals with fewer than 400 beds.

=============================================================================

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




=====================================================================================================================================================
--this query prints all lab results from hospitals accredited between 2013&2020
 
=====================================================================================================================================================================================================================================================================================================================================================================================================================================================

SELECT 
    lr.*,
    h.name AS hospital_name,
    h.accreditation_date
FROM labresult AS lr
JOIN doctor AS d ON lr.doctor_id = d.doctor_id
JOIN hospital AS h ON d.hospital_id = h.hospital_id
WHERE h.accreditation_date BETWEEN '2013-01-01' AND '2020-12-31';

