#!python3
'''
Main starting point
'''
import time
import random


def main():
    ''' The main Application entry point'''

    try:
        #TODO - check for debug arg
        print("Hello World")
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
    main()