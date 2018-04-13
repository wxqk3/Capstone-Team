import serial
import threading
import messages
from xbee import XBee, ZigBee

serial_port = serial.Serial('COM28', 115200)
xbee = ZigBee(serial_port)

while True:
    try:
        frame = xbee.wait_read_frame()
        # TODO: pass the read in frame to function to attempt to pattern match message, can still print for debug
        print  (frame["rf_data"])
    except KeyboardInterrupt:
        break

serial_port.close()


def threaded(fn):
    # Threading wrapper to spawn concurrent threads for if we need them
    # creates a thread and sets it as a daemon thread so that we do not have to monitor or join thread
    def wrapper(*args, **kwargs):
        t = threading.Thread(target=fn, args=args, kwargs=kwargs)
        t.setdaemon(True)
        t.start()
    return wrapper

def message_parser():
    return True

def is_message(id):
    # Doesn't really check if something is a message
    # Returns true if the id value passed in is an id we have configure in messages.py to be parsed
    for can_ids in messages.engine_ids:
        if id == can_ids:
            return True
    return False