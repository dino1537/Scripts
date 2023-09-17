#!/bin/bash

# Define the wallpaper directory
WALLPAPER_DIR="/home/dino/gallery-dl/wallhaven"

# Check if the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Wallpaper directory not found: $WALLPAPER_DIR"
  exit 1
fi

# Use find to search for image files in the wallpaper directory
wallpapers=$(find "$WALLPAPER_DIR" -type f -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' | fzf)

# Check if no wallpaper was selected
if [ -z "$wallpapers" ]; then
  echo "No wallpaper selected."
  exit 0
fi

# Preview selected wallpaper with 'feh'
feh "$wallpapers" --geometry 800x600 &

# Prompt user to confirm or cancel setting the wallpaper
read -rp "Do you want to set this wallpaper as the background? (y/n): " confirm
if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
  # Set the selected wallpaper using nitrogen
  # If you prefer xwallpaper, replace 'nitrogen' with 'xwallpaper'
  nitrogen --set-zoom-fill "$wallpapers"
  echo "Wallpaper set to: $wallpapers"
else
  echo "Wallpaper not set."
fi

# Close the 'feh' preview window
killall feh

