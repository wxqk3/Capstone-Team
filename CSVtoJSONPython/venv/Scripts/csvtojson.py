import csv
import json
import pprint
from firebase import firebase

readFile = csv.DictReader(open('../../test.csv', 'r'))
dictionary = []
i = 0
for line in readFile:
    dictionary.append(line)

with open('../../test.json', 'w') as writeFile:
    json.dump(dictionary, writeFile, indent=2)

firebase = firebase.FirebaseApplication('https://telemetryapp-16f5d.firebaseio.com/')
result = firebase.post('user/Sean', dictionary)