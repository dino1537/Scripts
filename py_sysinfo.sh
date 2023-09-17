#!/bin/bash

# Check if Python is installed
if command -v python3 &>/dev/null; then
    python3 /home/dino/Documents/python-projects/systeminfo.py
else
    echo "Python 3 is not installed. Please install Python 3 and try again."
fi

