
engine_ids = ['0x460', '0x461', '0x621', '0x640', '0x649']

# Dictionary for mapping received can messages to key value pairs for JSON
# Would be much better if I knew a way to procedurally generate this dict, these are the only messages we care about atm
# General structure: ID : { message : [offset, length, scale] }
can_dict = {
    '0x460' : {
        "Lambda" : [1, 2, 10]
        },
    '0x621' : {
        "Temp 1" : [0, 2, 1],
        "Temp 2" : [2, 2, 1],
        "Temp 3" : [4, 2, 1],
        "Temp 4" : [6, 2, 1]
        },
    '0x640' : {
        "RPM": [0, 2, 1/6],
        "MAP": [2, 2, 1],
        "Air Temp": [4, 2, 1],
        "TPS": [6, 2, 1]
         },
    '0x649': {
        "Coolant": [0, 1, 1],
        "Oil Temp": [1, 1, 1]
    },
}