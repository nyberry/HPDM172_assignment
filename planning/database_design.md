# Hospital Database Design Document

*HPDM172 Group Project*
*Version 1.0*
*November 29 2025*

---

## 1. Introduction

This document describes the steps taken to design the **Hospital Database** as required for the HPDM172 assignment.
It includes:

* Requirements analysis
* Description of entities
* Schema design
* Entity relationships description
* MySQL table definitions
* Notes for use

The design is based on the <a href="assignment_brief.pdf" target="_blank">assignment brief</a>. 

---

## 2. Requirements Summary

The system must contain:

### Required Tables

* **Hospitals** (40 entries)
* **Doctors** (100 entries)
* **Patients** (600 entries)
* **Medications** (≥30 entries)
* **Prescriptions** (500 entries, past 2 years)
* **Diseases**
* **Appointments**
* **Lab Results**

### Required Database Functionality

The SQL queries must allow:

* Listing doctors at a hospital
* Listing prescriptions by patient/doctor
* Ordering prescriptions alphabetically by patient name
* Doctors at teaching hospitals (accredited 2015–2024)
* Patients who may have a particular disease
* Lab results for patients over age 60
* Appointments by patient/doctor
* Prescriptions by hospital, alphabetically by medication
* Hospitals accredited before 2015 with emergency facilities
* Operations ro add patient, update patient address

---

## 3. Entity Identification

From the brief, the following entities were identified:

| Entity           | Description                                  |
| ---------------- | -------------------------------------------- |
| **Hospital**     | A healthcare facility where doctors work     |
| **Doctor**       | Clinician linked to a single hospital        |
| **Patient**      | Person registered under a single doctor      |
| **Medication**   | A drug that can be prescribed                |
| **Prescription** | Medication given by a doctor to a patient    |
| **Disease**      | Linked to medications and specialist doctors |
| **Appointment**  | Scheduled meeting between patient and doctor |
| **LabResult**    | Result of a lab test ordered by a doctor     |

---

## 4. Database Design Decisions

### 4.1 Primary Keys

All tables use `INT AUTO_INCREMENT` primary keys for simplicity and clarity.

### 4.2 Relationships

### **Hospital**

* One Hospital may have many Doctors
* One Hospital may offer many Appointments

### **Doctor**

* One Doctor works at one Hospital
* ... may have many Patients
* ... may write many Prescriptions
* ... may request many LabResults
* ... may specialise in many diseases (via DiseaseSpecialist)

### **Patient**

* One patient is looked after by one Doctor
* ... may have many Prescriptions
* ... may have many Appointments
* ... may have many LabResults

### **Medication**

* One medication may appear in many Prescriptions
* One medication may treat many Diseases (via DiseaseTreatment)

### **Disease**

* One disease may be teated by many Medications (via DiseaseTreatment)
* One disease may be managed by many Doctors (via DiseaseSpecialist)

### **Appointment**

* One appointment joins together one Patient, one Doctor and one Hospital

### **LabTest**

* One LabTest may appear in mant LabResults

### **LabResult**

* One LabResult joins together one LabTest, one patient, and one doctor.

---

### 4.3 Data Types

* `VARCHAR` for names, addresses, text fields
* `DATE` for dates of birth, appointments, prescriptions
* `INT` for IDs and bed capacity
* `ENUM` for hospital type
* `BOOLEAN` for emergency services

---

## 5. Entity Relationship Diagram (ERD)

![Enyity Relationship Diagram](erd.png)

The ERD shows primary keys, foreign keys, and relationships among:

Hospital → Doctor → Patient → Prescription → Medication
Disease → Doctor / Medication
Patient → Appointment / LabResult

---

## 6. MySQL Schema

Below is the MySQL schema used in the project.

---

### 6.1 Hospital Table

This table stores core information about each hospital.

*Each hospital should have a unique name, address, size (number of beds), type, accreditation status.*

```sql
CREATE TABLE Hospital (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    beds INT,
    accreditation_status VARCHAR(100),
    has_emergency_department BOOLEAN
);
```

---

### 6.2 Doctor Table

This table stores demographic and professional information for each doctor. Each doctor is assigned to exactly one hospital, enforced by the foreign key constraint on `hospital_id`.

*"Each of the doctors should work at one hospital and each hospital can have 0 or more doctors working at it. Additional
related information should be stored about each doctor at least including: name, date of birth, Address."*

```sql
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    address VARCHAR(255),
    specialty VARCHAR(100),
    hospital_id INT,
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);
```

---

### 6.3 Patient Table

*"Each patient should be assigned to only one doctor. Additional related information should be stored about each patient at least including: name, date of birth, Address."*

This table stores information for individual patients within the hospital system. Each patient is assigned to exactly one doctor, represented by a foreign key reference to `Doctor.doctor_id`. 

```sql
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,       
    date_of_birth DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);
```

