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

# Prompt for optional attachments
echo "Do you want to attach files? (y/n)"
read attach_option

if [[ $attach_option == 'y' || $attach_option == 'Y' ]]; then
    echo "Enter the full paths of the files to attach (separated by a space if more than one):"
    read -a file_paths

    # Check if any attachments were provided
    if [ ${#file_paths[@]} -eq 0 ]; then
        echo "No attachment paths provided. Sending email without attachments."
        echo "$body" | mutt -s "$subject" -- "${recipients[@]}"
    else
        # Send email with attachments
        echo "Sending email to ${recipients[@]} with subject: $subject and attachments: ${file_paths[@]}"
        echo "$body" | mutt -s "$subject" -a "${file_paths[@]}" -- "${recipients[@]}"
    fi
else
    # Send email without attachments
    echo "Sending email to ${recipients[@]} with subject: $subject"
    echo "$body" | mutt -s "$subject" -- "${recipients[@]}"
fi

# Check if the email was sent successfully
if [[ $? -eq 0 ]]; then
    echo "Email sent successfully!"
else
    echo "Error sending email."
fi
