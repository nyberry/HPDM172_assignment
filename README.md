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


## Example SQL queries and outputs



