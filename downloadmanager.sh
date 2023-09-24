#!/bin/bash

# Maximum number of parallel downloads
MAX_PARALLEL_DOWNLOADS=4

# Check if aria2c is available, otherwise fallback to wget
if command -v aria2c &>/dev/null; then
    DOWNLOADER="aria2c"
elif command -v wget &>/dev/null; then
    DOWNLOADER="wget"
elif command -v curl &>/dev/null; then
    DOWNLOADER="curl"
else
    echo "Error: No suitable downloader (aria2c, wget, or curl) found."
    exit 1
fi

# Function to download a file with resuming support
download_file() {
    local url="$1"
    local output="$2"
    
    if [ "$DOWNLOADER" == "aria2c" ]; then
        aria2c -c -o "$output" "$url"
    elif [ "$DOWNLOADER" == "wget" ]; then
        wget -c "$url" -O "$output"
    elif [ "$DOWNLOADER" == "curl" ]; then
        curl -C - -o "$output" "$url"
    fi
    
    if [ $? -ne 0 ]; then
        echo "Error: Download failed for $url"
    fi
}

# Function to remove completed entries from the queue file
remove_completed_entries() {
    local queue_file="$1"
    local temp_file="${queue_file}.tmp"
    
    while read -r line || [[ -n "$line" ]]; do
        output=$(echo "$line" | awk '{print $2}')
        if [ ! -e "$output" ]; then
            echo "$line" >> "$temp_file"
        else
            echo "Removing completed entry: $line"
        fi
    done < "$queue_file"
    
    mv "$temp_file" "$queue_file"
}

# Function to process the download queue
process_queue() {
    local queue_file="$1"
    local download_count=0
    local pid_array=()
    
    while read -r line || [[ -n "$line" ]]; do
        if [[ ! -z "$line" ]]; then
            url=$(echo "$line" | awk '{print $1}')
            output=$(echo "$line" | awk '{print $2}')
            
            if [ ! -e "$output" ]; then
                download_file "$url" "$output" &
                pid_array+=($!)
                ((download_count++))
                
                # Limit the number of parallel downloads
                if [ $download_count -ge $MAX_PARALLEL_DOWNLOADS ]; then
                    wait "${pid_array[@]}"
                    download_count=0
                    pid_array=()
                fi
            else
                echo "File '$output' already exists. Skipping download."
            fi
        fi
    done < "$queue_file"
    
    # Wait for any remaining background downloads to finish
    wait "${pid_array[@]}"
    
    # Remove completed entries from the queue file
    remove_completed_entries "$queue_file"
}

# Main
if [ $# -eq 0 ]; then
    echo "Usage: $0 <queue_file>"
    exit 1
fi

queue_file="$1"

if [ ! -e "$queue_file" ]; then
    echo "Error: Queue file '$queue_file' not found."
    exit 1
fi

process_queue "$queue_file"

echo "Download queue completed."

