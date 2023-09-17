#!/bin/bash

# Advanced Networking Tool

# Function to display menu
display_menu() {
    clear
    echo "Advanced Networking Tool"
    echo "1. Ping a remote server"
    echo "2. Perform DNS lookup"
    echo "3. List open ports on your system"
    echo "4. Trace route to a destination"
    echo "5. Check network connectivity with Netcat"
    echo "6. Download a file with wget"
    echo "7. SSH into a remote server"
    echo "8. Exit"
}

# Function to ping a remote server
ping_server() {
    read -p "Enter the IP address or domain to ping: " host
    ping -c 4 $host
    read -p "Press Enter to continue..."
}

# Function to perform DNS lookup using host
dns_lookup() {
    read -p "Enter the domain to lookup: " domain
    host $domain
    read -p "Press Enter to continue..."
}

# Function to list open ports
list_ports() {
    netstat -tuln
    read -p "Press Enter to continue..."
}

# Function to trace route to a destination
trace_route() {
    read -p "Enter the destination IP address or domain: " destination
    traceroute $destination
    read -p "Press Enter to continue..."
}

# Function to check network connectivity with Netcat
netcat_check() {
    read -p "Enter the host and port to check (e.g., host port): " host port
    nc -zv $host $port
    read -p "Press Enter to continue..."
}

# Function to download a file with wget
download_with_wget() {
    read -p "Enter the URL to download: " url
    wget $url
    read -p "Press Enter to continue..."
}

# Function to SSH into a remote server
ssh_remote() {
    read -p "Enter the remote server's IP address or domain: " remote_host
    read -p "Enter your username: " username
    ssh $username@$remote_host
    read -p "Press Enter to continue..."
}

while true; do
    display_menu
    read -p "Enter your choice (1/2/3/4/5/6/7/8): " choice

    case $choice in
        1)
            ping_server
            ;;
        2)
            dns_lookup
            ;;
        3)
            list_ports
            ;;
        4)
            trace_route
            ;;
        5)
            netcat_check
            ;;
        6)
            download_with_wget
            ;;
        7)
            ssh_remote
            ;;
        8)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            read -p "Press Enter to continue..."
            ;;
    esac
done

