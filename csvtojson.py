# change time to seconds
# change key Time to lowercase time
# vertical acceleration
# auxilliary, flpot, frpot, rrpot, rlpot, gps time, gearbox post cooler, throttle pos
import csv
# import json
from firebase import firebase
from time import gmtime, strftime, sleep
import collections
import sys

def main():
    # for some reason the sys.argv[1] needs to be placed in a string.
    # Can't pass directly to csv.DictReader
    path = sys.argv[1]

    # Create dictionary of key/value pairs from file
    # readFile = csv.DictReader(open("../test.csv"))
    readFile = csv.DictReader(open(path))
    dictionary = []

    upload = True
    liveData = False

    MaxTime = 0
    # Load all lines into dictionary
    for line in readFile:
        #28502
        if MaxTime < 100:
            dictionary.append(line)
            # print(dictionary[MaxTime])
            # dictionary[MaxTime]["Time(ms)"] = str(int(float(dictionary[MaxTime]["Time(ms)"]) * 1000))
            # dictionary[MaxTime]["Time(s)"] = (float(dictionary[MaxTime]["Time(s)"]))
            for key in dictionary[MaxTime]:
                # print(key)
                if dictionary[MaxTime][key] == 'N/a':
                    dictionary[MaxTime][key] = 0
                else:
                    dictionary[MaxTime][key] = float("{0:.2f}".format(float(dictionary[MaxTime][key])))
            # print(dictionary[MaxTime])
            MaxTime = MaxTime+1
        else:
            break



    # for entry in dictionary:
    #     print(entry)

    # Take every tenth dictionary entry for every tenth of a second
    # wantedTimes = dictionary[0::10]

    wantedTimes = dictionary

    # print(wantedTimes)

    # for sub in wantedTimes:
    #     for key in sub:
    #         sub[key] = int(sub[key])

    # Create timestamp for run upload
    runStartTime = strftime("%m-%d-%Y %H:%M:%S", gmtime())

    # open connection to database
    url = "https://telemetryapp-16f5d.firebaseio.com"
    fb = firebase.FirebaseApplication(url, None)

    # username and path to user for database
    # username = "sbwzq8"
    username = sys.argv[2]
    userPath = "user/" + username + "/runs/"

    # handle updating current run
    if liveData:
        i = 0
        for values in wantedTimes:
            # result = fb.put('SeansPlayground/Sean/', 'Current Run', values)
            result = fb.put(userPath, 'Current Run/'+str(i), values)

            i = i+1
            sleep(.5)

    # save run under folder with start time
    if upload:
        result = fb.put(userPath, runStartTime, wantedTimes)

    # fb.delete(userPath, '')

    # After 10 seconds remove current run from database
    if liveData:
        sleep(10)
        result = fb.delete(userPath, 'Current Run')




    # deprecated, don't need json
    # with open('../../test.json', 'w') as writeFile:
    #     json.dump(wantedTimes, writeFile, indent=2)
    #     print("Dumping Data")
if __name__ == "__main__":
    main()
