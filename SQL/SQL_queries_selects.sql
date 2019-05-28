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

# found out in which table is the specific column
select column_name,table_name from information_schema.columns where column_name like '%customer%';

# inner join 
SELECT table1.name, table2.symbol 
FROM table1 INNER JOIN table2 ON table1.common_key=table2.common_key 
WHERE table2.status='ACTIVE' and table2.authorized='true' 
order by table1.name; 

# check the column data type 
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'temp';

# count values in a column 
SELECT
  category,
  COUNT(*) AS "num"
FROM
  posts
GROUP BY
  category
ORDER BY "num" DESC;

# finding duplicates 
SELECT id, name, COUNT(*) FROM table_name GROUP BY id, name HAVING COUNT(*) > 1;



