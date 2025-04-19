import configparser
import sys
from src import printcolors as pc

try:
    config = configparser.ConfigParser(interpolation=None)
    config.read("config/credentials.ini")
except FileNotFoundError:
    pc.printout('Error: file "config/credentials.ini" not found!\n', pc.RED)
    sys.exit(0)
except Exception as e:
    pc.printout("Error: {}\n".format(e), pc.RED)
    sys.exit(0)

def getSessionID():
    try:
        sessionid = config["Credentials"]["sessionid"]

        if sessionid.strip() == '':
            pc.printout('Error: "sessionid" field cannot be blank in "config/credentials.ini"\n', pc.RED)
            sys.exit(0)

        return sessionid
    except KeyError:
        pc.printout('Error: missing "sessionid" field in "config/credentials.ini"\n', pc.RED)
        sys.exit(0)
