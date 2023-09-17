#!/bin/bash

# List available Wi-Fi SSIDs
echo "Available Wi-Fi SSIDs:"
nmcli device wifi list

# Prompt the user for the SSID they want to connect to
read -p "Enter the SSID you want to connect to: " selected_ssid

# Prompt for the Wi-Fi password
read -s -p "Enter the Wi-Fi password for $selected_ssid: " wifi_password
echo

# Connect to the selected SSID
nmcli device wifi connect "$selected_ssid" password "$wifi_password"

# Check if the connection was successful
if [ $? -eq 0 ]; then
  echo "Connected to $selected_ssid successfully."
else
  echo "Failed to connect to $selected_ssid."
fi

