#!/bin/bash

# Define character sets for upper case, lower case, numbers, and special characters
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
lowercase="abcdefghijklmnopqrstuvwxyz"
numbers="0123456789"
special_chars="!@#$%^&*()-_=+[]{}|;:'\",.<>?/\\"

# Combine all character sets
all_chars="${uppercase}${lowercase}${numbers}${special_chars}"

# Function to generate a random character from the character set
function generate_random_char() {
  local char_set="$1"
  local length=${#char_set}
  local random_index=$((RANDOM % length))
  echo -n "${char_set:$random_index:1}"
}

# Function to generate a complex password
function generate_complex_password() {
  local length="$1"
  local password=""

  for ((i = 0; i < length; i++)); do
    random_char=$(generate_random_char "$all_chars")
    password="${password}${random_char}"
  done

  echo "$password"
}

# Get current timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Define the file name with the timestamp
file_name="passwords_${timestamp}.txt"

# Generate and save a complex password
complex_password=$(generate_complex_password 23)
echo "Generated complex password: $complex_password"

# Save the password along with date and time to the file
echo "Date: $(date)" >> "$file_name"
echo "Generated Password: $complex_password" >> "$file_name"
echo "-------------------" >> "$file_name"

echo "Password saved to $file_name"

