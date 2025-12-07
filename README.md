# HPDM172_assignment

## Overview
This project implements a relational database for the HPDM172 MSc Data Science assignment. It represents the activities of a group of hospitals.

It includes:
- a MySQL database schema describing hospitals, doctors, patients and clinical activtity.
- a sythnetic data generator
- SQL scripts for creating and loading the database
- SQL searches
- a GitHub Pages site for documentation and project presentation


## Repository Structure

```text
HPDM172_assignment/
│
├── README.md                     # Project documentation 
│
├── mysql/
│   ├── schema.sql                # Creates the database tables
│   ├── data_import.sql           # Loads CSV data into MySQL
│   ├── export_database.sql     # Exports the database
│   └── queries.sql          # SQL queries
│
├── data/                         # Synthetic data 
│   ├── hospitals.csv
│   ├── doctors.csv
│   ├── patients.csv
│   ├── medications.csv
│   ├── diseases.csv
│   ├── disease_treatments.csv
│   ├── disease_specialists.csv
│   ├── lab_tests.csv
│   ├── prescriptions.csv
│   ├── appointments.csv
│   └── lab_results.csv
│
├── data_generation/
│   ├── generate_data.py          # Python to generate data
│
├── planning/
│   ├── assignment_brief.pdf
│   ├── ERD.drawio                # Editable
│   ├── ERD.png                   # Final 
│   ├── database_design.md        
│   ├── repo_structure.md
│   ├── repo_workflow.md
│   └── schedule.png
│
└── TeamPortfolio/
    ├── meeting_minutes_1.pdf
    ├── meeting_minutes_2.pdf
    ├── meeting_minutes_3.pdf
    ├── meeting_agenda_1.pdf
    ├── meeting_agenda_2.pdf
    ├── meeting_agenda_3.pdf
    └── gen_ai.md                 # Records of GenAI use
```


## Requirements

- MySQL 8.x
- Python 3.x


## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/nyberry/HPDM172_assignment.git
cd HPDM172_assignment
```

### 2. (optional) Run the python script to recreate CSV files

```bash
cd data_generation
python generate_data.py
```

### 3. Open MySQL


```bash
mysql --local-infile=1 -u root -p

```
notes:
(--local-infile=1 enables .csv loading)
(if you are asked for a password, just press enter)


### 4. Create the database (+drops any previous tables)

```sql
SOURCE mysql/schema.sql;
```

### 5. Load the data

```sql
SOURCE mysql/data_import.sql;
```

## Running the Required SQL queries

Run the queries in MySQL:

```sql
SOURCE mysql/queries.sql
```


## Planning

An Entity relationshp diagram for the projecty is available at

```
planning/erd.png
```

an editable .drawio file is included, snd a description of the steps taken to design the database is at

```
planning/database_design.md
```


## Team Portfolio

All meetings, agendas and documentation of AI assistance is stored in 

```
TeamPOrtfolio/
```

---

# Example SQL Queries

These sample SQL queries demonstrate how the hospital database can be queried.

---

## **1. List all doctors at a particular hospital**

```sql
SELECT d.doctor_id, d.first_name, d.last_name
FROM Doctor d
JOIN Hospital h ON d.hospital_id = h.hospital_id
WHERE h.hospital_id = 2;
```

```text
+-----------+------------+-----------+
| doctor_id | first_name | last_name |
+-----------+------------+-----------+
|        50 | Harrison   | Wood      |
+-----------+------------+-----------+
```

---

## **2. List all prescriptions for a particular patient (chronological)**

```sql
SELECT *
FROM Prescription
WHERE patient_id = 101
ORDER BY prescribed_date ASC;
```

```text
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+-------------+
| prescription_id | patient_id | doctor_id | medication_id | prescribed_date | dose_value | dose_units | dose_instructions | duration_days | route       |
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+-------------+
|             317 |        101 |        17 |            17 | 2024-01-31      |        300 | units      | QDS               |            14 | Intravenous |
|              47 |        101 |        17 |            13 | 2024-04-16      |        250 | g          | TDS               |            14 | Inhaled     |
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+-------------+
```

---

## **3. List all prescriptions written by a specific doctor**

```sql
SELECT *
FROM Prescription
WHERE doctor_id = 58
ORDER BY prescription_id ASC;
```

```text
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+--------------+
| prescription_id | patient_id | doctor_id | medication_id | prescribed_date | dose_value | dose_units | dose_instructions | duration_days | route        |
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+--------------+
|             253 |        347 |        58 |            31 | 2024-08-03      |        409 | mg         | Once weekly       |            14 | Subcutaneous |
|             376 |        344 |        58 |             4 | 2024-06-22      |        485 | g          | OD                |             7 | Subcutaneous |
|             444 |        347 |        58 |            13 | 2024-04-01      |        433 | units      | OD                |            14 | Subcutaneous |
|             465 |        345 |        58 |            32 | 2024-07-05      |        416 | g          | BD                |            90 | Topical      |
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+--------------+
```

---

## **4. List all prescriptions ordered alphabetically by patient name**

```sql
SELECT *
FROM Prescription pr
JOIN Patient p ON pr.patient_id = p.patient_id
JOIN Medication m ON pr.medication_id = m.medication_id
ORDER BY 
    p.last_name ASC,
    p.first_name ASC;
