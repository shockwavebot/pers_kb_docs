# simple update example 
update my_table set colomn_value='YES' where colomn_key='NEW_VALUE';

# insert new row
insert into table (field_1, field_2, field_3, date_time) values ('dummy1', 'dummy2', (select example from table where key='FILTER'), now());
