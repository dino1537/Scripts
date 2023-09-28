#!/bin/bash

# Prompt for the recipient's email addresses
echo "Enter the recipient's email addresses (separated by a space if more than one):"
read -a recipients

# Prompt for the subject of the email
echo "Enter the subject of the email:"
read subject

# Prompt for the body of the email
echo "Enter the body of the email:"
read body

# Prompt for optional attachments using fzf
echo "Do you want to attach files? (y/n)"
read attach_option

if [[ $attach_option == 'y' || $attach_option == 'Y' ]]; then
    echo "Enter the directory path to search for files:"
    read search_directory

    # Check if the specified directory exists
    if [ -d "$search_directory" ]; then
        echo "Select files to attach using fzf (Press Ctrl+T to toggle selection, Enter to confirm):"
        
        # Change the current directory to the user-specified directory
        cd "$search_directory"
        
        # Use find with the current directory
        file_paths=$(find . -type f | fzf --multi < /dev/tty)
        
        # Check if any attachments were selected
        if [ -n "$file_paths" ]; then
            # Send email with attachments
            echo "Sending email to ${recipients[@]} with subject: $subject and attachments: ${file_paths[@]}"
            echo "$body" | mutt -s "$subject" -a "${file_paths[@]}" -- "${recipients[@]}"
        else
            echo "No files selected. Sending email without attachments."
            echo "$body" | mutt -s "$subject" -- "${recipients[@]}"
        fi
    
        # Return to the original directory (optional)
        cd -
    else
        echo "The specified directory does not exist. Sending email without attachments."
        echo "$body" | mutt -s "$subject" -- "${recipients[@]}"
    fi
else
    # Send email without attachments
    echo "Sending email to ${recipients[@]} with subject: $subject"
    echo "$body" | mutt -s "$subject" -- "${recipients[@]}"
fi
