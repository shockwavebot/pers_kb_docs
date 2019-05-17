# POST JSON data with Curl Command Line
curl -X POST -H "Content-Type: application/json" \
-d '{"ProductRdsId": "2559584", "businessDate": "2019-03-05", "clearingHouse": "MRK", "settlementLocation": "none", "state": "SOD"}'  \
http://hostname.dom.de:8080/clear/service/myServices/LoadProdWithIns/start
