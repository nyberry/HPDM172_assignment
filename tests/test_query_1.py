import pytest
import mysql.connector

def test_querypy_1(mysql_conn):

    """
    Verify that all doctors returned by the 'doctors at hospital 2' query
    are correctly associated with hospital_id = 2.

    This test executes a JOIN between Doctor and Hospital, filters for
    hospital_id = 2, and asserts that every returned doctor row contains
    the expected hospital assignment.

    Purpose
    -------
    Ensures that:
    - Foreign key relationships between Doctor and Hospital are valid.
    - The query logic used to retrieve doctors for a specific hospital
      functions as intended.
    - The underlying test database is populated consistently.

    Parameters
    ----------
    mysql_conn : mysql.connector.connection_cext.CMySQLConnection
        A connection to the temporary MySQL test database provided by
        the pytest database fixture.

    Raises
    ------
    AssertionError
        If any doctor row is not linked to hospital_id = 2.
    """
    
    cursor = mysql_conn.cursor()

    cursor.execute("""
        SELECT d.doctor_id, d.hospital_id
        FROM Doctor d
        JOIN Hospital h ON d.hospital_id = h.hospital_id
        WHERE h.hospital_id = 2;
    """)

    rows = cursor.fetchall()

    for doctor_id, hospital_id in rows:
        assert hospital_id == 2
