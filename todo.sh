#!/bin/bash

# Define the data file to store tasks
DATAFILE="todo.txt"

# Initialize the data file if it doesn't exist
touch "$DATAFILE"

# Function to add a task
function add_task() {
    echo "$1" >> "$DATAFILE"
    echo "Task added: $1"
}

# Function to list tasks
function list_tasks() {
    if [[ -s "$DATAFILE" ]]; then
        echo "Tasks:"
        cat "$DATAFILE"
    else
        echo "No tasks found."
    fi
}

# Main program loop
while true; do
    echo "Options:"
    echo "  1. Add Task"
    echo "  2. List Tasks"
    echo "  3. Quit"
    read -p "Choose an option (1/2/3): " choice

    case "$choice" in
        1)
            read -p "Enter task: " task
            add_task "$task"
            ;;
        2)
            list_tasks
            ;;
        3)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1, 2, or 3."
            ;;
    esac
done

