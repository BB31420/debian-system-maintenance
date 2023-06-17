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


# System Monitoring and Security Auditing Script
This script collects information about the system's health and performs security checks to help monitor system performance and enhance security. By running this script regularly and logging the output, you can keep track of system metrics over time and identify potential issues or security vulnerabilities.

## Features
* System Monitoring: Collects CPU and memory usage, disk space, network statistics, and other system metrics.
* Security Auditing: Checks for unauthorized login attempts, analyzes firewall logs, scans for vulnerabilities, and reviews system access logs.
* Logging: Logs system metrics and security audit results to separate log files with timestamps.
## Prerequisites
* Python 3.x
* Required Python packages: psutil
## Usage
1. Clone the repository or download the script file: sys_mon.py.
2. Install the required Python packages: pip install psutil.
3. Open the terminal and navigate to the directory where the script is located.
4. Run the script: sudo python3 sys_mon.py.
5. The script will perform system monitoring and security auditing tasks and log the results to the appropriate log files.
## Scheduling
You can schedule the script to run automatically at specific intervals using cron jobs. Here's an example of how to schedule the script to run every day at 1:00 AM:

1. Open the terminal and run the following command to edit the crontab file:
```
sudo crontab -e
```
2. In the crontab file, add the following line to schedule the script:
```
0 1 * * * sudo python3 /path/to/sys_mon.py
```
This line specifies that the script should be executed at 1:00 AM every day. Replace /path/to/sys_mon.py with the actual path to the script on your system.

3. Save the crontab file and exit the editor.

The script will now run automatically at the scheduled time, and you can find the logs in the specified log file paths.

## Configuration
* Log File Paths: The script saves the system log to /var/log/system.log and the security log to /var/log/security.log. You can modify these paths in the script if desired.
* Timing: You can customize the cron schedule according to your needs to run the script at different intervals.
## Logs
* System Log: Contains system metrics such as CPU usage, memory usage, disk space, and network statistics. The log file is located at /var/log/system.log.
* Security Log: Contains security audit results such as unauthorized login attempts, firewall logs, vulnerability scan output, and system access logs. The log file is located at /var/log/security.log.
## License
This script is licensed under the MIT License.

## Disclaimer
* Use this script at your own risk.
* Review the code and customize it according to your needs before using it in a production environment.
* The script collects system information and performs security checks. However, it is your responsibility to interpret the results and take appropriate actions based on your specific system requirements and security policies.

