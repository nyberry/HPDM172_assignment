import pytest
import mysql.connector

def test_queries_file_runs(mysql_conn):
    """
    Execute every SQL statement in `queries.sql` against the temporary test
    database and assert that none of them fail.

    This test ensures that:
    - All SQL statements are valid.
    - All referenced tables and columns exist in the database schema.
    - All JOINs and WHERE clauses execute without errors.
    - No unread result buffers remain after execution (handled via fetchall()).
    - The SQL queries file remains stable as schema or data evolve.

    Parameters
    ----------
    mysql_conn : mysql.connector.connection_cext.CMySQLConnection
        A pytest fixture providing a fresh MySQL database populated with
        schema.sql and CSV data, isolated from the main development database.

    Raises
    ------
    AssertionError
        If any SQL statement fails to execute or leaves an unread result.
    """
    cursor = mysql_conn.cursor()

    with open("mysql/queries.sql") as f:
        sql_text = f.read()

    statements = [s.strip() for s in sql_text.split(";") if s.strip()]

    for stmt in statements:
        try:
            cursor.execute(stmt)

            # fetch all data to avoid unread result errors
            try:
                cursor.fetchall()
            except mysql.connector.errors.InterfaceError:
                # No rows to fetch (e.g., DDL, UPDATE)
                pass

        except Exception as e:
            raise AssertionError(f"Query failed:\n{stmt}\n\nError: {e}")

