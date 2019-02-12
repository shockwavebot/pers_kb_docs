# Backup and restore 

RTO (between 2 locations) = 15min (How long is the downtime? )

RPO = 0min (How much data you can loose? )

## Backup config 

DB data directory: `/var/lib/ppas/<DB_NAME>/9.6/data/`

DB configuration file: `/var/lib/ppas/<DB_NAME>/9.6/data/postgresql.conf`

```
wal_level = hot_standby
checkpoint_timeout = 15min
archive_mode = on
archive_command = '/path/to/your/backup/script/archiver.sh %p %f <ARG1> <ARGn>'
max_wal_senders = 3
```

DB base dir: `/var/lib/ppas/<DB_NAME>/9.6/data/`

Base backup location: `/path/to/base/backup/location/`

WAL location: `/var/lib/ppas/<DB_NAME>/9.6/data/pg_xlog`

WAL archive location: `/path/to/WAL/archive/location/`

## PITR procedure 

