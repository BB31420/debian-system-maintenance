# Auto Update Script
This script automates the process of updating a Debian system, including running system updates, cleaning log files, and scheduling a system reboot if necessary. The script logs the update process to a specified log file for reference.

## Prerequisites
* The script is designed for Debian-based systems.
* The script requires root privileges to run.
## Usage
1. Copy the auto_update.sh script to a location on your Debian system (e.g., /home/yourusername/scripts/auto_update.sh).

2. Open the script file using a text editor and modify the following variables, if needed:

  * log_file: Specify the path and filename for the log file. By default, it is set to /var/log/auto_update.log.
3. Make the script executable by running the following command:
```
chmod +x /path/to/auto_update.sh
```
4. Run the script as root using the following command:
```
sudo /path/to/auto_update.sh
```
5. The script will start the system maintenance process, including system updates, log cleaning, and potential system reboot.

## Scheduling Automatic Execution
To automate the execution of the script at specific intervals, you can use the cron utility. Follow these steps:

1 .Open the ROOT crontab configuration file for editing:
```
sudo crontab -e
```
2. Add a new entry to the crontab file to specify the schedule and command to run the script. For example, to run the script every day at 3:00 AM, add the following line:
```
0 3 * * * /path/to/auto_update.sh
```
3. Save the crontab file and exit the text editor.

The script will now be automatically executed according to the specified schedule.

## License
This script is provided under the MIT License.

## Disclaimer
Use this script at your own risk. The authors are not responsible for any damage or loss caused by running the script. Review the script and understand its functionality before executing it on your system.
