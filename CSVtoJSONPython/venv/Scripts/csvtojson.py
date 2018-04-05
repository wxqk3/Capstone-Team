import csv
# import json
from firebase import firebase
from time import gmtime, strftime, sleep

# Create dictionary of key/value pairs from file
readFile = csv.DictReader(open('../../test.csv', 'r'))
dictionary = []

MaxTime = 0
# Load all lines into dictionary
for line in readFile:
    if MaxTime > 1000:
        break
    else:
        dictionary.append(line)
    MaxTime = MaxTime+1
# Take every tenth dictionary entry for every tenth of a second
wantedTimes = dictionary[0::10]

print("Done reading at MaxTime =" + str(MaxTime))

# Create timestamp for run upload
runStartTime = strftime("%m-%d-%Y %H:%M:%S", gmtime())

# open connection to database
url = "https://telemetryapp-16f5d.firebaseio.com"
fb = firebase.FirebaseApplication(url, None)

# username and path to user for database
username = "sbwzq8"
userPath = "user/" + username + "/runs/"


# handle updating current run
for values in wantedTimes:
    # result = fb.put('SeansPlayground/Sean/', 'Current Run', values)
    result = fb.put(userPath, 'Current Run', values)
    sleep(.01)

# save run under folder with start time
result = fb.put(userPath, runStartTime, wantedTimes)

# After 10 seconds remove current run
sleep(10)
result = fb.delete(userPath, 'Current Run')




# deprecated, don't need json
# with open('../../test.json', 'w') as writeFile:
#     json.dump(wantedTimes, writeFile, indent=2)
#     print("Dumping Data")