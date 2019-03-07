# working with excel spreadsheets

# getting info from table in readonly mode
from openpyxl import load_workbook
wb = load_workbook(filename='spreadsheet_file.xlsx')
wb.sheetnames            # to get the tab or sheet names 
ws = wb['tab_name']
# search for a value in a cell 
