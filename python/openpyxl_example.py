# working with excel spreadsheets

# getting info from table in readonly mode
from openpyxl import load_workbook
wb = load_workbook(filename='spreadsheet_file.xlsx')
wb.sheetnames            # to get the tab or sheet names 
ws = wb['tab_name']
# search for a value in a cell 

def search_first(ws, val):
    for col in ws.iter_cols():
        for cell in col:
            if cell.value == val:
                return (cell.row, cell.column)
                  
def search_all(ws, val):
    result = []
    for col in ws.iter_cols():
        for cell in col:
            if cell.value == val:
                result.append((cell.row, cell.column))
    return result
