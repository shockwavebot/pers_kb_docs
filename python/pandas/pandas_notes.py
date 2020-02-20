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
df = pd.read_csv("data_table_example.csv", sep=";")
df = pd.read_csv("data_table_example.csv", header = None) # if there is no header in the file 
df.columns = ["ID", "Name", "City"] # to name columns when header is missing
df.set_index("Index_Column", inplace=True, drop=False) # use table culumn as index instead of interal panda row number 

# slice and extract data from data frame 
df.loc[from:to, from:to] # labels
df.iloc[from:to, from:to] # indexes

# delete from data frame
df.drop()

# check column/header values 
df.columns.values

# add column with default value 
df["new_column_name"] = "default_value"

# save data frame to csv file 
df.to_csv("new_csv_file")