```

```
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+--------------+------------+-----------+------------+-----------+---------------+----------------------------------------------+--------+---------------+---------------------+
| prescription_id | patient_id | doctor_id | medication_id | prescribed_date | dose_value | dose_units | dose_instructions | duration_days | route        | patient_id | doctor_id | first_name | last_name | date_of_birth | address                                      | gender | medication_id | name                |
+-----------------+------------+-----------+---------------+-----------------+------------+------------+-------------------+---------------+--------------+------------+-----------+------------+-----------+---------------+----------------------------------------------+--------+---------------+---------------------+
|              66 |        451 |        76 |            11 | 2025-04-10      |         40 | puffs      | Once weekly       |            28 | Inhaled      |        451 |        76 | Arthur     | Adams     | 1961-05-14    | 16 Church Lane, Huxham, UK                   | Male   |            11 | Amoxicillin         |
|               2 |        144 |        24 |            27 | 2025-08-14      |        131 | puffs      | BD                |            14 | Oral         |        144 |        24 | Chloe      | Adams     | 1977-12-21    | 61 New Road, Uffculme, UK                    | Female |            27 | Spironolactone      |
```

---

## **5. Add a new patient to the database**

```sql
INSERT INTO Patient (
    patient_id, doctor_id, first_name, last_name, 
    date_of_birth, address, gender
) VALUES (
    602, 10, 'John', 'Walker', '1988-03-12',
    '12 Marine Road, Exeter, EX21AB', 'Male'
);
```

---

## **6. Update the address of an existing patient**

```sql
SELECT first_name, last_name, address
FROM Patient
WHERE patient_id = 300;

UPDATE Patient
SET address = '132 DIGBY Road, EXMOUTH, OX171NZ, United Kingdom'
WHERE patient_id = 300;

SELECT first_name, last_name, address
FROM Patient
WHERE patient_id = 300;
```

```
+------------+-----------+--------------------------------------------------+
| first_name | last_name | address                                          |
+------------+-----------+--------------------------------------------------+
| Erin       | Jenkins   | 62 LION Street, TAUNTON, TA037BG, United Kingdom |
+------------+-----------+--------------------------------------------------+

+------------+-----------+--------------------------------------------------+
| first_name | last_name | address                                          |
+------------+-----------+--------------------------------------------------+
| Erin       | Jenkins   | 132 DIGBY Road, EXMOUTH, OX171NZ, United Kingdom |
+------------+-----------+--------------------------------------------------+
```
---

## **7. List all patients whose doctors work at a particular hospital**

```sql
SELECT 
    p.first_name,
    p.last_name,
    p.address
FROM Patient p
JOIN Doctor d ON p.doctor_id = d.doctor_id
WHERE d.hospital_id = 39;
```

```
+------------+-----------+--------------------------------------+
| first_name | last_name | address                              |
+------------+-----------+--------------------------------------+
| Matilda    | Griffiths | 61 The Green, Shillingford Abbot, UK |
| Zachary    | Spencer   | 8 Lower Road, Harberton, UK          |
| Heidi      | Parker    | 145 St Marks Road, Kennford, UK      |
```

---

## **8. List doctors at teaching hospitals accredited between 2015–2024**

```sql
SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    h.name AS hospital_name,
    h.accreditation_date
FROM Doctor d
JOIN Hospital h ON d.hospital_id = h.hospital_id
WHERE h.is_teaching_hospital = 1
  AND h.accreditation_date BETWEEN '2015-01-01' AND '2024-12-31'
ORDER BY 
    h.accreditation_date ASC,
    d.first_name ASC,
    d.last_name ASC;
```

```
+-----------+------------+-----------+---------------------------------+--------------------+
| doctor_id | first_name | last_name | hospital_name                   | accreditation_date |
+-----------+------------+-----------+---------------------------------+--------------------+
|        98 | Annabelle  | Marshall  | Shute Chiropractic Hospital     | 2017-08-18         |
|        48 | Benjamin   | Roberts   | Shute Chiropractic Hospital     | 2017-08-18         |
|        97 | Hugo       | Scott     | Shute Chiropractic Hospital     | 2017-08-18         |
```

---

## **9. List all patients who may have a condition based on medication prescribed**

```sql
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.address,
    m.name AS medication_name
