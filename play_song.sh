#!/bin/bash

# Check if mplayer is installed
if ! command -v mplayer &> /dev/null; then
    echo "mplayer is not installed. Please install it to play songs."
    exit 1
fi

# Set the path to your music folder
music_folder="/home/dino/Music/"

# Prompt the user for the song filename
read -p "Enter the name of the song file (including the extension): " song_file

# Check if the specified song file exists in the music folder
if [ -f "$music_folder/$song_file" ]; then
    # Play the specified song using mplayer
    mplayer "$music_folder/$song_file"
else
    echo "The specified song file does not exist in the music folder."
    exit 1
fi

# Exit the script
exit 0

