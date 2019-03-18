# Backup and restore 

RTO (between 2 locations) = 15min (How long is the downtime? )

RPO = 0min (How much data you can loose? )

http://www.interdb.jp/pg/pgsql10.html

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

`pg_resetxlog` -- reset the write-ahead log and other control information of a PostgreSQL database cluster

## Backup process 

### pg_start_backup

- Force into the full-page wirte mode.
- Switch to the current WAL segment file
- Do checkpoint.
- Create a backup_label file

```
START WAL LOCATION: CE/C000060 (file 00000013000000CE0000000C)
CHECKPOINT LOCATION: CE/C000098
BACKUP METHOD: streamed
BACKUP FROM: master
START TIME: 2019-03-14 15:39:42 UTC
LABEL: TT_BD20190314
```

### pg_stop_backup

- Reset to non-full-page writes mode if it has been forcibly changed by the pg_start_backup.
- Write a XLOG record of backup end.
- Switch the WAL segment file.
- Create a backup history file – This file contains the contents of the backup_label file and the timestamp that the pg_stop_backup has been executed.
- Delete the backup_label file – The backup_label file is required for recovery from the base backup and once copied, it is not necessary in the original database cluster.

## PITR procedure 

When PostgreSQL starts up, it enters into PITR mode if there are a recovery.conf and a backup_label in the database cluster.

#### To get the current timeline 

`SELECT substr(pg_xlogfile_name(pg_current_xlog_location()), 1, 8);` or check the WAL dir, pg_xlog dir, and see that are the latest WAL files named, as well, check the history file in WAL dir




