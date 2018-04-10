import csv
# import json
from firebase import firebase
from time import gmtime, strftime, sleep
import collections

# Create dictionary of key/value pairs from file
readFile = csv.DictReader(open('../../test.csv', 'r'))
dictionary = []

MaxTime = 0
# Load all lines into dictionary
for line in readFile:
    if MaxTime < 500:
        dictionary.append(line)
        # print(dictionary[MaxTime])
        dictionary[MaxTime]["Time(ms)"] = str(int(float(dictionary[MaxTime]["Time(ms)"]) * 1000))
        MaxTime = MaxTime+1
    else:
        break

# for entry in dictionary:
#     print(entry)

# Take every tenth dictionary entry for every tenth of a second
# wantedTimes = dictionary[0::10]
wantedTimes = dictionary
wantedTimes = range(dictionary[500], dictionary[1000])
# print(dictionary)
# print("Done reading at MaxTime =" + str(MaxTime))

# Create timestamp for run upload
runStartTime = strftime("%m-%d-%Y %H:%M:%S", gmtime())

# open connection to database
url = "https://telemetryapp-16f5d.firebaseio.com"
fb = firebase.FirebaseApplication(url, None)

# username and path to user for database
username = "aptyt7"
userPath = "user/" + username + "/runs/"

liveData = False

# handle updating current run
if liveData:
    i = 0
    for values in wantedTimes:
        # result = fb.put('SeansPlayground/Sean/', 'Current Run', values)
        result = fb.put(userPath, 'Current Run/'+str(i), values)

        i = i+1
        sleep(.1)

# save run under folder with start time
# result = fb.put(userPath, runStartTime, wantedTimes)

# print(runStartTime)

# fb.delete(userPath, '')

# After 10 seconds remove current run from database
if liveData:
    sleep(10)
    result = fb.delete(userPath, 'Current Run')




# deprecated, don't need json
# with open('../../test.json', 'w') as writeFile:
#     json.dump(wantedTimes, writeFile, indent=2)
#     print("Dumping Data")