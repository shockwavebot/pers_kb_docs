#!/bin/bash
# postgresql cheat sheet https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546

\q: Quit/Exit
\l: List databases
\du: List roles(users)
\dn: List schemas
\dt *.*: List tables from all schemas
psql -h 10.1.1.2 -p 10902 -U username db_name -c "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_catalog='db_name' ORDER BY 1;"
\d __table__: Show table definition including triggers
\c __database__: Connect to a database

# UBUNTU client installation
sudo apt-get install postgresql-client

# connect to server/db
psql -h server.domain.org database user

# UBUNTU INSTALLATION
sudo apt-get install postgresql postgresql-contrib
# switch to postgres user
sudo -i -u postgres
# login to the cli
psql
# quit the cli
\q
# create a new role (from bass)
createuser --interactive
# setup pass
sudo -u postgres psql postgres
\password postgres
# create db
sudo -u postgres createdb mydb
# connect to a specific db (from linux user that is the same as user created in psql)
psql -d mydb

# EXAMPLE" 
# mstan@tpdev:~$ psql -d mytestdb
# psql (10.6 (Ubuntu 10.6-0ubuntu0.18.04.1))
# Type "help" for help.
# mytestdb=# \conninfo
# You are connected to database "mytestdb" as user "mstan" via socket in "/var/run/postgresql" at port "5432".

# creating a table 
CREATE TABLE playground (
    equip_id serial PRIMARY KEY,
    type varchar (50) NOT NULL,
    color varchar (25) NOT NULL,
    location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')),
    install_date date,
    date_time timestamp
);

# drop/delete a rable 
DROP TABLE IF EXISTS table_name;

# Check DB/table size
SELECT pg_size_pretty( pg_database_size('dbname') );
SELECT pg_size_pretty( pg_total_relation_size('tablename') );

# Vacuum - reclaiming space used by updated data, Analyze optimizes for query  
select name, setting from pg_settings where name = 'autovacuum';
VACUUM(FULL, ANALYZE, VERBOSE) [tablename]

# Force switch to a new transaction log file (restricted to superusers)
select pg_switch_xlog();

# Looking for table with specific column
select table_name, column_name from information_schema.columns where column_name like '%order%';

# time, checking, querying the current time
select now();
select current_date;
select current_time;

# setting configuring log level : change postgresql.conf
log_min_messages = debug1

# get number of rows, count rows, count table entries
SELECT COUNT(*) FROM TABLE_NAME;



