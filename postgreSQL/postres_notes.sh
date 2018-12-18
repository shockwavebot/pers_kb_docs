#!/bin/bash
# postgresql cheat sheet https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546

\q: Quit/Exit
\l: List databases
\du: List users
\dn: List schemas
\dt *.*: List tables from all schemas
\d __table__: Show table definition including triggers
\c __database__: Connect to a database

# UBUNTU client installation
sudo apt-get install postgresql-client

# connect to server/db
psql -h server.domain.org database user

# UBUNTU INSTALLATION
sudo apt-get install postgresql postgresql-contrib
# setup pass
sudo -u postgres psql postgres
\password postgres
# create db
sudo -u postgres createdb mydb
