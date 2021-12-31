#!/usr/bin/python3
import time
import os

def flush():
    out = os.system('cd ./src && ./flush')
    print(out)

def main():
    while True:
        flush()
        time.sleep(3600 * 6)


if __name__ == '__main__':
    main()