---

### 6.4 Medication Table

This table stores a list of medications that may be prescribed to patients within the hospital system. Each medication is identified by a unique primary key, and each medication name must be unique. The many-to-many relationship between patients and medications is handled
not in this table, but in the `Prescription` table, where each prescription links a single patient to a single medication on a specific date.

*"A medication can be prescribed to multiple patients and each patient could be prescribed multiple medications."*

```sql
CREATE TABLE Medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
```

---

### 6.5 Prescription Table

This table represents a descriptive junction entity linking patients, medications, and doctors. It captures the many-to-many relationship
between patients and medications, with information about the prescription event.

Each record represents a single prescription written for a specific patient, for a specific medication, by a specific doctor, on a specific date. Additional descriptive fields such as dose instructions, duration, and route allow the table to store prescribing information which may be clinically relevant.

*"The database should also contain a table which stores all prescriptions. Each prescription should be for a single medication to a single patient and should be prescribed by a single doctor on a date within the past 2 years."* 

```sql
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication_id INT NOT NULL,
    prescribed_date DATE NOT NULL,
    dose_instructions VARCHAR(255),
    duration_days INT,
    route VARCHAR(150) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);
```

---

### 6.6 Disease Table

*"Create a Diseases table, and define which disease is treated with which medication, and which doctor is a specialist for which disease."*

This table stores a catalogue of diseases or clinical conditions recognised within the hospital system. A disease may be treated with multiple medications, and multiple doctors may specialise in its management. These two many-to-many relationships are represented separately in the `DiseaseTreatment` and `DiseaseSpecialist` junction tables, rather than in this core disease table.

```sql
CREATE TABLE Disease (
    disease_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,
    icd10_code VARCHAR(10)
)
```

---

### 6.7 Disease–Medication Link Table

This table represents the many-to-many relationship between diseases and medications. A single disease may be treated with multiple medications, and a single medication may be used to treat multiple diseases. 


```sql
CREATE TABLE DiseaseTreatment (
    disease_treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_id INT NOT NULL,
    medication_id INT NOT NULL,
    FOREIGN KEY (disease_id) REFERENCES Disease(disease_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
    UNIQUE (disease_id, medication_id)
);
```

---

### 6.8 Disease–Doctor Link Table (Specialists)

This table represents the many-to-many relationship between diseases and doctors. A single disease may be managed by multiple doctors (different specialists), and each doctor may specialise in multiple diseases. This bridge table captures these relationships.

```sql
CREATE TABLE DiseaseSpecialist (
    disease_specialist_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_id INT,
    doctor_id INT,
    FOREIGN KEY (disease_id) REFERENCES Disease(disease_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);
```

---

### 6.9 Appointment Table

This table represents scheduled clinical encounters between a patient and a doctor, occurring at a specific hospital location. Each appointment records the start time, duration, and optional descriptive fields such as the reason for the visit and its current status.

Each appointment links:
- exactly one patient,
- to exactly one doctor,
- at exactly one hospital,
- on a specific date and time.


```sql
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    hospital_id INT NOT NULL,
    appointment_start DATETIME NOT NULL,
    duration_minutes INT NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);
```

---

### 6.10 LabTest Table

This table defines the catalogue of laboratory test types available within the hospital system. Each row represents a type of test (e.g., HbA1c, CRP, FBC), including its name, description, measurement units, reference range, and the biological sample required.

This table does *not* store patient-specific results. Laboratory results for individual patients are stored in the `LabResult` descriptive junction table, which links a patient, a test type, and the requesting doctor together with result values and timestamps.

Results Table

```sql
CREATE TABLE LabTest (
    lab_test_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,
    units VARCHAR(20),
    reference_range VARCHAR(50),
    sample_type VARCHAR(50)
);
```

### 6.11 LabResult Table

This table stores individual laboratory results for patients. Each record represents one completed laboratory test, linking together:

- the patient who the test was performed on,
- the doctor who requested the test,
- the type of test performed (from the LabTest catalogue).

The table also records key times (requested date and result date), the measured result value, whether the result is interpreted as normal/abnormal, and optional free-text notes.

This table is a descriptive junction table between Patient, Doctor, and LabTest.

```sql
CREATE TABLE LabResult (
    lab_result_id INT AUTO_INCREMENT PRIMARY KEY,
    lab_test_id INT NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    requested_date DATE NOT NULL,
    result_date DATE,
    result_value VARCHAR(150),
    is_normal BOOLEAN,
    notes TEXT,
    FOREIGN KEY (lab_test_id) REFERENCES LabTest(lab_test_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
); 
```
---

## 7. Notes for use

The next steps are to create and import data, and to write the required SQL queries. The schema above supports all the required SQL tasks.

Queries should be stored separately in a `sql_queries` file, or as individual files in a `sql_queries` folder.


