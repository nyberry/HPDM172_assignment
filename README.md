# HPDM172_assignment


This is a repository for group assignment HPDM172

Please look in the planning folder for:

- project schedule / timeline
- suggested repo structure
- suggested repo workflow (ie. clone the dev branch and work on that branch until ready to push to dev; when we have a working project we can push to main)
---

## Getting Started Guide for Team Members

This may help with getting set up locally so you can run the database, generate synthetic data, and test the required SQL queries.

---

## 1. Install MySQL (if you haven’t already)

### **macOS**

You can install MySQL using **Homebrew**:

```bash
brew update
brew install mysql
```

Start MySQL:

```bash
brew services start mysql
```

### **Windows**

Download the MySQL Installer from:

[https://dev.mysql.com/downloads/installer/](https://dev.mysql.com/downloads/installer/)

Choose **MySQL Server** + **MySQL Workbench** during installation.

### **Linux (Ubuntu)**

```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
```

---

## 2. Log in to MySQL in your terminal

```bash
mysql -u root -p
```

(You will be asked for your MySQL root password. On some systems—such as fresh macOS installs—there may be no password initially. Just press **Enter**.)

---

## 3. Create the database (first-time setup)

Inside the MySQL prompt:

```sql
CREATE DATABASE hospitaldb;
```

Then:

```sql
USE hospitaldb;
```

---

## 4. Load our schema.sql file

Once you have pulled the latest version of the repository, navigate to the project folder in your terminal and run:

```bash
mysql -u root -p hospitaldb < mysql/schema.sql
```

This will:

- create all tables
-  set up primary/foreign keys
- prepare the database for synthetic data input

---

## 5. Generating & inserting synthetic data 

Suggest generate CSV files such as:

* hospitals.csv
* doctors.csv
* patients.csv
* prescriptions.csv
* etc.

To import a CSV file into a table:

```sql
LOAD DATA LOCAL INFILE 'patients.csv'
INTO TABLE Patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

(Each table will have its own import command— suggest collect these in `/mysql/data_import.sql` once created.)

---

## 6. Running the required SQL queries

After data is loaded, you could collect the queries to execute in `/mysql/queries.sql`. To execute, copy-paste the query directly into the MySQL prompt.

Or maybe save the, as standalone files in a seperate folder like /sql_queries/

Then to run a query, something like:

Example:

```bash
mysql -u root -p hospitaldb < sql_queries/doctors_by_hospital.sql
```



---

## 7. Exporting the final MySQL database (for the final submission)

Once we are happy all data and queries are working:

```bash
mysqldump -u root -p hospitaldb > mysql/hospital_database.sql
```

This `.sql` file is what we can submit in the final GitHub repository.

---
