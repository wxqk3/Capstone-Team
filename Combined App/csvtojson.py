
import csv
from firebase import firebase
from time import gmtime, strftime, sleep
import sys
# from apscheduler.schedulers.background import BackgroundScheduler
def main():
    try:
        # for some reason the string in sys.argv[1] needs to be placed in a variable before it can be interpolated.
        # Can't pass directly to csv.DictReader

        # path passed from R
        path = sys.argv[1]

        # hardcoded path from filesystem
        # path = "../../test.csv"

        # Hardcoded usernames
        # username = "sbwzq8"
        # username = "aptyt7"

        # username passed from R
        username = sys.argv[2]

        # Create dictionary of key/value pairs from file
        # readFile = csv.DictReader(open("../test.csv"))
        readFile = csv.DictReader(open(path))
        dictionary = []

        upload = False
        liveData = True

        StartTime = 7400
        EndTime = 10000
        DictIndex = 0

        # Load all lines into dictionary
        for line in readFile:
            #28502
            if DictIndex >= StartTime and DictIndex <= EndTime:
                dictionary.append(line)
                # print(dictionary[DictIndex])
                # dictionary[DictIndex]["Time(ms)"] = str(int(float(dictionary[DictIndex]["Time(ms)"]) * 1000))
                # dictionary[DictIndex]["Time(s)"] = (float(dictionary[DictIndex]["Time(s)"]))
                for key in dictionary[DictIndex-StartTime]:
                    # print(key)
                    if dictionary[DictIndex-StartTime][key] == 'N/a':
                        dictionary[DictIndex-StartTime][key] = 0
                    else:
                        dictionary[DictIndex-StartTime][key] = float("{0:.2f}".format(float(dictionary[DictIndex-StartTime][key])))
                # print(dictionary[DictIndex])
                DictIndex = DictIndex+1
            elif DictIndex < StartTime:
                DictIndex = DictIndex+1
            else:
                break

        # Take every hundredth dictionary entry for every second
        wantedTimes = dictionary[0::100]
        sleepfactor = 0.82

        # Take every tenth dictionary entry for every tenth of a second
        # wantedTimes = dictionary[0::10]
        # sleepfactor = 0.00000001

        # Take every dictionary entry for every hundredth of a second
        # wantedTimes = dictionary

        # Create timestamp for run upload
        runStartTime = strftime("%m-%d-%Y %H:%M:%S", gmtime())

        # open connection to database
        url = "https://telemetryapp2.firebaseio.com"
        fb = firebase.FirebaseApplication(url, None)

        # Create path to users runs folder
        userPath = "user/" + username + "/runs/"

        # handle updating current run
        if liveData:
            i = 0
            for values in wantedTimes:
                result = fb.put(userPath, 'Current Run/'+str(i), values)
                i = i+1
                # sleep(sleepfactor)

        # save run under folder with start time
        if upload:
            result = fb.put(userPath, runStartTime, wantedTimes)

        # After 10 seconds remove current run from database
        if liveData:
            sleep(5)
            result = fb.delete(userPath, 'Current Run')

        # deprecated, don't need json
        # with open('../../test.json', 'w') as writeFile:
        #     json.dump(wantedTimes, writeFile, indent=2)
        #     print("Dumping Data")

    # in the event of an error(most likely firebase killing the connection)
    # tell firebase to delete the current run node.
    finally:
        result = fb.delete(userPath, 'Current Run')


if __name__ == "__main__":
    main()
