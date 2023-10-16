#!/bin/bash

# Associative array of locations and their time zones
declare -A locations

# Function to add locations
add_locations() {
  locations=(
    ["Chennai"]="Asia/Kolkata"
    ["Manila"]="Asia/Manila"
    ["Sydney"]="Australia/Sydney"
    ["London"]="Europe/London"
    ["Frankfurt"]="Europe/Berlin"
    ["New York"]="America/New_York"
    ["San Francisco"]="America/Los_Angeles"
  )
}

# Function to display usage instructions
display_usage() {
  echo "Usage: $0"
  echo "This script displays the local time and time zone for a list of predefined locations."
}

# Function to get local time and time zone
get_local_time() {
  location="$1"
  timezone="$2"
  local_time=$(TZ="$timezone" date +"%I:%M %p")
  echo "$local_time"
}

# Main function
main() {
  add_locations

  # Define column widths for better alignment
  location_width=20
  local_time_width=15
  timezone_width=20

  # Print a header row with column names
  printf "%-${location_width}s %-${local_time_width}s %-${timezone_width}s\n" "Location" "Local Time" "Time Zone"
  
  # Print a separator line
  printf "%-${location_width}s %-${local_time_width}s %-${timezone_width}s\n" "------------------" "---------------" "-------------------"

  # Loop through each location and print its details
  for location in "${!locations[@]}"; do
    timezone=${locations["$location"]}
    
    # Check if the timezone is valid
    if [ -z "$timezone" ]; then
      printf "%-${location_width}s %-${local_time_width}s %-${timezone_width}s\n" "$location" "Error: Timezone not found" ""
      continue
    fi
    
    local_time=$(get_local_time "$location" "$timezone")
    
    # Check if local_time is empty (indicating an error with TZ)
    if [ -z "$local_time" ]; then
      printf "%-${location_width}s %-${local_time_width}s %-${timezone_width}s\n" "$location" "Error: Unable to determine local time" "$timezone"
      continue
    fi
    
    printf "%-${location_width}s %-${local_time_width}s %-${timezone_width}s\n" "$location" "$local_time" "$timezone"
  done
}

# Check for external API for timezone data (you can replace this with a relevant API)
# External API example: http://worldtimeapi.org/api/timezone
# You may need to install jq for JSON parsing: sudo apt-get install jq
# timezone_data=$(curl -s http://worldtimeapi.org/api/timezone)
# locations=$(echo "$timezone_data" | jq -r '.[]')

# Uncomment the following line to fetch timezone data from the external API
# locations=$(curl -s http://worldtimeapi.org/api/timezone)

# Call the main function
main

