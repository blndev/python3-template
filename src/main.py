#! python3
'''
Main starting point
'''

import sys
import getopt
from service import run

def startService(argv):
    """Main entry point of our rest service."""

    # Default Values
    debug = False
    port = 8080
    listen = "0.0.0.0"

    try:
        opts, args = getopt.getopt(argv, "hi:o:", ["debug=", "port=", "listen="])
        for opt, arg in opts:
            if (opt == '-h' or opt == '--help'):
                print ('-d <debugmode> -p <port>')
                sys.exit()
            elif opt in ("-d", "--debug"):
                debug = True
            elif opt in ("-p", "--port"):
                port = arg
            elif opt in ("-l", "--listen"):
                listen = arg
    except getopt.GetoptError:
        print ('main.py -debug true|false -port 5000')
        # sys.exit(2)
    
    run(Listen=listen,Port=port,Debug=debug)

def main(argv):
    ''' The main Application entry point'''

    try:
        print("Hello World")
        startService(argv)
    except KeyboardInterrupt:
        print('ctrl-c detected')
        exit(0)
    except Exception as err:
        print('unhandled error', err)
        exit(1)
    finally:
        print('Application will now beeing stopped')


if __name__ == "__main__":
    # execute only if run as a script
    main(sys.argv[1:])