FROM Patient p
JOIN Prescription pr ON p.patient_id = pr.patient_id
JOIN Medication m ON pr.medication_id = m.medication_id
WHERE m.name = 'Tramadol'
ORDER BY p.last_name ASC, p.first_name ASC;
```

```
+------------+------------+-----------+---------------------------------------+-----------------+
| patient_id | first_name | last_name | address                               | medication_name |
+------------+------------+-----------+---------------------------------------+-----------------+
|        257 | Sienna     | Cox       | 56 West Road, Stockland, UK           | Tramadol        |
|         12 | Jessica    | Davis     | 140 St Johns Road, Gittisham, UK      | Tramadol        |
|        501 | Rory       | Davis     | 123 Windmill Lane, Cranbrook, UK      | Tramadol        |
```
---

## **10. List doctors who specialise in treating a particular disease at a hospital**

```sql
SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    h.name AS hospital_name,
    ds.disease_id,
    di.name AS disease_name
FROM Doctor d
JOIN Hospital h  ON d.hospital_id = h.hospital_id
JOIN DiseaseSpecialist ds ON d.doctor_id = ds.doctor_id
JOIN Disease di ON ds.disease_id = di.disease_id
WHERE h.hospital_id = 18
  AND di.disease_id = 1;
```

```
+-----------+------------+-----------+-------------------------------+------------+--------------+
| doctor_id | first_name | last_name | hospital_name                 | disease_id | disease_name |
+-----------+------------+-----------+-------------------------------+------------+--------------+
|         2 | Noah       | Smith     | Honiton Chiropractic Hospital |          1 | Hypertension |
+-----------+------------+-----------+-------------------------------+------------+--------------+
```

---

## **11. List lab results for all patients over age 60**

```sql
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
JOIN Patient p ON lr.patient_id = p.patient_id
WHERE TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) > 60
ORDER BY 
    p.last_name ASC, 
    p.first_name ASC, 
    lr.result_date DESC;
```

```
+---------------+------------+------------+-----------+-------------+----------------+-------------+--------------+-----------+------------------------------+
| lab_result_id | patient_id | first_name | last_name | lab_test_id | requested_date | result_date | result_value | is_normal | notes                        |
+---------------+------------+------------+-----------+-------------+----------------+-------------+--------------+-----------+------------------------------+
|            87 |        128 | Imogen     | Adams     |          13 | 2025-07-05     | 2025-07-09  | 151.6        |         0 | Slightly elevated            |
|           185 |        128 | Imogen     | Adams     |          14 | 2024-03-17     | 2024-03-24  | 30.8         |         1 | Significantly abnormal       |
|           404 |         10 | Luca       | Anderson  |           9 | 2025-07-14     | 2025-07-19  | 184.2        |         1 | Slightly elevated            
```


---

## **12. List all appointments for a particular patient**

```sql
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
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d  ON a.doctor_id = d.doctor_id
JOIN Hospital h ON a.hospital_id = h.hospital_id
WHERE a.patient_id = 46
ORDER BY a.appointment_start DESC;
```

```
Empty set (0.001 sec)
```

---

## **13. List all appointments for a particular doctor**

```sql
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
```

```
+----------------+---------------------+------------------+-------------------------+-----------+------------+-----------------+-------------+
| appointment_id | appointment_start   | duration_minutes | reason                  | status    | patient_id | patient_name    | patient_dob |
+----------------+---------------------+------------------+-------------------------+-----------+------------+-----------------+-------------+
|            924 | 2025-12-02 06:53:47 |               15 | Annual review           | Completed |        272 | Beatrice Begum  | 1978-01-18  |
|             95 | 2025-11-13 07:40:45 |               30 | New symptoms            | Completed |        273 | Ella Davis      | 1953-12-01  |
|            489 | 2025-11-11 14:23:15 |               20 | New symptoms            | No-show   |        276 | Eleanor Wilson  | 1961-12-15  |
```

---

## **14. List prescriptions issued at a given hospital (4-column summary)**

```sql
SELECT  
    m.name AS medication_name, 
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name, 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name, 
    h.name AS hospital_name
