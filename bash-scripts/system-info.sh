#!/bin/bash
# system-info.sh
# Collects system information critical for footprinting during pen tests.
# Author: William Otakwa
# Date: 2025-08-10

set -euo pipefail

echo "=== System Information Report ==="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Uptime: $(uptime -p)"

echo -e "\n--- Network Configuration ---"
ip addr show

echo -e "\n--- Routing Table ---"
ip route show

echo -e "\n--- Listening Ports ---"
ss -tulwn

echo -e "\n--- Active Processes ---"
ps aux --sort=-%cpu | head -n 10

echo -e "\n--- Disk Usage ---"
df -hT | grep -v tmpfs

echo -e "\n--- Mounted Filesystems ---"
mount | column -t

echo -e "\n--- Kernel Version ---"
uname -r

echo -e "\n--- OS Release Info ---"
cat /etc/os-release

echo -e "\nReport complete."
