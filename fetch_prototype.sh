#!/bin/sh

# Arch Linux logo
echo "$(tput setaf 2)"
cat << "EOF"
       _____
     /      \
    |  .-.  '._;
    _|  |_|_|_|_
   ( `-._.-._.-' )
    `'._ ._. ._.' 
EOF
echo "$(tput sgr0)"

# Loop until the user chooses to exit
while true; do
  # Use gum to create an interactive menu
  choice=$(gum choose "System" "CPU" "Memory" "Disk" "Network" "Graphics" "Audio" "Weather" "Processes" "Sensors" "Partitions" "Drives" "RAID" "USB Devices" "Exit")

  # Depending on the user's choice, display different system information
  case $choice in
    "System")
      echo -e "\e[34m\uf109\e[0m $(tput setaf 2)System Information$(tput sgr0)"
      inxi -S
      ;;
    "CPU")
      echo -e "\e[34m\uf2db\e[0m $(tput setaf 2)CPU Information$(tput sgr0)"
      inxi -C
      ;;
    "Memory")
      echo -e "\e[34m\uf2d8\e[0m $(tput setaf 2)Memory Information$(tput sgr0)"
      inxi -I
      ;;
    "Disk")
      echo -e "\e[34m\uf0a0\e[0m $(tput setaf 2)Disk Information$(tput sgr0)"
      inxi -D
      ;;
    "Network")
      echo -e "\e[34m\uf1eb\e[0m $(tput setaf 2)Network Information$(tput sgr0)"
      inxi -n
      ;;
    "Graphics")
      echo -e "\e[34m\uf108\e[0m $(tput setaf 2)Graphics Information$(tput sgr0)"
      inxi -G
      ;;
    "Audio")
      echo -e "\e[34m\uf028\e[0m $(tput setaf 2)Audio Information$(tput sgr0)"
      inxi -A
      ;;
    "Weather")
      echo -e "\e[34m\uf185\e[0m $(tput setaf 2)Weather Information$(tput sgr0)"
      inxi -w
      ;;
    "Processes")
      echo -e "\e[34m\uf133\e[0m $(tput setaf 2)Process Information$(tput sgr0)"
      inxi -i
      ;;
    "Sensors")
      echo -e "\e[34m\uf2db\e[0m $(tput setaf 2)Sensor Information$(tput sgr0)"
      inxi -s
      ;;
    "Partitions")
      echo -e "\e[34m\uf1c0\e[0m $(tput setaf 2)Partition Information$(tput sgr0)"
      inxi -p
      ;;
    "Drives")
      echo -e "\e[34m\uf015\e[0m $(tput setaf 2)Drive Information$(tput sgr0)"
      inxi -Dx
      ;;
    "RAID")
      echo -e "\e[34m\uf1c0\e[0m $(tput setaf 2)RAID Information$(tput sgr0)"
      inxi -R
      ;;
    "USB Devices")
      echo -e "\e[34m\uf287\e[0m $(tput setaf 2)USB Device Information$(tput sgr0)"
      lsplug
      ;;
    "Exit")
        break
        ;;
   esac

   # Wait for the user to press enter before continuing
   read -p "$(echo -e '\n\rPress enter to continue')"
done
`
