import requests

# to get response in seconds 
URL = 'http://localhost/app/service/validationservice'
requests.post(URL, json={'dummy':'dummy'}).elapsed.total_seconds()

# send post request 
rsponse = requests.post(URL, json=JSON_DATA)

####################################################################################
# AUTH LOGIN
import requests, json, os
session = requests.Session()

USER = os.environ.get("USER")
PASS = os.environ.get("PASS")
url = "https://myweb.dom/login"
headers = {"Connection": "keep-alive",
"Origin": "https://myweb.dom",
"Content-Type": "application/json",
"Accept": "application/json, text/plain, */*",
"X-Requested-With": "artUI",
"Request-Agent": "artifactoryUI",
"Sec-Fetch-Site": "same-origin",
"Sec-Fetch-Mode": "cors",
"Referer": "https://myweb.dom/webapp/",
"Accept-Encoding": "gzip, deflate, br",
"Accept-Language": "en-US,en;q=0.9,sr;q=0.8"}
payload = {"user":USER, "password":PASS, "type":"login"}

response = session.post(url, data=json.dumps(payload), headers=headers)
####################################################################################
