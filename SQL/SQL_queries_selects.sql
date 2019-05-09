# filter your columns
 SELECT col1, col2, col3, ... FROM table1
# filter the rows
 WHERE col4 = 1 AND col5 like '%blah%' AND col3 != 'nesto'
# aggregate the data
 GROUP by …
# limit aggregated data
 HAVING count(*) > 1
# order of the results
 ORDER BY col2

# DELETE AN ENTRY 
DELETE FROM table_name WHERE [condition];
SELECT * FROM tt_tab_test WHERE vistor_id <= 4; # to verify what will be deleted, if condition is OK 
DELETE FROM tt_tab_test WHERE vistor_id <= 4;

# value in range
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;

# display column names in a table 
select column_name from information_schema.columns where table_name = 'position';


