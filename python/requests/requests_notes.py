# to get response in seconds 
URL = 'http://localhost/app/service/validationservice'
requests.post(URL, json={'dummy':'dummy'}).elapsed.total_seconds()
