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

# Set the selected wallpaper using nitrogen
# If you prefer xwallpaper, replace 'nitrogen' with 'xwallpaper'
nitrogen --set-zoom-fill "$wallpapers"

echo "Wallpaper set to: $wallpapers"

