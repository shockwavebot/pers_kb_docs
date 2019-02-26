# simple insert example
insert into table (field_1, field_2, field_3, date_time) values ('dummy1', 'dummy2', (select example from table where key='FILTER'), now());

# date time insert
current_timestamp at time zone 'Europe/Berlin'



