import psutil
import datetime
import subprocess

# System monitoring
def monitor_system():
    # Get CPU and memory usage
    cpu_percent = psutil.cpu_percent()
    memory_percent = psutil.virtual_memory().percent

    # Get disk usage
    disk_usage = psutil.disk_usage('/')

    # Get network statistics
    network_stats = psutil.net_io_counters()

    # Log system metrics with timestamp
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log = f'{timestamp} - CPU: {cpu_percent}%, Memory: {memory_percent}%, Disk Usage: {disk_usage.used}/{disk_usage.total} bytes, Network Sent: {network_stats.bytes_sent} bytes, Network Received: {network_stats.bytes_recv} bytes'
    write_log('/var/log/system.log', log)

# Security auditing
def perform_security_audit():
    try:
        # Check for unauthorized login attempts
        auth_log_content = subprocess.check_output('grep "Failed password" /var/log/auth.log || true', shell=True).decode().strip()
        if auth_log_content:
            write_log('/var/log/security.log', auth_log_content)

        # Analyze firewall logs
        firewall_logs = subprocess.check_output('iptables -L -n', shell=True).decode().strip()
        if firewall_logs:
            write_log('/var/log/security.log', firewall_logs)

        # Scan for vulnerabilities (example: using Lynis)
        vulnerability_scan = subprocess.check_output('lynis audit system', shell=True).decode().strip()
        if vulnerability_scan:
            write_log('/var/log/security.log', vulnerability_scan)

        # Review system access logs (example: using lastlog)
        access_logs = subprocess.check_output('lastlog', shell=True).decode().strip()
        if access_logs:
            write_log('/var/log/security.log', access_logs)

    except subprocess.CalledProcessError as e:
        error_msg = f'Error occurred while executing the security audit command: {e}'
        write_log('/var/log/security.log', error_msg)

# Write log to file
def write_log(filename, log):
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_entry = f'{timestamp} - {log}'
    with open(filename, 'a') as file:
        file.write(log_entry + '\n')

# Main script
if __name__ == '__main__':
    # Perform system monitoring
    monitor_system()

    # Perform security auditing
    perform_security_audit()

