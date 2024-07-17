#!/bin/bash

# Define the project directory and config file
PROJECT_DIR="/home/ubuntu/nodejs"
CONFIG_FILE="ecosystem.config.js"

# Navigate to the project directory
cd "$PROJECT_DIR" || { echo "Failed to change directory to $PROJECT_DIR"; exit 1; }

# Function to check if PM2 process is running
is_pm2_running() {
  pm2 list | grep -q "$CONFIG_FILE"
}

# Stop all running instances of the application (if any)
pm2 stop "$CONFIG_FILE" || echo "No running instances found to stop."

# Reload if PM2 service is already running, else start it
if is_pm2_running; then
  pm2 reload "$CONFIG_FILE" || { echo "Failed to reload the application"; exit 1; }
  echo "PM2 service reloaded successfully."
else
  pm2 start "$CONFIG_FILE" || { echo "Failed to start the application"; exit 1; }
  echo "PM2 service started successfully."
fi

# Save the process list
pm2 save || { echo "Failed to save the pm2 process list"; exit 1; }

echo "Script execution completed successfully."
