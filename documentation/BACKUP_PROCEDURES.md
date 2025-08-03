# Backup and Recovery Procedures

## Quick Reference

### Create a Manual Backup
```bash
cd cascadeadventures-legacy-backups
./scripts/backup.sh
```

### Restore from Backup
```bash
cd cascadeadventures-legacy-backups
./scripts/restore.sh 2025-08-03_143022_cascadeadven.db
```

### List Available Backups
```bash
find backups/database -name "*.db" -type f | sort
```

## Detailed Procedures

### Manual Backup Process

1. **Navigate to the backup repository**:
   ```bash
   cd /home/brad/code/cascadeadventures-legacy-backups
   ```

2. **Run the backup script**:
   ```bash
   ./scripts/backup.sh
   ```

3. **Verify the backup was created**:
   ```bash
   ls -la backups/database/$(date +%Y)/
   ```

### Automated Backup Setup

To set up automated daily backups, add this to your crontab:

```bash
# Daily backup at 2 AM
0 2 * * * cd /home/brad/code/cascadeadventures-legacy-backups && ./scripts/backup.sh >> logs/backup.log 2>&1
```

### Recovery Procedures

#### Full System Recovery

1. **Stop the application** (if running)
2. **Identify the backup to restore from**:
   ```bash
   find backups/database -name "*.db" | sort
   ```

3. **Restore the databases**:
   ```bash
   ./scripts/restore.sh YYYY-MM-DD_HHMMSS_cascadeadven.db
   ./scripts/restore.sh YYYY-MM-DD_HHMMSS_chemekdb.db
   ```

4. **Restart the application**
5. **Verify functionality**

#### Partial Recovery (Single Database)

1. **Identify the specific backup needed**
2. **Restore only the required database**:
   ```bash
   ./scripts/restore.sh YYYY-MM-DD_HHMMSS_cascadeadven.db cascadeadven.db
   ```

3. **Test the application**

### Backup Verification

#### Manual Verification
```bash
sqlite3 backup_file.db "PRAGMA integrity_check;"
```

#### Automated Verification
The backup script includes automatic integrity checks. Review the backup logs for any verification failures.

### Troubleshooting

#### Common Issues

1. **Permission Errors**
   - Ensure scripts are executable: `chmod +x scripts/*.sh`
   - Check file permissions on backup directories

2. **Disk Space Issues**
   - Monitor backup directory size
   - Clean up old backups if needed
   - Consider compressing older backups

3. **Database Lock Errors**
   - Ensure the application is not heavily loaded during backup
   - Consider scheduling backups during low-traffic periods

4. **Corrupted Backups**
   - Check source database integrity before backup
   - Verify backup immediately after creation
   - Keep multiple backup copies

#### Recovery Testing

Regularly test the recovery process:

1. **Create a test environment**
2. **Restore from a recent backup**
3. **Verify all application functions work correctly**
4. **Document any issues or improvements needed**

### Best Practices

1. **Regular Testing**: Test restore procedures monthly
2. **Multiple Copies**: Keep backups in multiple locations if possible
3. **Documentation**: Keep this documentation updated
4. **Monitoring**: Set up alerts for backup failures
5. **Retention**: Follow the retention policy outlined in the main README

### Emergency Contacts

- Repository Administrator: [Contact information]
- Application Developer: [Contact information]
- System Administrator: [Contact information]