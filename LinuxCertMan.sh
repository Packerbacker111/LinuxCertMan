#!/bin/bash

# Set Up Error and Informational Logging
logFile="/var/log/lincertman.log"
touch $logFile

# Verify the user running the script is UID 0 (Root); Otherwise exit. Running without root permissions makes this script not work
[ "$(id -u)" != "0" ] && { echo "Error: Please run this script as root!"; exit 1; }

# Install dialog cus TUI
apt update && apt install dialog -y

# Get a list of module files
MODULE_FILES=("modules"/*)

# Extract module names and numbers
MODULE_COUNT=${#MODULE_FILES[@]}

# Check if there are no modules
if [ $MODULE_COUNT -eq 0 ]; then
    echo "No modules found in the modules folder."
    echo "$(date +"%H:%M:%S %m:%d:%Y") | Error: No Modules Found - Script Broken?" >> $logFile
    exit 1
fi

# Create an array for dialog menu options
DIALOG_OPTIONS=()

# Build dialog options based on module names and numbers
for ((i=0; i<MODULE_COUNT; i++)); do
    MODULE_FILE="${MODULE_FILES[i]}"
    MODULE_NAME=$(basename "$MODULE_FILE" | cut -d'_' -f2)
    DIALOG_OPTIONS+=("$((i+1))" "$MODULE_NAME")
done

# Use dialog to create a menu
CHOICE=$(dialog --clear --backtitle "LinuxCertMan.sh" --title "Please Select a Cert Adding Module" \
    --menu "Choose a module to run:" 15 40 5 "${DIALOG_OPTIONS[@]}" \
    3>&1 1>&2 2>&3)

# Handle the user's choice
if [ $? -eq 0 ]; then
    SELECTED_MODULE="${MODULE_FILES[CHOICE-1]}"
    echo "$(date +"%H:%M:%S %m:%d:%Y") | $SELECTED_MODULE was selected!" >> $logFile
    ./$SELECTED_MODULE
    # Add your logic to run the selected module here
    # For example: ./"$SELECTED_MODULE"
else
    echo "User canceled."
    echo "$(date +"%H:%M:%S %m:%d:%Y") | User canceled operation of script!" >> $logFile
fi

