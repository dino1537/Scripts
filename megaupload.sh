#!/bin/bash

# Path to the megatools binary
MEGATOOLS_BIN="/usr/bin/megatools"

# Prompt the user to enter the directory path to upload to MEGA
read -p "Enter the directory path to upload to MEGA: " MEGA_UPLOAD_DIR

# Check if the specified directory exists
if [ ! -d "$MEGA_UPLOAD_DIR" ]; then
    echo "Error: The specified directory does not exist."
    exit 1
fi

# Specify the destination folder in MEGA (change 'MyFolder' to your desired folder name)
MEGA_DESTINATION_FOLDER="/Root/bash-scripts"

# Check if the destination folder exists on MEGA, and create it if it doesn't
if ! "$MEGATOOLS_BIN" ls "/$MEGA_DESTINATION_FOLDER" &>/dev/null; then
    echo "Creating destination folder on MEGA..."
    "$MEGATOOLS_BIN" mkdir --path "/$MEGA_DESTINATION_FOLDER"
fi

# Loop through all files in the specified directory and upload them to the destination folder on MEGA
for file in "$MEGA_UPLOAD_DIR"/*; do
    if [ -f "$file" ]; then
        "$MEGATOOLS_BIN" put "$file" --path "/$MEGA_DESTINATION_FOLDER/$(basename "$file")"
    fi
done

