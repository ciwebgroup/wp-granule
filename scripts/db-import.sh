#!/bin/sh
#
# This script performs the following tasks:
# 1. Reads input data from a specified file.
# 2. Processes the data to extract relevant information.
# 3. Performs calculations or transformations on the extracted data.
# 4. Outputs the processed data to a new file or displays it on the console.
# 
# Usage:
#   ./script_name.sh input_file output_file
#
# Arguments:
#   input_file  - The path to the input file containing data to be processed.
#   output_file - The path to the output file where processed data will be saved.
#
# Example:
#   ./script_name.sh data/input.txt data/output.txt
#
# Note:
# - Ensure that the input file exists and is readable.
# - The script assumes the input data is in a specific format; modify the processing logic if needed.

FILE=$1
if [ -z "$FILE" ]; then
    FILE=$(ls -t *.sql 2>/dev/null | head -n 1)
    if [ -z "$FILE" ]; then
        echo "Usage: ./scripts/db-import.sh <path-to-sql-file>"
        exit 1
    fi
fi

echo "Importing database from $FILE..."
wp db import $FILE
echo "Database import completed."
