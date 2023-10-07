#!/bin/bash

# Define the Nerd Font symbols
TICK="✓"
CROSS="✖"

# Define the agenda file name
AGENDA_FILE="agenda.txt"

# Function to display the menu
function show_menu {
    echo "Please choose an option:"
    echo "1. Add Event"
    echo "2. View Agenda"
    echo "3. Edit Event"
    echo "4. Delete Event"
    echo "5. Exit"
}

# Function to add an event
function add_event {
    # Ask for the event type
    event_type=$(read_user_input "Enter event type (Meeting/Task/Reminder):")

    # Ask for the event date and validate it
    event_date=$(read_date_input "Enter event date (dd-mm-yy):")

    # Ask for the event time and validate it
    event_time=$(read_time_input "Enter event time (HH:MM):")

    # Ask for the event description
    event_description=$(read_user_input "Enter event description:")

    # Save the event to the agenda file
    echo "$event_date $event_time $event_type: $event_description" >> "$AGENDA_FILE"

    # Show a confirmation message
    echo "${TICK} Event added to your agenda!"
}

# Function to view the agenda
function view_agenda {
    if [ -f "$AGENDA_FILE" ]; then
        echo "Agenda:"
        sort "$AGENDA_FILE" | awk '{$1=""; print $0}' | column -t
    else
        echo "${CROSS} No events found."
    fi
}

# Function to edit an event
function edit_event {
    # Ask for the event date and time
    event_date=$(read_date_input "Enter date of the event you want to edit (dd-mm-yy):")
    event_time=$(read_time_input "Enter time of the event you want to edit (HH:MM):")

    # Check if the event exists
    if grep -q "^$event_date $event_time" "$AGENDA_FILE"; then
        # Ask for the new event details
        new_event_type=$(read_user_input "Enter new event type (Meeting/Task/Reminder):")
        new_event_description=$(read_user_input "Enter new event description:")

        # Update the event in the agenda file
        sed -i "/^$event_date $event_time/d" "$AGENDA_FILE"
        echo "$event_date $event_time $new_event_type: $new_event_description" >> "$AGENDA_FILE"

        # Show a confirmation message
        echo "${TICK} Event edited in your agenda!"
    else
        echo "${CROSS} Event not found in the agenda."
    fi
}

# Function to delete an event
function delete_event {
    # Ask for the event date and time
    event_date=$(read_date_input "Enter date of the event you want to delete (dd-mm-yy):")
    event_time=$(read_time_input "Enter time of the event you want to delete (HH:MM):")

    # Check if the event exists
    if grep -q "^$event_date $event_time" "$AGENDA_FILE"; then
        # Delete the event from the agenda file
        sed -i "/^$event_date $event_time/d" "$AGENDA_FILE"

        # Show a confirmation message
        echo "${TICK} Event deleted from your agenda!"
    else
        echo "${CROSS} Event not found in the agenda."
    fi
}

# Function to read user input with a prompt
function read_user_input {
    read -p "$1 " input
    echo "$input"
}

# Function to read and validate a date input
function read_date_input {
    while true; do
        date_input=$(read_user_input "$1")
        if [[ $date_input =~ ^[0-9]{2}-[0-9]{2}-[0-9]{2}$ ]]; then
            echo "$date_input"
            break
        else
            echo "${CROSS} Invalid date format. Please enter in dd-mm-yy format."
        fi
    done
}

# Function to read and validate a time input
function read_time_input {
    while true; do
        time_input=$(read_user_input "$1")
        if [[ $time_input =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
            echo "$time_input"
            break
        else
            echo "${CROSS} Invalid time format. Please enter in HH:MM format."
        fi
    done
}

# Main loop
while true; do
    show_menu
    read choice
    case $choice in
        1) add_event ;;
        2) view_agenda ;;
        3) edit_event ;;
        4) delete_event ;;
        5) exit 0 ;;
        *) echo "${CROSS} Invalid option" ;;
    esac
done

