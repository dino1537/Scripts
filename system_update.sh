#!/bin/bash

# Define the log directory
LOG_DIR="updates"

# Create the log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Generate a unique timestamp for the log file
TIMESTAMP=$(date +%Y%m%d%H%M%S)
LOG_FILE="$LOG_DIR/update_$TIMESTAMP.log"

# Function to display usage information
display_usage() {
  echo "Usage: $0 [-h]"
  echo "Options:"
  echo "  -h  Show this help message"
}

# Parse command line options
HELP=0
while getopts "h" opt; do
  case ${opt} in
    h ) HELP=1;;
    \? ) display_usage
         exit 1;;
  esac
done

if [ "$HELP" -eq "1" ]; then
  display_usage
  exit 0
fi

# Ask for user confirmation before updating
read -p "Are you sure you want to update the system? (y/n) " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Update the system and append output to the log file
    echo "Updating system..."
    if pacman -Syu | tee -a "$LOG_FILE"; then
        echo "System update completed. See $LOG_FILE for details."
    else
        echo "System update failed. See $LOG_FILE for details."
        exit 1
    fi
fi

