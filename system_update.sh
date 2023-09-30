#!/bin/bash

# Define the log directory and log file
LOG_DIR="updates"
LOG_FILE="$LOG_DIR/update_$(date +%Y%m%d%H%M%S).log"

# Create the log directory if it doesn't exist
mkdir -p $LOG_DIR

# Parse command line options
HELP=0

while getopts "h" opt; do
  case ${opt} in
    h ) HELP=1;;
    \? ) echo "Usage: cmd [-h help]"
         exit 1;;
  esac
done

if [ "$HELP" -eq "1" ]; then
  echo "Usage: cmd [-h help]"
  exit 0
fi

# Ask for user confirmation before updating
read -p "Are you sure you want to update the system? (y/n) " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Update the system and write output to log file
    echo "Updating system..."
    if pacman -Syu | tee $LOG_FILE; then
        echo "System update completed. See $LOG_FILE for details."
    else
        echo "System update failed. See $LOG_FILE for details."
        exit 1
    fi
fi

