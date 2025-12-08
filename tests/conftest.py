import pytest
import mysql.connector
import csv
import os


TEST_DB = "hospital_test"


TABLES_AND_CSVS = {
    "Hospital": "data/hospitals.csv",
    "Doctor": "data/doctors.csv",
    "Patient": "data/patients.csv",
    "Medication": "data/medications.csv",
    "Disease": "data/diseases.csv",
    "DiseaseTreatment": "data/disease_treatments.csv",
    "DiseaseSpecialist": "data/disease_specialists.csv",
    "LabTest": "data/lab_tests.csv",
    "Prescription": "data/prescriptions.csv",
    "Appointment": "data/appointments.csv",
    "LabResult": "data/lab_results.csv",
}


@pytest.fixture(scope="session")
def mysql_conn():
    """
    Create a fully isolated MySQL test database for the test session.

    This fixture:
    - Connects to the local MySQL server.
    - Drops any existing test database named `hospital_test`.
    - Creates a fresh empty test database.
    - Executes all CREATE TABLE statements from `schema.sql`.
    - Loads every CSV file listed in TABLES_AND_CSVS directly into its
      corresponding table using parameterised INSERTs.
      (This avoids the use of multi-statement execution and
       `LOAD DATA LOCAL INFILE`, which are incompatible with the
       MySQL Connector/Python C-extension.)
    - Commits all changes and yields a live MySQL connection to tests.

    After all tests complete, the fixture:
    - Drops the entire test database to leave the MySQL server clean.
    - Closes the database connection.

    Returns
    -------
    mysql.connector.connection_cext.CMySQLConnection
        A connection object to the temporary test database. Tests may create
        cursors, run queries, and read results freely. The database is isolated
        from production or development data and is recreated for each test run.
    """

    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        allow_local_infile=True,
    )
    cursor = conn.cursor()

    # Start clean
    cursor.execute(f"DROP DATABASE IF EXISTS {TEST_DB}")
    cursor.execute(f"CREATE DATABASE {TEST_DB}")
    cursor.execute(f"USE {TEST_DB}")

    # -------------------------------------------------------------
    # Load schema.sql (safe, no multi-statement issues here)
    # -------------------------------------------------------------
    with open("mysql/schema.sql") as f:
        schema_sql = f.read()

    for stmt in schema_sql.split(";"):
        stmt = stmt.strip()
        if stmt:
            cursor.execute(stmt)

    conn.commit()

    # -------------------------------------------------------------
    # Load CSVs into tables manually instead of LOAD DATA
    # -------------------------------------------------------------
    for table, csv_path in TABLES_AND_CSVS.items():
        with open(csv_path, newline="") as f:
            reader = csv.reader(f)
            headers = next(reader)  # skip header row

            placeholders = ", ".join(["%s"] * len(headers))
            insert_sql = f"INSERT INTO {table} VALUES ({placeholders})"

            for row in reader:
                cursor.execute(insert_sql, row)

    conn.commit()

    yield conn

    # Teardown
    cursor.execute(f"DROP DATABASE IF EXISTS {TEST_DB}")
    conn.close()


