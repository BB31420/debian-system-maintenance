#!/bin/bash

# Set the path for the log file and store the script's file name
log_file="/var/log/auto_update.log"
script_file="$0"

# Function to log messages with timestamps
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$log_file"
}

# Function to update the system by running 'apt update', 'apt upgrade', 'apt autoremove', 'apt clean', and 'apt autoremove --purge'
update_system() {
    log "Updating system..."

    # Perform 'apt update' and store the output in a variable
    echo "Running 'apt update'..."
    update_output=$(apt update 2>&1)
    echo "$update_output"
    log "$update_output"

    # Perform 'apt upgrade -y' to upgrade installed packages and store the output in a variable
    echo "Running 'apt upgrade -y'..."
    upgrade_output=$(apt upgrade -y 2>&1)
    echo "$upgrade_output"
    log "$upgrade_output"

    # Perform 'apt autoremove -y' to remove automatically installed packages that are no longer required
    echo "Running 'apt autoremove -y'..."
    autoremove_output=$(apt autoremove -y 2>&1)
    echo "$autoremove_output"
    log "$autoremove_output"

    # Perform 'apt clean' to remove cached package files and free up disk space
    echo "Running 'apt clean'..."
    clean_output=$(apt clean 2>&1)
    echo "$clean_output"
    log "$clean_output"

    # Perform 'apt autoremove --purge' to remove configuration files of removed packages
    echo "Running 'apt autoremove --purge'..."
    purge_output=$(apt autoremove --purge 2>&1)
    echo "$purge_output"
    log "$purge_output"

    log "System update completed."
}

# Function to clean log files by truncating all .log files in /var/log directory except the auto_update.log, system.log, security.log, and auth.log
clean_logs() {
    log "Cleaning log files..."

    # Find all .log files in /var/log directory and truncate their content
    find /var/log -type f -name '*.log' \
        -not -name "$(basename "$log_file")" \
        -not -name "system.log" \
        -not -name "security.log" \
        -not -name "auth.log" \
        -exec truncate -s 0 {} \;

    log "Log files cleaned."
}

# Main script starts here

# Check if the script is run as root (EUID 0) since it requires root privileges to perform system updates
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Inform the user that the system maintenance is starting
echo "Starting system maintenance."

# Check if another instance of the script is already running to avoid conflicts
if pidof -x "$(basename "$script_file")" -o %PPID >/dev/null; then
    echo "Error: Another instance of the script is already running."
    exit 1
fi

# Call the update_system function to update the system
update_system

# Call the clean_logs function to clean log files
clean_logs

echo "System maintenance finished."

# If the file /var/run/reboot-required exists, schedule a system reboot after one minute
if [ -f /var/run/reboot-required ]; then
    echo "Scheduling a system reboot..."
    log "Scheduling a system reboot..."
    shutdown -r +1 "System reboot scheduled."
fi
