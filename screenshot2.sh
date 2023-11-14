#!/bin/bash

# Specify the folder where you want to save the screenshot
screenshot_folder="/home/dino/Pictures/screenshots"

# Ensure the folder exists, create it if necessary
mkdir -p "$screenshot_folder"

# Get a list of all connected monitors using xrandr
monitor_list=$(xrandr --listmonitors | awk '{print $4}')

# Display a menu to select a monitor
PS3="Select a monitor to capture: "
select monitor_name in $monitor_list; do
  if [ -n "$monitor_name" ]; then
    break
  else
    echo "Invalid selection, please choose a monitor."
  fi
done

# Get the screen coordinates of the selected monitor
monitor_coordinates=$(xrandr --current | grep "$monitor_name" | awk '{print $3}')

# Generate a unique filename for the screenshot (e.g., using timestamp)
screenshot_file="$screenshot_folder/screenshot_$(date +'%Y%m%d%H%M%S').png"

# Use import from ImageMagick to capture the screenshot with the selected monitor coordinates
import -window root -crop "$monitor_coordinates" "$screenshot_file"

# Notify the user that the screenshot has been saved
echo "Screenshot saved as $screenshot_file"

