#!/bin/bash

# Define the reminders directory
reminders_dir="$HOME/reminders"

# Function to add a reminder to a selected day using 'zenity'
add_reminder() {
    selected_day="$1"
    formatted_day=$(date -d "$selected_day" +"%d-%m-%Y") # Format the selected day as DD-MM-YYYY
    file_name="${formatted_day}_reminder.md"

    # Use zenity's text info dialog for reminder input with a bigger text area
    reminder=$(zenity --text-info --title="Add Reminder" \
        --width=400 --height=300 --text="Enter a reminder for $formatted_day:" \
        --editable)

    if [ -z "$reminder" ]; then
        exit 0
    fi

    # Create the reminders directory if it doesn't exist
    mkdir -p "$reminders_dir"

    # Append the new reminder to the existing file or create a new one
    echo -e "- $reminder" >> "$reminders_dir/$file_name"

    zenity --info --title="Reminder Added" --text="Reminder for $formatted_day added successfully!"

    display_calendar_with_reminders
}

# Function to display existing reminders for a selected day
display_existing_reminders() {
    formatted_day="$1"
    file_name="${formatted_day}_reminder.md"

    # Check if the reminder file exists
    if [ -e "$reminders_dir/$file_name" ]; then
        zenity --text-info --title="Existing Reminders for $formatted_day" \
            --width=400 --height=300 --filename="$reminders_dir/$file_name"
    else
        zenity --info --title="No Reminders Found" --text="No reminders found for $formatted_day."
    fi
}

# Function to display the calendar and existing reminders
display_calendar_with_reminders() {
    selected_day=$(zenity --calendar \
        --title="Select a day for reminder:" \
        --text="Please choose a date from the calendar below.")

    if [ -z "$selected_day" ]; then
        exit 0
    fi

    formatted_day=$(date -d "$selected_day" +"%d-%m-%Y") # Format the selected day as DD-MM-YYYY

    # Display existing reminders
    display_existing_reminders "$formatted_day"

    # Ask for adding a reminder
    choice=$(zenity --list --title="Add Reminder or Exit" \
        --text="What would you like to do next?" \
        --column="Action" "Add Reminder" "Exit")

    case $choice in
        "Add Reminder") add_reminder "$selected_day" ;;
        "Exit") exit 0 ;;
        *) exit 0 ;;
    esac
}

# Main script execution
display_calendar_with_reminders

