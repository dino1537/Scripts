#!/bin/bash

# Define your music directory
MUSIC_DIR="/home/dino/Music"

# Change to the music directory
cd "$MUSIC_DIR" || exit

# Use rofi to select music files and append them to the current playlist
selected_files=$(find . -type f \( -name "*.mp3" -o -name "*.m4a" -o -name "*.ogg" -o -name "*.wav" -o -name "*.flac" \) -printf "%P\n" | rofi -dmenu -i -multi-select -p "Select music files:")

# Clear the playlist before adding the selected songs
mpc clear

# Check if files were selected
if [ -n "$selected_files" ]; then
  echo "$selected_files" | xargs -d '\n' -I{} mpc add "{}"
  mpc play

# Display a notification for the currently playing song
  current_song=$(mpc current)
  notify-send "Now Playing" "$current_song"
fi

