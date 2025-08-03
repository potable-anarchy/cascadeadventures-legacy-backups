#!/bin/bash

# Cascade Adventures Legacy Database Restore Script
# This script restores a backup to the main application

# Configuration
BACKUP_DIR="$(dirname "$0")/../backups/database"
TARGET_DIR="/home/brad/code/cascadeadventures-legacy/legacy-site/sqlite_db"

# Function to display usage
usage() {
    echo "Usage: $0 <backup_file> [database_name]"
    echo ""
    echo "Examples:"
    echo "  $0 2025-08-03_143022_cascadeadven.db"
    echo "  $0 2025-08-03_143022_cascadeadven.db cascadeadven.db"
    echo ""
    echo "Available backups:"
    find "$BACKUP_DIR" -name "*.db" -type f | sort
    exit 1
}

# Check arguments
if [ $# -lt 1 ]; then
    usage
fi

BACKUP_FILE="$1"
TARGET_NAME="$2"

# Find the backup file
if [ ! -f "$BACKUP_FILE" ]; then
    # Try to find it in the backup directory structure
    FOUND_FILE=$(find "$BACKUP_DIR" -name "$BACKUP_FILE" -type f | head -1)
    if [ -n "$FOUND_FILE" ]; then
        BACKUP_FILE="$FOUND_FILE"
    else
        echo "ERROR: Backup file not found: $BACKUP_FILE"
        echo ""
        usage
    fi
fi

# Determine target filename
if [ -z "$TARGET_NAME" ]; then
    # Extract original database name from backup filename
    BASENAME=$(basename "$BACKUP_FILE")
    TARGET_NAME=$(echo "$BASENAME" | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_[0-9]\{6\}_//')
fi

TARGET_PATH="$TARGET_DIR/$TARGET_NAME"

echo "Restoring backup:"
echo "  Source: $BACKUP_FILE"
echo "  Target: $TARGET_PATH"
echo ""

# Verify backup integrity (if sqlite3 is available)
if command -v sqlite3 >/dev/null 2>&1; then
    echo "Verifying backup integrity..."
    if ! sqlite3 "$BACKUP_FILE" "PRAGMA integrity_check;" > /dev/null 2>&1; then
        echo "ERROR: Backup file appears to be corrupted"
        exit 1
    fi
    echo "Backup integrity check passed"
else
    echo "Note: sqlite3 not available for verification, proceeding with restore"
fi

# Create backup of current file if it exists
if [ -f "$TARGET_PATH" ]; then
    CURRENT_BACKUP="${TARGET_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Creating backup of current file: $CURRENT_BACKUP"
    cp "$TARGET_PATH" "$CURRENT_BACKUP"
fi

# Restore the backup
echo "Restoring database..."
cp "$BACKUP_FILE" "$TARGET_PATH"

if [ $? -eq 0 ]; then
    echo "Database restored successfully"
    echo ""
    echo "Please restart the cascadeadventures-legacy application to use the restored database"
else
    echo "ERROR: Failed to restore database"
    exit 1
fi