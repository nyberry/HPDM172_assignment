## Repository Structure

The proposed project repository could be organised like this:

```text
HPDM127_ASSIGMENT/
│
├── README.md
├── index.html                    # GitHub Pages site
│
├── mysql/
│   ├── schema.sql                # CREATE TABLE statements
│   ├── data_import.sql           # LOAD DATA / INSERT statements
│   ├── hospital_database.sql     # Full mysqldump export (FINAL)
│   └── test_queries.sql          # All required SQL queries from the brief
│
├── data_generation/
│   ├── generate_data.py          # Python script producing synthetic data
│   ├── hospitals.csv
│   ├── doctors.csv
│   ├── patients.csv
│   ├── medications.csv
│   ├── prescriptions.csv
│   ├── appointments.csv
│   ├── lab_results.csv
|   ├── lab_tests.csv
│   └── diseases.csv
│
├── planning/
|   ├── assignment_brief.pdf      # The original assignment brief
│   ├── database_design.md        # Design notes 
|   ├── ERD.drawio                # Editable ERD source
│   ├── ERD.png                   # final ERD diagram
│   ├── schedule.png              # Project timeline
│   ├── repo_structure.md         # proposed repo organisation
│   ├── repo_workflow.md          # proposed repo branch strategy
│
├── TeamPortfolio/
│   ├── meeting_agenda_1.pdf
│   ├── meeting_minutes_1.pdf
│   ├── meeting_agenda_2.pdf
│   ├── meeting_minutes_2.pdf
    ├── meeting_agenda_3.pdf
│   ├── meeting_minutes_3.pdf
│   ├── gen_ai.md                 # hyperlinks to AI prompts and responses used
│
└── .gitignore
