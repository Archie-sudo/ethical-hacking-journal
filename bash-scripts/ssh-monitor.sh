#!/bin/bash
# ssh-monitor.sh
# Extracts recent SSH login attempts and current sessions.
# Author: William  Otakwa
# Date: 2025-08-10

set -euo pipefail

LOGFILE="/var/log/auth.log"
if [[ ! -f "$LOGFILE" ]]; then
  LOGFILE="/var/log/secure"  # fallback for some distros
fi

echo "=== SSH Access Monitor ==="
echo -e "\nFailed SSH login attempts in the last 24 hours:"
grep "Failed password" "$LOGFILE" | grep "$(date --date='1 day ago' '+%b %e')" || echo "No failed attempts found."

echo -e "\nSuccessful SSH logins in the last 24 hours:"
grep "Accepted password" "$LOGFILE" | grep "$(date --date='1 day ago' '+%b %e')" || echo "No successful logins found."

echo -e "\nCurrent active SSH sessions:"
sshd_pids=$(pgrep sshd) || true
if [[ -n "$sshd_pids" ]]; then
  who | grep pts || echo "No active SSH sessions."
else
  echo "sshd service appears not running."
fi

echo -e "\nMonitor complete."
