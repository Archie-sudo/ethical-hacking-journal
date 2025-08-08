#!/usr/bin/env bash

#===========================================================
# Script Name : system_info.sh
# Description : Displays detailed system information
# Author      : Archie-sudo
# Date        : 2025-08-08
# Usage       : ./system_info.sh
#===========================================================

set -e  # Exit on any error

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}==========================================${RESET}"
echo -e "${GREEN}   SYSTEM INFORMATION REPORT   ${RESET}"
echo -e "${CYAN}==========================================${RESET}"

# Hostname
echo -e "${GREEN}Hostname:${RESET} $(hostname)"

# OS and Kernel
echo -e "${GREEN}OS:${RESET} $(uname -s)"
echo -e "${GREEN}Kernel Version:${RESET} $(uname -r)"

# Uptime
echo -e "${GREEN}Uptime:${RESET} $(uptime -p)"

# Logged-in Users
echo -e "${GREEN}Logged-in Users:${RESET}"
who

# Disk Usage
echo -e "${GREEN}Disk Usage:${RESET}"
df -h --total | grep total

# Memory Usage
echo -e "${GREEN}Memory Usage:${RESET}"
free -h

# IP Address
echo -e "${GREEN}IP Address:${RESET} $(hostname -I | awk '{print $1}')"

# End of Report
echo -e "${CYAN}==========================================${RESET}"
echo -e "${GREEN}Report generated on:${RESET} $(date)"
echo -e "${CYAN}==========================================${RESET}"
