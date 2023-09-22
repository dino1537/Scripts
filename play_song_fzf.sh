#!/bin/bash

# Check if mpv --no-video and fzf are installed
if ! command -v mpv --no-video &> /dev/null; then
    echo "mpv --no-video is not installed. Please install it to play songs."
    exit 1
fi

if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please install it to search for songs interactively."
    exit 1
fi

# Set the path to your music folder
music_folder="/home/dino/Music"

# Use fzf to interactively select a song file
song_file=$(find "$music_folder" -type f -name "*.mp3" -o -name "*.flac" | fzf --preview "echo 'Now Playing: {}'")

# Check if a song file was selected
if [ -n "$song_file" ]; then
    # Play the selected song using mpv --no-video
    mpv --no-video "$song_file"
else
    echo "No song file selected."
    exit 1
fi

# Exit the script
exit 0

