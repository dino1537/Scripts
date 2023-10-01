#!/bin/bash

# Default values
file_to_upload=""
remote_url=""
secret=""
expiration_hours=""

# Function to display usage instructions
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -f, --file <file_path>        Upload a local file."
    echo "  -u, --url <remote_url>        Upload a remote URL."
    echo "  -s, --secret <secret_key>     Set a secret key for the upload."
    echo "  -e, --expires <hours>         Set expiration time in hours."
    echo "  -h, --help                    Display this help message."
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -f|--file)
            file_to_upload="$2"
            shift 2
            ;;
        -u|--url)
            remote_url="$2"
            shift 2
            ;;
        -s|--secret)
            secret="$2"
            shift 2
            ;;
        -e|--expires)
            expiration_hours="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Invalid option: $1"
            usage
            ;;
    esac
done

# Check if at least one of file or URL is provided
if [ -z "$file_to_upload" ] && [ -z "$remote_url" ]; then
    echo "Error: You must provide either a local file or a remote URL to upload."
    usage
fi

# Upload a file or remote URL with optional secret and expiration
upload() {
    local url="http://0x0.st"
    local args=()

    if [ -n "$file_to_upload" ]; then
        args+=("-Ffile=@$file_to_upload")
    elif [ -n "$remote_url" ]; then
        args+=("-Furl=$remote_url")
    fi

    if [ -n "$secret" ]; then
        args+=("-Fsecret=")
    fi

    if [ -n "$expiration_hours" ]; then
        args+=("-Fexpires=$expiration_hours")
    fi

    curl "${args[@]}" "$url"
}

# Main upload function
upload

