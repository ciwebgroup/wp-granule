#!/bin/bash

# Check if FQDN is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <FQDN>"
    exit 1
fi

FQDN=$1
CONTAINER="wp_$(echo $FQDN | sed -e 's/\..*//' -e 's/-//g')"
REMOTE_DIR="/var/opt/${FQDN}/www/wp-content"
LOCAL_DIR="./wp-content"
SQL_FILE="${LOCAL_DIR}/export.sql"

# Check if the remote directory exists
if ! ssh root@$FQDN "[ -d $REMOTE_DIR ]"; then
    echo "Directory $REMOTE_DIR does not exist on the remote host."
    exit 1
fi

# Check if the container is running
if ! ssh root@$FQDN "docker ps --format '{{.Names}}' | grep -q ^${CONTAINER}$"; then
    echo "Container $CONTAINER is not running on the remote host."
    exit 1
fi

# Export the database
ssh root@$FQDN "docker exec ${CONTAINER} wp export ${REMOTE_DIR}/mysql.sql"
if [ $? -ne 0 ]; then
    echo "Failed to export the database."
    exit 1
fi

# Copy the wp-content directory
rsync -avz root@$FQDN:${REMOTE_DIR}/ ${LOCAL_DIR}/
if [ $? -ne 0 ]; then
    echo "Failed to copy wp-content directory."
    exit 1
fi

# Run the db-import.sh script
./db-import.sh $SQL_FILE
if [ $? -ne 0 ]; then
    echo "Failed to import the database."
    exit 1
fi

echo "Site pull completed successfully."