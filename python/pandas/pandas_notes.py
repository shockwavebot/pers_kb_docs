# install: pip3 install pandas

import pandas as pd 

# creating data frame 
>>> df = pd.DataFrame([[1,2,3],[4,5,6],[7,8,9]], columns=["Col_1","Col_2","Col_3"])
>>> df
   Col_1  Col_2  Col_3
0      1      2      3
1      4      5      6
2      7      8      9

>>> df = pd.DataFrame([{"Name":"Yoda", "Age": 735},{"Name":"Luke"}])
>>> df
     Age  Name
0  735.0  Yoda
1    NaN  Luke

# read from csv file 
df = pd.read_csv("data_table_example.csv")

