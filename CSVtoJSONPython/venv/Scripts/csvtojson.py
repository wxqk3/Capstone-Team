import csv
import json
import pprint

readFile = csv.DictReader(open('../../test.csv', 'r'))
dictionary = []
for line in readFile:
    dictionary.append(line)

with open('../../test.json', 'w') as writeFile:
    json.dump(dictionary, writeFile, indent=2)

# class node:
#     time = ""
#     longAccel = ""
#     latAccel = ""
#     vectorAccel = ""
#     vertAccel = ""
#     rpm = ""
#     speed = ""
#     wheelSpeed = ""
#     distance = ""
#     powerOutput = ""
#     torqueOutput = ""
#     gear = ""
#     positionX = ""
#     positionY = ""
#     timeSlip = ""
#     timeSlipRate = ""
#     cornerRadius = ""
#     yawRate = ""
#     rollRate = ""
#     buffer = ""
#     flpot = ""
#     frpot = ""
#     rrpot = ""
#     rlpot = ""
#     analog5 = ""
#     analog6 = ""
#     analog7 = ""
#     analog8 = ""
#     analog9 = ""
#     analog20 = ""
#     analog29 = ""
#     analog30 = ""
#     analog31 = ""
#     analog32 = ""
#     flws = ""
#     frws = ""
#     rlws = ""
#     rrws = ""
#     gpsAltitude = ""
#     gpsHeading = ""
#     gpsTime = ""
#     gpsPosAcc = ""
#     gpsVelAcc = ""
#     gpsHeadAcc = ""
#     gpsAltAcc = ""
#     gpsVelRaw = ""
#     gpsLong = ""
#     gpsLat = ""
#     temperature1 = ""
#     waterTemp = ""
#     gearboxPostCooler = ""
#     exhaust1Temp = ""
#     exhaust2Temp = ""
#     exhaust3Temp = ""
#     exhaust4Temp = ""
#     throttlePosition = ""
#     fuelInj1PW = ""
#     auxiliary1 = ""
#     ignitionAngle = ""
#     steeringAngle = ""
#     ambientAirPressure = ""
#     boostPressure = ""
#     lambda1 = ""
#     batteryVoltage = ""
#     flShockVelo = ""
#     frShockVelo = ""
#     rlShockVelo = ""
#     rrShockVelo = ""
#     flWheelPos = ""
#     frWheelPos = ""
#     rlWheelPosition = ""
#     rrWheelPosition = ""
#     slipRL = ""
#     slipRR = ""
#     longSlip = ""
#     hpAtWheels = ""
#     brakeBias = ""
#     combinedG = ""
#     deltaT = ""
#     simLongAccel = ""
#     simLatAccel = ""
#     simSpeed = ""
#     simPowerOutput = ""
#     simGear = ""
#     simTimeSlip = ""
#     simTimeSlipRate = ""
#
#     def __init__(self):
#         self.time = ""
#         self.longAccel = ""
#         self.latAccel = ""
#         self.vectorAccel = ""
#         self.vertAccel = ""
#         self.rpm = ""
#         self.speed = ""
#         self.wheelSpeed = ""
#         self.distance = ""
#         self.powerOutput = ""
#         self.torqueOutput = ""
#         self.gear = ""
#         self.positionX = ""
#         self.positionY = ""
#         self.timeSlip = ""
#         self.timeSlipRate = ""
#         self.cornerRadius = ""
#         self.yawRate = ""
#         self.rollRate = ""
#         self.buffer = ""
#         self.flpot = ""
#         self.frpot = ""
#         self.rrpot = ""
#         self.rlpot = ""
#         self.analog5 = ""
#         self.analog6 = ""
#         self.analog7 = ""
#         self.analog8 = ""
#         self.analog9 = ""
#         self.analog20 = ""
#         self.analog29 = ""
#         self.analog30 = ""
#         self.analog31 = ""
#         self.analog32 = ""
#         self.flws = ""
#         self.frws = ""
#         self.rlws = ""
#         self.rrws = ""
#         self.gpsAltitude = ""
#         self.gpsHeading = ""
#         self.gpsTime = ""
#         self.gpsPosAcc = ""
#         self.gpsVelAcc = ""
#         self.gpsHeadAcc = ""
#         self.gpsAltAcc = ""
#         self.gpsVelRaw = ""
#         self.gpsLong = ""
#         self.gpsLat = ""
#         self.temperature1 = ""
#         self.waterTemp = ""
#         self.gearboxPostCooler = ""
#         self.exhaust1Temp = ""
#         self.exhaust2Temp = ""
#         self.exhaust3Temp = ""
#         self.exhaust4Temp = ""
#         self.throttlePosition = ""
#         self.fuelInj1PW = ""
#         self.auxiliary1 = ""
#         self.ignitionAngle = ""
#         self.steeringAngle = ""
#         self.ambientAirPressure = ""
#         self.boostPressure = ""
#         self.lambda1 = ""
#         self.batteryVoltage = ""
#         self.flShockVelo = ""
#         self.frShockVelo = ""
#         self.rlShockVelo = ""
#         self.rrShockVelo = ""
#         self.flWheelPos = ""
#         self.frWheelPos = ""
#         self.rlWheelPosition = ""
#         self.rrWheelPosition = ""
#         self.slipRL = ""
#         self.slipRR = ""
#         self.longSlip = ""
#         self.hpAtWheels = ""
#         self.brakeBias = ""
#         self.combinedG = ""
#         self.deltaT = ""
#         self.simLongAccel = ""
#         self.simLatAccel = ""
#         self.simSpeed = ""
#         self.simPowerOutput = ""
#         self.simGear = ""
#         self.simTimeSlip = ""
#         self.simTimeSlipRate = ""
#
#
#     def populate(self, values):
#         i = 0
#         for f, k in self.__dict__.items():
#             self.__setattr__(f,values[i])
#             i = i+1
#
#
#     def listProperties(self):
#         for f, k in self.__dict__.items():
#             print("f is",f,"k is",k)
#
# def writeNode(thisNode, fieldsArray, file):
#     # start object
#     file.writelines("\t{\n")
#     values = []
#     i = 0
#     # create list for node values
#     for f, k in thisNode.__dict__.items():
#         values.append(k)
#     for field in fieldsArray:
#         # if not last field, print key value pair in json format, append , inbetween
#         if field != fieldsArray.__getitem__(len(fieldsArray) - 1):
#             file.writelines("\t\t\"" + fieldsArray[i] + "\": " + "\"" + values[i] + "\",\n")
#             i = i+1
#         # if last field, print key value pair, dont append comma, close object
#         else:
#             file.write("\t\t\"" + fieldsArray[i] + "\": " + "\"" + values[i].rstrip() + "\"\n\t}")

# # store nodes in this list
# nodesArray = []
#
# with open("../../test.csv", "r") as f:
#     fieldsArray = f.readline().split(',')
#     fieldsArray[len(fieldsArray) - 1] = fieldsArray.__getitem__(len(fieldsArray) - 1).rstrip()
#     # print(fieldsArray)
#     # read each line, create array by splitting line at ',' and populate node with array
#     for line in f:
#         values = line.split(",")
#         newNode = node()
#         newNode.populate(values)
#         # add note to list of nodes
#         nodesArray.append(newNode)
# print("End file Read")
#
# with open("../../test.json", "w") as file:
#     # start json array
#     file.writelines("[\n")
#     # write each node to file in json format
#     for node in nodesArray:
#         # if not last node, append comma and newline
#         if nodesArray.index(node) != len(nodesArray) - 1:
#             writeNode(node, fieldsArray, file)
#             file.writelines(",\n")
#         # if last node, append newline and close json array
#         else:
#             writeNode(node, fieldsArray, file)
#             file.writelines("\n]")
# print("End file write")