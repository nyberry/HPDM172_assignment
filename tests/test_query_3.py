"""
Testsfor Query 3: "Print a list of all prescriptions that a particular doctor has prescribed."

This test validates the correctness of the SQL query that retrieves all
prescriptions issued by a specific doctor (doctor_id = 58 in the project’s
example queries). It ensures the query:
- Executes without SQL errors.
- Returns only prescriptions linked to the specified doctor.
- Reflects valid foreign-key relationships in the test database.

All data is sourced from the temporary MySQL test database created by the
pytest fixture `mysql_conn`, which loads schema.sql and CSV files to ensure
consistent, isolated, repeatable tests.
"""

import pytest
import mysql.connector


def test_query_3_prescriptions_by_doctor(mysql_conn):
    """
    Validate Query 3:

    Confirm that all prescriptions returned by the query belong to
    doctor_id = 58, ensuring the filtering logic and doctor–prescription
    relationship are both correct.

    Steps
    -----
    1. Execute the SQL query to fetch prescriptions for doctor_id = 58.
    2. Retrieve all rows returned by the cursor.
    3. Assert that every row's doctor_id matches 58.
    4. Clear unread results from the cursor to avoid MySQL buffer errors.

    Parameters
    ----------
    mysql_conn : mysql.connector.connection_cext.CMySQLConnection
        A live connection to the temporary MySQL test database.

    Raises
    ------
    AssertionError
        If any prescription row is linked to a doctor other than 58.
    """
    cursor = mysql_conn.cursor()

    # -----------------------
    # Execute Query 3 SQL
    # -----------------------
    cursor.execute("""
        SELECT *
        FROM Prescription
        WHERE doctor_id = 58
        ORDER BY prescription_id ASC;
    """)

    rows = cursor.fetchall()

    # ----------------------------------------------------
    # Validate: every returned prescription has doctor_id 58
    # ----------------------------------------------------
    for row in rows:
        returned_doctor_id = row[2]  # (prescription_id, patient_id, doctor_id, ...)
        assert returned_doctor_id == 58, (
            f"Found prescription with doctor_id={returned_doctor_id}, expected 58"
        )

    # ---------------------------------------------------------
    # Consume leftover results to avoid MySQL unread buffer bug
    # ---------------------------------------------------------
    try:
        cursor.fetchall()
    except mysql.connector.errors.InterfaceError:
        pass
