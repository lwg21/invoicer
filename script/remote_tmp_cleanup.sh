#!/usr/bin/sh
# Remove any SQLite3 files from the /tmp folder of the remote and docker container

YELLOW="\033[33m"
RESET="\033[0m"

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
echo "Cleaning remote /tmp…"
ssh root@$REMOTE_HOST 'rm /tmp/*.sqlite3'

echo "Cleaning container /tmp…"
ssh root@$REMOTE_HOST "docker exec $CONTAINER_ID sh -c 'rm /tmp/*.sqlite3'"

echo "Done!"
