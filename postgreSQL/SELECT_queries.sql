# last 5 minutes 
select id, creation_time from ct_table where creation_time >= now() - interval '5 minutes';

# looking for a table name 
select tablename from pg_catalog.pg_tables where schemaname='public' and tablename like '%ins%';
select tablename from pg_catalog.pg_tables where tableowner='r_fxs09' and tablename like '%ins%';



