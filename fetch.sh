#!/bin/sh

# Use gum to create an interactive menu
choice=$(gum choose "System" "CPU" "Memory" "Disk" "Network" "Graphics" "Audio")

# Depending on the user's choice, display different system information
case $choice in
  "System")
    echo -e "\uf109 $(tput setaf 2)System Information$(tput sgr0)"
    inxi -S
    ;;
  "CPU")
    echo -e "\uf2db $(tput setaf 2)CPU Information$(tput sgr0)"
    inxi -C
    ;;
  "Memory")
    echo -e "\uf2d8 $(tput setaf 2)Memory Information$(tput sgr0)"
    inxi -I
    ;;
  "Disk")
    echo -e "\uf0a0 $(tput setaf 2)Disk Information$(tput sgr0)"
    inxi -D
    ;;
  "Network")
    echo -e "\uf1eb $(tput setaf 2)Network Information$(tput sgr0)"
    inxi -n
    ;;
  "Graphics")
    echo -e "\uf108 $(tput setaf 2)Graphics Information$(tput sgr0)"
    inxi -G
    ;;
  "Audio")
    echo -e "\uf028 $(tput setaf 2)Audio Information$(tput sgr0)"
    inxi -A
    ;;
esac
