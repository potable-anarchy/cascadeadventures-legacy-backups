#!/bin/bash

# Cascade Adventures Legacy Database Backup Script
# This script creates timestamped backups of the SQLite databases

# Configuration
SOURCE_DIR="/home/brad/code/cascadeadventures-legacy/legacy-site/sqlite_db"
BACKUP_DIR="$(dirname "$0")/../backups/database/$(date +%Y)"
TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)

# Database files to backup
DATABASES=("cascadeadven.db" "chemekdb.db")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Starting database backup at $(date)"

# Backup each database
for db in "${DATABASES[@]}"; do
    if [ -f "$SOURCE_DIR/$db" ]; then
        backup_name="${TIMESTAMP}_${db}"
        cp "$SOURCE_DIR/$db" "$BACKUP_DIR/$backup_name"
        
        if [ $? -eq 0 ]; then
            echo "Successfully backed up $db as $backup_name"
            
            # Verify the backup (if sqlite3 is available)
            if command -v sqlite3 >/dev/null 2>&1; then
                if sqlite3 "$BACKUP_DIR/$backup_name" "PRAGMA integrity_check;" > /dev/null 2>&1; then
                    echo "Backup verification successful for $backup_name"
                else
                    echo "WARNING: Backup verification failed for $backup_name"
                fi
            else
                echo "Note: sqlite3 not available for verification, backup file copied successfully"
            fi
        else
            echo "ERROR: Failed to backup $db"
        fi
    else
        echo "WARNING: Database file $db not found in $SOURCE_DIR"
    fi
done

echo "Backup completed at $(date)"

# Optional: Remove backups older than 90 days (uncomment if needed)
# find "$BACKUP_DIR" -name "*.db" -mtime +90 -delete