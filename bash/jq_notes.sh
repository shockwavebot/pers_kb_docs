
# extract raw string value from json file 
jq -r ".key_name" file.json

# python alternative 
cat file.json | python2 -c "import sys, json; print json.load(sys.stdin)['name']"