FROM Prescription pr
JOIN Doctor d    ON pr.doctor_id = d.doctor_id 
JOIN Patient p   ON pr.patient_id = p.patient_id 
JOIN Medication m ON pr.medication_id = m.medication_id 
JOIN Hospital h  ON d.hospital_id = h.hospital_id 
WHERE h.name = 'Talaton Clinic';
```

```
+---------------------+---------------+-----------------+----------------+
| medication_name     | doctor_name   | patient_name    | hospital_name  |
+---------------------+---------------+-----------------+----------------+
| Insulin aspart      | Henry Johnson | Hugo Holt       | Talaton Clinic |
| Salbutamol          | Henry Johnson | Joseph Farrell  | Talaton Clinic |
| Bisoprolol          | Henry Johnson | Sophia Thompson | Talaton Clinic |
```

---

## **15. Doctor with the highest number of prescriptions**

```sql
SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    COUNT(p.prescription_id) AS total_prescriptions
FROM Doctor AS d
LEFT JOIN Prescription AS p
    ON p.doctor_id = d.doctor_id
GROUP BY 
    d.doctor_id,
    d.first_name,
    d.last_name
ORDER BY total_prescriptions DESC
LIMIT 1;
```

```
+-----------+------------+-----------+---------------------+
| doctor_id | first_name | last_name | total_prescriptions |
+-----------+------------+-----------+---------------------+
|        27 | Daniel     | Green     |                  10 |
+-----------+------------+-----------+---------------------+
```

---

## **16. Doctors working at the hospital with the most beds**

```sql
SELECT 
    d.doctor_id,
    d.first_name,
    d.last_name,
    h.name AS hospital_name,
    h.beds
FROM Doctor AS d
JOIN Hospital AS h
    ON d.hospital_id = h.hospital_id
WHERE h.beds = (
    SELECT MAX(beds)
    FROM Hospital
);
```

---

## **17. Hospitals accredited before 2015 with an emergency department**

```sql
SELECT 
    name AS hospital_name
FROM Hospital
WHERE accreditation_date < '2015-01-01'
  AND has_emergency_department = 1;
```

```
+-----------+------------+-----------+-----------------------------+------+
| doctor_id | first_name | last_name | hospital_name               | beds |
+-----------+------------+-----------+-----------------------------+------+
|        25 | Imogen     | Harris    | Uffculme Urgent Care Centre |  777 |
+-----------+------------+-----------+-----------------------------+------+
```

---

## **18. Patients whose doctors work at hospitals with fewer than 400 beds**

```sql
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    d.doctor_id,
    d.first_name AS doctor_first_name,
    d.last_name  AS doctor_last_name,
    h.name       AS hospital_name,
    h.beds
FROM Patient AS p
JOIN Doctor   AS d ON p.doctor_id   = d.doctor_id
JOIN Hospital AS h ON d.hospital_id = h.hospital_id
WHERE h.beds < 400;
```

```
+------------+------------+-----------+-----------+-------------------+------------------+------------------------------------------------+------+
| patient_id | first_name | last_name | doctor_id | doctor_first_name | doctor_last_name | hospital_name                                  | beds |
+------------+------------+-----------+-----------+-------------------+------------------+------------------------------------------------+------+
|         19 | Mason      | Watson    |         4 | Henry             | Johnson          | Talaton Clinic                                 |  350 |
|         20 | Hugo       | Holt      |         4 | Henry             | Johnson          | Talaton Clinic                                 |  350 |
|         21 | Luna       | Moss      |         4 | Henry             | Johnson          | Talaton Clinic                                 |  350 |
```

---

## **19. Lab results from hospitals accredited between 2013 and 2020**

```sql
SELECT 
    lr.*,
    h.name AS hospital_name,
    h.accreditation_date
FROM LabResult AS lr
JOIN Doctor   AS d ON lr.doctor_id = d.doctor_id
JOIN Hospital AS h ON d.hospital_id = h.hospital_id
WHERE h.accreditation_date BETWEEN '2013-01-01' AND '2020-12-31';
```

```
+---------------+-------------+------------+-----------+----------------+-------------+--------------+-----------+------------------------------+-------------------------------------------+--------------------+
| lab_result_id | lab_test_id | patient_id | doctor_id | requested_date | result_date | result_value | is_normal | notes                        | hospital_name                             | accreditation_date |
+---------------+-------------+------------+-----------+----------------+-------------+--------------+-----------+------------------------------+-------------------------------------------+--------------------+
|            11 |           2 |        558 |        36 | 2025-05-17     | 2025-05-17  | 66.6         |         1 | Slightly elevated            | Broadclyst Specialist Hospital            | 2019-05-16         |
|            99 |           4 |        154 |        36 | 2024-03-18     | 2024-03-19  | 130.0        |         1 | Repeat test recommended      | Broadclyst Specialist Hospital            | 2019-05-16         |
|           136 |          13 |        442 |        36 | 2024-08-12     | 2024-08-19  | 177.9        |         0 | Significantly abnormal       | Broadclyst Specialist Hospital            | 2019-05-16         |
```


