#!/bin/bash

# Export the hospitaldb MySQL database to a SQL dump file
# Usage:
#   ./export_database.sh

DB_NAME="hospitaldb"
OUTPUT_FILE="hospitaldb_export.sql"

echo "Exporting database: $DB_NAME"
mysqldump -u root -p "$DB_NAME" > "$OUTPUT_FILE"

echo "Export completed:"
echo "  -> $OUTPUT_FILE"
