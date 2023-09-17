#!/bin/bash

# Define the wallpaper directory
WALLPAPER_DIR="/home/dino/gallery-dl/wallhaven"

# Check if the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Wallpaper directory not found: $WALLPAPER_DIR"
  exit 1
fi

# Get the list of connected monitors/displays
connected_monitors=($(xrandr | grep " connected" | awk '{print $1}'))

# Check if there are any connected monitors
if [ ${#connected_monitors[@]} -eq 0 ]; then
  echo "No connected monitors found."
  exit 1
fi

# Use find to search for image files in the wallpaper directory
wallpapers=()
for monitor in "${connected_monitors[@]}"; do
  wallpaper=$(find "$WALLPAPER_DIR" -type f -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' | fzf --header "Select wallpaper for $monitor" --preview "echo {}" --preview-window=up:30%)
  if [ -n "$wallpaper" ]; then
    wallpapers+=("$wallpaper")
  fi
done

# Check if no wallpapers were selected
if [ ${#wallpapers[@]} -eq 0 ]; then
  echo "No wallpapers selected."
  exit 0
fi

# Set wallpapers for connected monitors using feh
for ((i=0; i<${#connected_monitors[@]}; i++)); do
  feh --bg-fill "${wallpapers[$i]}" --output "${connected_monitors[$i]}"
  echo "Wallpaper set for ${connected_monitors[$i]}: ${wallpapers[$i]}"
done

