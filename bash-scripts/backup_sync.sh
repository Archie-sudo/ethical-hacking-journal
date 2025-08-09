#!/usr/bin/env bash
#
# backup_sync.sh - A professional backup & sync utility
# Author: William Otakwa (Day 3 Bash Scripting)
# Version: 1.0
# License: MIT
#
# Description:
#   This script backs up files from a source directory to a destination,
#   with optional compression, logging, and dry-run support.
#
# Usage:
#   ./backup_sync.sh -s /path/to/source -d /path/to/dest [-c] [-n]
#
#   -s   Source directory (required)
#   -d   Destination directory (required)
#   -c   Compress backup into a tar.gz archive
#   -n   Dry-run (simulate without making changes)
#   -h   Show help
#

# ================================
#          CONFIGURATION
# ================================

CONFIG_FILE="./backup_sync.conf"
LOG_FILE="./backup_sync.log"

# Load external configuration if present
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# Default values (can be overridden by config file)
COMPRESS_BACKUP=${COMPRESS_BACKUP:-false}
DRY_RUN=${DRY_RUN:-false}

# ================================
#          ERROR HANDLING
# ================================

set -o errexit   # Exit on command errors
set -o nounset   # Exit on unset variables
set -o pipefail  # Catch errors in piped commands

trap 'echo "[ERROR] An unexpected error occurred. Exiting." >&2; exit 1' ERR
trap 'echo "[INFO] Script interrupted." >&2; exit 2' INT

# ================================
#          FUNCTIONS
# ================================

usage() {
    grep '^#' "$0" | sed 's/^#//'
    exit 0
}

log() {
    local level="$1"; shift
    local msg="$*"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $msg" | tee -a "$LOG_FILE"
}

validate_dirs() {
    if [[ ! -d "$SRC_DIR" ]]; then
        log "ERROR" "Source directory does not exist: $SRC_DIR"
        exit 1
    fi

    if [[ ! -d "$DEST_DIR" ]]; then
        log "INFO" "Destination directory does not exist. Creating..."
        $DRY_RUN || mkdir -p "$DEST_DIR"
    fi
}

perform_backup() {
    log "INFO" "Starting backup from $SRC_DIR to $DEST_DIR"

    if [[ "$COMPRESS_BACKUP" == true ]]; then
        local archive_name="backup_$(date +'%Y%m%d_%H%M%S').tar.gz"
        if [[ "$DRY_RUN" == true ]]; then
            log "INFO" "Dry-run: would compress $SRC_DIR into $DEST_DIR/$archive_name"
        else
            tar -czf "$DEST_DIR/$archive_name" -C "$SRC_DIR" .
            log "INFO" "Backup compressed as $archive_name"
        fi
    else
        if [[ "$DRY_RUN" == true ]]; then
            log "INFO" "Dry-run: would sync files..."
        else
            rsync -av --delete "$SRC_DIR"/ "$DEST_DIR"/
            log "INFO" "Files synced successfully"
        fi
    fi
}

# ================================
#          ARGUMENT PARSING
# ================================

while getopts ":s:d:cnh" opt; do
    case "$opt" in
        s) SRC_DIR="$OPTARG" ;;
        d) DEST_DIR="$OPTARG" ;;
        c) COMPRESS_BACKUP=true ;;
        n) DRY_RUN=true ;;
        h) usage ;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
    esac
done

# Ensure required args are present
if [[ -z "${SRC_DIR:-}" || -z "${DEST_DIR:-}" ]]; then
    log "ERROR" "Source (-s) and destination (-d) are required."
    usage
fi

# ================================
#          EXECUTION
# ================================

log "INFO" "Backup script started"
validate_dirs
perform_backup
log "INFO" "Backup script completed successfully"

exit 0
