#!/usr/bin/python3
import time
import os

def flush():
    os.system('cd ./src && git add . && git commit -m "backup"')
    os.system('cd ./src && git push origin blog:blog')

def main():
    while True:
        flush()
        time.sleep(3600 * 6)


if __name__ == '__main__':
    main()
