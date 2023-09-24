#!/bin/bash

# Define the directory where notes will be stored
NOTES_DIR="$HOME/notes"

# Ensure the notes directory exists
if [ ! -d "$NOTES_DIR" ]; then
    mkdir -p "$NOTES_DIR"
fi

# Function to create a new note
create_note() {
    echo "Enter the title of the note:"
    read -r title
    note_file="$NOTES_DIR/$title.txt"

    if [ -f "$note_file" ]; then
        echo "A note with the same title already exists. Do you want to overwrite it? (y/n)"
        read -r overwrite
        if [ "$overwrite" != "y" ]; then
            echo "Note not created."
            return
        fi
    fi

    echo "Enter your note (Ctrl+D to save):"
    cat > "$note_file"
    echo "Note saved: $note_file"
}

# Function to view a specific note
view_note() {
    echo "Enter the title of the note you want to view:"
    read -r title
    note_file="$NOTES_DIR/$title.txt"

    if [ -f "$note_file" ]; then
        cat "$note_file"
    else
        echo "Note not found: $note_file"
    fi
}

# Function to list all notes
list_notes() {
    ls -1 "$NOTES_DIR"
}

# Function to delete a note
delete_note() {
    echo "Enter the title of the note you want to delete:"
    read -r title
    note_file="$NOTES_DIR/$title.txt"

    if [ -f "$note_file" ]; then
        rm "$note_file"
        echo "Note deleted: $note_file"
    else
        echo "Note not found: $note_file"
    fi
}

# Main menu
while true; do
    echo "Note Taking Tool Menu"
    echo "1. Create a new note"
    echo "2. View a note"
    echo "3. List all notes"
    echo "4. Delete a note"
    echo "5. Exit"
    read -p "Enter your choice (1/2/3/4/5): " choice

    case $choice in
        1) create_note;;
        2) view_note;;
        3) list_notes;;
        4) delete_note;;
        5) exit;;
        *) echo "Invalid choice. Please select a valid option.";;
    esac
done

