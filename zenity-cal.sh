#!/bin/bash

# Define the reminders directory
reminders_dir="$HOME/reminders"

# Function to display a calendar using 'zenity' and select a day
select_day() {
    selected_day=$(zenity --calendar \
        --title="Select a day for reminder:" \
        --text="Please choose a date from the calendar below.")

    if [ -z "$selected_day" ]; then
        exit 0
    fi

    add_reminder "$selected_day"
}

# Function to add a reminder to a selected day using 'zenity'
add_reminder() {
    selected_day="$1"
    formatted_day=$(date -d "$selected_day" +"%d-%m-%Y") # Format the selected day as DD-MM-YYYY
    file_name="${formatted_day}_reminder.md"
    
    # Use zenity's text info dialog for reminder input
    reminder=$(zenity --text-info --title="Add Reminder" \
        --width=400 --height=200 \
        --text="Enter a reminder for $formatted_day:" \
        --editable)

    if [ -z "$reminder" ]; then
        exit 0
    fi

    # Create the reminders directory if it doesn't exist
    mkdir -p "$reminders_dir"

    # Append the new reminder to the existing file or create a new one
    echo -e "- $reminder" >> "$reminders_dir/$file_name"

    zenity --info --title="Reminder Added" --text="Reminder for $formatted_day added successfully!"
}

# Main script execution
select_day

