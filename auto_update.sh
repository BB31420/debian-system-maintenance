#!/bin/bash

log_file="/var/log/auto_update.log"
script_file="$0"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$log_file"
}

# Function to update the system
update_system() {
    log "Updating system..."

    echo "Running 'apt update'..."
    update_output=$(apt update 2>&1)
    echo "$update_output"
    log "$update_output"

    echo "Running 'apt upgrade -y'..."
    upgrade_output=$(apt upgrade -y 2>&1)
    echo "$upgrade_output"
    log "$upgrade_output"

    echo "Running 'apt autoremove -y'..."
    autoremove_output=$(apt autoremove -y 2>&1)
    echo "$autoremove_output"
    log "$autoremove_output"

    echo "Running 'apt clean'..."
    clean_output=$(apt clean 2>&1)
    echo "$clean_output"
    log "$clean_output"

    echo "Running 'apt autoremove --purge'..."
    purge_output=$(apt autoremove --purge 2>&1)
    echo "$purge_output"
    log "$purge_output"

    log "System update completed."
}

# Function to clean log files
clean_logs() {
    log "Cleaning log files..."
    find /var/log -type f -name '*.log' -not -name "$(basename "$log_file")" -exec truncate -s 0 {} \;
    log "Log files cleaned."
}

# Main script
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    exit 1
fi

echo "Starting system maintenance."

# Check if another instance of the script is running
if pidof -x "$(basename "$script_file")" -o %PPID >/dev/null; then
    echo "Error: Another instance of the script is already running."
    exit 1
fi

# Update the system
update_system

# Clean log files
clean_logs

echo "System maintenance finished."

# Schedule a system reboot if necessary
if [ -f /var/run/reboot-required ]; then
    echo "Scheduling a system reboot..."
    log "Scheduling a system reboot..."
    shutdown -r +1 "System reboot scheduled."
fi

