# HPDM172_assignment

## Contents
1. Overview
2. Repository Structure
3. Setup Instructions
4. Planning
5. Team Portfolio
6. Examples of SQL queries
7. Testing

## Overview
This project implements a relational database for the HPDM172 MSc Data Science assignment. It represents the activities of a group of hospitals.

It includes:
- a MySQL database schema describing hospitals and their clinical activtity.
- a synthnetic data generator.
- SQL scripts for creating and loading the database.
- SQL searches.
- A shell script to export the database.
- Tests to ensure correct structure and behaviour of the SQL.
- Documentation about planning and team working.

The project has a [Github Pages site](https://nyberry.github.io/HPDM172_assignment/) at  `https://nyberry.github.io/HPDM172_assignment/`



## Repository Structure

```text
HPDM172_assignment/
│
├── README.md                     # Project documentation 
│
├── mysql/
│   ├── schema.sql                # Creates the database tables
│   ├── data_import.sql           # Loads CSV data into MySQL
|   ├── queries.sql               # SQL queries
│   ├── export_database.sh        # Exports the database
|   └──  hospitaldb_export.sql    # The exported database
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
│   └── generate_data.py          # Python to generate data
|
├── tests/                        
│   ├── conftest.py               # configures a test database
│   ├── test_sql_queries.py       # logical tests of schema SQL
│   ├── test_query_1.py           # behavioural tests for each query
│   ├── test_query_2.py
│   ├── test_query_3.py
|   └── etc...
|
│
├── planning/
│   ├── assignment_brief.pdf
│   ├── database_design.md   
|   ├── erd.drawio                # Editable
│   ├── erd.png                   
│   ├── repo_structure.md
│   └── repo_workflow.md
│
└── TeamPortfolio/
    ├── ActionPlan.xls
    ├── meeting_agenda_1.docx
    ├── meeting_agenda_2.docx
    ├── meeting_agenda_3.docx
    ├── meeting_agenda_4.docx
    ├── meeting_minutes_1.docx
    ├── meeting_minutes_2.docx
    ├── meeting_minutes_3.docx
    ├── meeting_minutes_4.docx
    └── GenAI_prompts.md          # Records of GenAI use
```


## Requirements

- MySQL 8.x
- Python 3.x
- Pytest 8.x


## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/nyberry/HPDM172_assignment.git
cd HPDM172_assignment
```

### 2. Optionally, run the python script to recreate CSV files

```bash
cd data_generation
python generate_data.py
```

### 3. Open MySQL


```bash
mysql --local-infile=1 -u root -p

```
- `--local-infile=1` enables `.csv` loading
- if you are asked for a password, leave blank. Just press `enter`.


### 4. Create the database 

```sql
SOURCE mysql/schema.sql;
```
- Any previous tables will be dropped.

### 5. Load the data

```sql
SOURCE mysql/data_import.sql;
```

### 6. Run the required SQL queries

```sql
SOURCE mysql/queries.sql
```

### 7. Optionally, export the database

```bash
cd mysql
./export_database.sh
```
- This shell script runs the export using the mysqldump command in the terminal. 
- The export cannot be executed directly from within MySQL
- The database file generated is `mysql/hospitaldb_export.sql`

## Planning

An account of our reasoning around database structure, and steps taken to design the database, is contained in `planning/database_design.md`

This entity relationship diagram (ERD) for the project is available at `planning/erd.png` and in an editable form at `planning/erd.drawio`.

The ERD shows that the database is fully normalised, and captures the one to one `|-|`, one to many `|-{` and many to many `}-{` relationships between tables in the database.

Many to many relationships occur via join tables such as DiseaseSpecialist and DiseaseTreatment.

![Entity Relationship Diagram](planning/erd.png)


## Team Portfolio

All meetings, agendas and documentation of AI assistance is stored in `TeamPortfolio/`

---

# Example SQL Queries

These sample SQL queries demonstrate how the hospital database can be queried. Here, for demonstration purposes, the output has beeen trimmed to 3 rows.

---

#### **1. List all doctors at a particular hospital**

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

#### 2. List all prescriptions for a particular patient in chronological order

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

#### 3. List all prescriptions written by a specific doctor

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

#### 4. List all prescriptions ordered alphabetically by patient name

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

#### 5. Add a new patient to the database

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

#### 6. Update the address of an existing patient

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

#### 7. List all patients whose doctors work at a particular hospital

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

#### 8. List doctors at teaching hospitals accredited between 2015–2024

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

#### 9. List all patients who may have a condition based on medication prescribed

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

#### 10. List doctors who specialise in treating a particular disease at a hospital

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

#### 11. List lab results for all patients over age 60

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

#### 12. List all appointments for a particular patient

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
WHERE a.patient_id = 121
ORDER BY a.appointment_start DESC;
```

```
+----------------+---------------------+------------------+-------------------+-----------+------------+--------------+-----------+-------------+-----------------------------------------+
| appointment_id | appointment_start   | duration_minutes | reason            | status    | patient_id | patient_name | doctor_id | doctor_name | hospital_name                           |
+----------------+---------------------+------------------+-------------------+-----------+------------+--------------+-----------+-------------+-----------------------------------------+
|            978 | 2025-11-25 13:28:51 |               20 | New symptoms      | Cancelled |        121 | Aria Green   |        21 | Ava Graham  | Newton Poppleford Rehabilitation Centre |
|            128 | 2025-11-13 03:09:48 |               20 | New symptoms      | Cancelled |        121 | Aria Green   |        21 | Ava Graham  | Newton Poppleford Rehabilitation Centre |
|             90 | 2025-10-11 21:10:09 |               20 | Medication review | Cancelled |        121 | Aria Green   |        21 | Ava Graham  | Newton Poppleford Rehabilitation Centre |
|            560 | 2025-09-29 18:47:06 |               30 | Follow-up         | No-show   |        121 | Aria Green   |        21 | Ava Graham  | Newton Poppleford Rehabilitation Centre |
|              1 | 2025-09-04 17:46:48 |               40 | Annual review     | No-show   |        121 | Aria Green   |        21 | Ava Graham  | Newton Poppleford Rehabilitation Centre |
+----------------+---------------------+------------------+-------------------+-----------+------------+--------------+-----------+-------------+-----------------------------------------+
```

---

#### 13. List all appointments for a particular doctor

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

#### 14. List prescriptions issued at a given hospital

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

#### 15. Doctor with the highest number of prescriptions

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


#### 16. Doctors working at the hospital with the most beds


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

```
+-----------+------------+-----------+-----------------------------+------+
| doctor_id | first_name | last_name | hospital_name               | beds |
+-----------+------------+-----------+-----------------------------+------+
|        25 | Imogen     | Harris    | Uffculme Urgent Care Centre |  777 |
+-----------+------------+-----------+-----------------------------+------+
```

---

#### 17. Hospitals accredited before 2015 with an emergency department

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

#### 18. Patients whose doctors work at hospitals with fewer than 400 beds

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

#### 19. Lab results from hospitals accredited between 2013 and 2020

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


## Testing

This project inclues a testing framework using `pytest` to validate the correctness of the database schema and queries. 

All tests run against an isolated MySQL test database.

- `tests/conftest.py` creates a temporary MySQL test database for every test run.

- `tests/test_sql_queries.py` performs structural and logical testing of the SQL queries provided in `mysql/queries.sql`. This ensures that queries.sql functions as a valid, executable collection of SQL statements.

- Each assignment query is also tested individually in dedicated test files, such as `test_query_1.py`, `test_query_2.py` and  `test_query_3.py`.  These tests validate logical correctness, including filtering, ordering, Correct join behaviour, Consistency of foreign-key relationships, and expected shapes of returned result sets. For demonstration purposes, tests for queries 1,2 and 3 have been implemented. In production, tests would be applied to all queries.

This testing strategy ensures that SQL files behave as documented, and remain stable as the project evolves.

To run the tests:

```bash
pytest tests /-q
```