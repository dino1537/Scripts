#!/bin/bash

# Define the agenda file name
AGENDA_FILE="agenda.txt"

# Define the valid event types
VALID_EVENT_TYPES=("Meeting" "Task" "Reminder")

# Function to add an event
function add_event {
    # Ask for the event type and validate it
    event_type=$(zenity --list --column="Event Type" "${VALID_EVENT_TYPES[@]}")

    # Ask for the event date
    event_date=$(zenity --calendar --date-format="%d-%m-%y")

    # Ask for the event time
    event_time=$(zenity --entry --text="Enter event time (HH:MM)")

    # Ask for the event description
    event_description=$(zenity --entry --text="Enter event description")

    # Save the event to the agenda file
    echo "$event_date $event_time $event_type: $event_description" >> "$AGENDA_FILE"

    # Show a confirmation message
    zenity --info --text="Event added to your agenda!"
}

# Function to view the agenda
function view_agenda {
    if [ -f "$AGENDA_FILE" ]; then
        # Display the agenda in a zenity info box
        zenity --text-info --filename="$AGENDA_FILE"
    else
        zenity --error --text="No events found."
    fi
}

# Main loop
while true; do
    # Display the main menu and get the user's choice
    choice=$(zenity --list --column="Options" "Add Event" "View Agenda" "Exit")

    # Perform the chosen action
    case $choice in
        "Add Event") add_event ;;
        "View Agenda") view_agenda ;;
        "Exit") exit 0 ;;
    esac
done
