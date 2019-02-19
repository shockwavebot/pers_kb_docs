# last 5 minutes 
select id, creation_time from ct_table where creation_time >= now() - interval '5 minutes';

