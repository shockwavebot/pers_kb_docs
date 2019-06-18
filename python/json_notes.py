# load json from file 
with open('file.json') as json_file:
    req_data = json.load(json_file)
    
# pretty pring of json 
import json
ugly_json = '{...}'
parsed = json.loads(ugly_json)
print(json.dumps(parsed, indent=2, sort_keys=True))
