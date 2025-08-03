# Cascade Adventures Legacy - Database Backups

This repository serves as the centralized backup storage for SQLite databases from the [cascadeadventures-legacy](https://github.com/potable-anarchy/cascadeadventures-legacy) application.

## Purpose

The Cascade Adventures Legacy site contains historical data about mountaineering activities, trip reports, participant information, and climbing school records. This backup repository ensures that the valuable SQLite database content is preserved with proper versioning and timestamped snapshots.

## Repository Structure

```
cascadeadventures-legacy-backups/
├── README.md                    # This file
├── backups/
│   └── database/
│       ├── 2024/               # Database backups from 2024
│       ├── 2025/               # Database backups from 2025
│       └── archive/            # Older backups for long-term storage
├── scripts/                    # Backup automation scripts
└── documentation/              # Backup procedures and recovery guides
```

## Database Files Backed Up

The main cascadeadventures-legacy application contains two primary SQLite databases:

1. **cascadeadven.db** - Main application database containing:
   - Trip information and scheduling
   - Participant records
   - Activity and route data
   - Administrative records

2. **chemekdb.db** - Chemeketan club-specific database containing:
   - Club member information
   - Historical trip data
   - Legacy records

## Backup Naming Convention

Database backups follow this naming convention:
```
YYYY-MM-DD_HHMMSS_database-name.db
```

Examples:
- `2024-08-03_143022_cascadeadven.db`
- `2024-08-03_143022_chemekdb.db`

## Directory Organization

### Annual Directories
- Backups are organized by year (`2024/`, `2025/`, etc.)
- Each year contains monthly subdirectories as needed
- Critical milestone backups may be stored in dedicated subdirectories

### Archive Directory
- Contains backups older than 2 years
- Compressed backups for space efficiency
- Maintains at least quarterly snapshots for historical reference

## Backup Frequency

- **Daily**: Automated backups during low-traffic hours
- **Pre-deployment**: Before any application updates or migrations
- **Monthly**: Verified snapshots for long-term retention
- **Major milestones**: Before significant data migrations or system changes

## Recovery Procedures

### Quick Recovery
1. Download the desired backup file from the appropriate date directory
2. Stop the cascadeadventures-legacy application
3. Replace the target database file in `legacy-site/sqlite_db/`
4. Restart the application
5. Verify data integrity

### Point-in-Time Recovery
1. Identify the backup closest to the desired recovery point
2. Follow the quick recovery procedure
3. Review application logs for any data consistency issues
4. Test critical application functions

## Backup Verification

Each backup includes:
- File size verification
- SQLite integrity checks
- Schema validation
- Sample data verification

## Security Considerations

- Backups may contain sensitive participant information
- Access to this repository should be limited to authorized administrators
- Regular security audits of backup access logs
- Encryption for sensitive backup data when required

## Automation Scripts

The `scripts/` directory contains:
- `backup.sh` - Main backup automation script
- `verify.sh` - Backup integrity verification
- `cleanup.sh` - Automated cleanup of old backups
- `restore.sh` - Simplified restore procedures

## Related Repositories

- **Main Application**: [cascadeadventures-legacy](https://github.com/potable-anarchy/cascadeadventures-legacy)
- **Documentation**: See the main repository for application documentation

## Maintenance

- Review backup retention policies quarterly
- Test restore procedures monthly
- Update automation scripts as needed
- Monitor storage usage and implement cleanup as required

## Contact

For questions about backups or recovery procedures, please refer to the main cascadeadventures-legacy repository or contact the repository administrators.

---

**Last Updated**: August 3, 2025
**Backup Repository Version**: 1.0