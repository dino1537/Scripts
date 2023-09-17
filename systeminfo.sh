#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Define Nerd Font icons
MEMORY_ICON=""
DISK_ICON=""

# Function to display system information
display_system_info() {
    echo -e "${GREEN}  System Information:${NC}"
    echo "-------------------"
    echo -e "${CYAN}  Hostname:${NC} $(hostname)"
    echo -e "${CYAN}  Kernel Version:${NC} $(uname -r)"
    echo -e "${CYAN}  CPU:${NC} $(lscpu | grep "Model name" | cut -d':' -f2 | sed -e 's/^[ \t]*//')"
    echo -e "${CYAN}  CPU Cores:${NC} $(nproc)"
    echo -e "${CYAN}${MEMORY_ICON}  Memory (RAM):${NC} $(free -h | awk '/^Mem/ {print $2}')"
    echo -e "${CYAN}${DISK_ICON}  Disk Usage:${NC} $(df -h / | awk '{print $4}' | tail -n 1)"
    echo -e "${CYAN}  Uptime:${NC} $(uptime -p)"
    echo -e "${CYAN}  Logged-In Users:${NC} $(who | wc -l)"
}

# Call the function to display system information
display_system_info

