import serial
from xbee import XBee, ZigBee

serial_port = serial.Serial('COM28', 115200)
xbee = ZigBee(serial_port)

while True:
    try:
        frame = xbee.wait_read_frame()
        print  (frame["rf_data"])
    except KeyboardInterrupt:
        break

serial_port.close()
