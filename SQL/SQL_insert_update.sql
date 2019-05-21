# simple update example 
update my_table set colomn_value='YES' where colomn_key='NEW_VALUE';

# insert new row
insert into table (field_1, field_2, field_3, date_time) values ('dummy1', 'dummy2', (select example from table where key='FILTER'), now());

# copy rows from the same table with updated values 
SELECT * INTO temp FROM SourceTable WHERE col1='value';
UPDATE temp SET col1 = 'value', col2='value';
INSERT INTO SourceTable (col1, col2, col3)
    SELECT col1, col2, col3 FROM temp;
DELETE temp;
