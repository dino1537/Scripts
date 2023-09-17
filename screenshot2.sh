#!/bin/bash

# Specify the folder where you want to save the screenshot
screenshot_folder="/home/dino/Pictures/screenshots"

# Ensure the folder exists, create it if necessary
mkdir -p "$screenshot_folder"

# Generate a unique filename for the screenshot (e.g., using timestamp)
screenshot_file="$screenshot_folder/screenshot_$(date +'%Y%m%d%H%M%S').png"

# Take the screenshot using scrot
scrot "$screenshot_file"

# Add annotations using ImageMagick
annotation_text="Dino"
convert "$screenshot_file" -gravity South -pointsize 24 -fill white -annotate +0+10 "$annotation_text" "$screenshot_file"

# Adjust brightness, color balance, and contrast
convert "$screenshot_file" -brightness-contrast 5x10 "$screenshot_file"

# Notify the user that the screenshot has been saved
echo "Screenshot saved as $screenshot_file"

