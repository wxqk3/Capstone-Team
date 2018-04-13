import sys
from firebase import firebase

print(str(sys.argv[1]))
print("Send Info")

url = "https://telemetryapp-16f5d.firebaseio.com"
fb = firebase.FirebaseApplication(url, None)

username = sys.argv[1].split("@")
username = username[0]
email = sys.argv[1]

emailDict = {"email":email}

userPath = "user/" + username

result = fb.put(userPath, '/', emailDict)
