#!/usr/bin/sh
# Pull the production database to local environment for backup and testing

# ANSI color codes
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"

BACKUP_DIR="storage/backup"
TIMESTAMP=$(date -u +"%Y%m%d%H%M%S")

# Ensure backup directory exists
mkdir -p "${BACKUP_DIR}"

# Get rails app name
APP_NAME=$(bin/rails runner "puts Rails.application.class.module_parent_name.downcase")
echo "Rails app name: ${YELLOW}${APP_NAME}${RESET}"

# Get VPS IP address from credentials (using master key)
REMOTE_HOST=$(bin/rails runner "puts Rails.application.credentials['remote_host']")
echo "VPS IP address: ${YELLOW}${REMOTE_HOST}${RESET}"

# Find matching container ID
CONTAINER_ID=$(ssh root@$REMOTE_HOST "docker ps -f 'name=$APP_NAME' -q")
echo "Container ID: ${YELLOW}${CONTAINER_ID}${RESET}"

echo ""
echo "Making SQLite backup…"
BACKUP_NAME="${TIMESTAMP}_${APP_NAME}_production.sqlite3"
TEMP_BACKUP_FILE="/tmp/${BACKUP_NAME}"
BACKUP_FILE="${BACKUP_DIR}/${BACKUP_NAME}"

ssh root@$REMOTE_HOST "docker exec $CONTAINER_ID sqlite3 /rails/storage/production.sqlite3 '.backup ${TEMP_BACKUP_FILE}'"
echo "Backup created in Docker container: ${TEMP_BACKUP_FILE}"

ssh root@$REMOTE_HOST "docker cp $CONTAINER_ID:${TEMP_BACKUP_FILE} ${TEMP_BACKUP_FILE}"
echo "Backup created on remote: ${TEMP_BACKUP_FILE}"

echo ""
echo "Copying backup to local machine…"
scp "root@$REMOTE_HOST:$TEMP_BACKUP_FILE" "$BACKUP_FILE"
echo "${YELLOW}Backup successfully copied!${RESET}"
