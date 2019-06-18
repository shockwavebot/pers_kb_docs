import requests

# to get response in seconds 
URL = 'http://localhost/app/service/validationservice'
requests.post(URL, json={'dummy':'dummy'}).elapsed.total_seconds()

# send post request 
rsponse = requests.post(URL, json=JSON_DATA)
