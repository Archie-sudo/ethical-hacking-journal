#!/bin/bash
# backup-config.sh
# Backs up key system config files with timestamped archives.
# Author: William Otakwa
# Date: 2025-08-10

set -euo pipefail

BACKUP_DIR="$HOME/backups/$(date +%Y-%m-%d_%H-%M-%S)"
mkdir -p "$BACKUP_DIR"

echo "Backing up important config files to $BACKUP_DIR"

CONFIG_FILES=(
  "/etc/ssh/sshd_config"
  "/etc/passwd"
  "/etc/group"
  "/etc/sudoers"
  "/etc/fstab"
  "/etc/network/interfaces"
)

for file in "${CONFIG_FILES[@]}"; do
  if [[ -f "$file" ]]; then
    cp -v "$file" "$BACKUP_DIR/"
  else
    echo "Warning: $file not found, skipping."
  fi
done

echo "Backup complete."
