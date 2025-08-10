#!/bin/bash
# file-audit.sh
# Scans for world-writable files, SUID/SGID binaries, and recently modified files.
# Author: William Otakwa
# Date: 2025-08-10

set -euo pipefail

echo "=== File and Directory Audit ==="
echo "Scanning for world-writable files/directories (excluding /proc and /sys)..."
find / -xdev \( -path /proc -o -path /sys \) -prune -o -perm -002 -type f -print 2>/dev/null

echo -e "\nScanning for world-writable directories..."
find / -xdev \( -path /proc -o -path /sys \) -prune -o -perm -002 -type d -print 2>/dev/null

echo -e "\nScanning for SUID binaries..."
find / -xdev -type f -perm -4000 -exec ls -ld {} \; 2>/dev/null

echo -e "\nScanning for SGID binaries..."
find / -xdev -type f -perm -2000 -exec ls -ld {} \; 2>/dev/null

echo -e "\nFinding files modified in last 7 days..."
find / -xdev -type f -mtime -7 -exec ls -lt {} + 2>/dev/null

echo -e "\nAudit complete."
