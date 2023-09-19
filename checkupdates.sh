#!/bin/bash

# Check for updates in the background and redirect output to a file
(pacman -Sy > /dev/null 2>&1) &
(pacman -Qu | awk '{print $1}' > /tmp/updates.txt) &

# Wait for both background processes to finish
wait

# Read the update information from the file
updates=$(cat /tmp/updates.txt)

# Check if there are updates available
if [ -n "$updates" ]; then
    # Send a notification with the number of updates available
    notify-send "Arch Linux Updates Available" "$updates"
else
    # If no updates are available, send a different notification
    notify-send "Arch Linux is up to date" "No updates available"
fi

# Clean up the temporary file
rm /tmp/updates.txt

