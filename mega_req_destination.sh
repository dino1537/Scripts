#!/bin/bash

# Path to the megatools binary
MEGATOOLS_BIN="/usr/bin/megatools"

# Prompt the user to enter the local directory path to upload
read -p "Enter the local directory path to upload to MEGA: " LOCAL_DIR

# Check if the specified local directory exists
if [ ! -d "$LOCAL_DIR" ]; then
    echo "Error: The specified local directory does not exist."
    exit 1
fi

# Prompt the user to enter the destination folder on MEGA
read -p "Enter the destination folder on MEGA: " MEGA_DESTINATION_FOLDER

# Check if the destination folder exists on MEGA, and create it if it doesn't
if ! "$MEGATOOLS_BIN" ls "/$MEGA_DESTINATION_FOLDER" &>/dev/null; then
    echo "Creating destination folder on MEGA..."
    "$MEGATOOLS_BIN" mkdir --path "/$MEGA_DESTINATION_FOLDER"
fi

# Loop through all files in the specified local directory and upload them to the destination folder on MEGA
for file in "$LOCAL_DIR"/*; do
    if [ -f "$file" ]; then
        "$MEGATOOLS_BIN" put "$file" --path "/$MEGA_DESTINATION_FOLDER/$(basename "$file")"
    fi
done

