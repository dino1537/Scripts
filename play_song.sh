#!/bin/bash

# Check if mpv is installed
if ! command -v mpv &> /dev/null; then
    echo "mpv is not installed. Please install it to play songs."
    exit 1
fi

# Set the path to your music folder
music_folder="/home/dino/Music/"

# Get a list of all song files in the music folder and its subdirectories
IFS=$'\n' song_files=( $(find "$music_folder" -type f) )

# Prompt the user to select a song from the list
echo "Please select a song:"
select song_file in "${song_files[@]}"; do
    # Check if the user has selected a valid option
    if [[ -n $song_file ]]; then
        # Play the selected song using mpv
        mpv "$song_file"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Exit the script
exit 0
