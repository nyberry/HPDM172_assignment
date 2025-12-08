"""
Tests for Query "2. Print a list of all prescriptions for a particular patient,
 ordered by the prescription date."

This test verifies that:
- Only prescriptions belonging to the target patient (patient_id = 101) are returned.
- Results are ordered in ascending order by `prescribed_date`.
- The underlying data loaded into the temporary MySQL test database is consistent.
- The SQL query does not raise errors when executed in the test environment.

The test relies on the pytest fixture `mysql_conn`, which creates an isolated
database instance populated with schema.sql and CSV imports for safe testing.
"""

import pytest
import mysql.connector


def test_query_2(mysql_conn):
    """
    Validate Query 2:
    Ensure all returned prescriptions belong to patient_id = 101 and are
    sorted by `prescribed_date` in ascending order.

    Steps
    -----
    1. Execute the SQL query filtering prescriptions for patient_id = 101.
    2. Fetch all rows from the database cursor.
    3. Assert that each row's patient_id is 101.
    4. Assert that the list of `prescribed_date` values is sorted ascending.
    5. Consume all results to prevent unread buffer errors in MySQL Connector.

    Parameters
    ----------
    mysql_conn : mysql.connector.connection_cext.CMySQLConnection
        A database connection provided by the pytest fixture. The database is
        populated from CSVs and matches the expected project schema.

    Raises
    ------
    AssertionError
        If any returned prescription does not belong to patient_id = 101,
        or if the results are not sorted by prescribed_date.
    """
    cursor = mysql_conn.cursor()

    # Execute the Query 2 SQL
    cursor.execute("""
        SELECT prescription_id,
               patient_id,
               doctor_id,
               medication_id,
               prescribed_date,
               dose_value,
               dose_units,
               dose_instructions,
               duration_days,
               route
        FROM Prescription
        WHERE patient_id = 101
        ORDER BY prescribed_date ASC;
    """)

    rows = cursor.fetchall()

    # --- Validate patient_id correctness ---
    for row in rows:
        assert row[1] == 101, (
            f"Expected patient_id 101, but found {row[1]}"
        )

    # --- Validate sorted order ---
    dates = [row[4] for row in rows]  # prescribed_date column
    assert dates == sorted(dates), (
        "Prescriptions are not sorted by prescribed_date ASC"
    )

    # Clear unread results (important for mysql-connector)
    try:
        cursor.fetchall()
    except mysql.connector.errors.InterfaceError:
        pass
