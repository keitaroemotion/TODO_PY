#!/usr/bin/env python3

import keyboard
import os
import time
from datetime import date, timedelta
from pathlib  import Path

# create todo file
TODO_FILE_PATH = "TODO.md"

#
# create new TODO file if not exists in current directory
#
if(not os.path.isfile(TODO_FILE_PATH)):
    Path(TODO_FILE_PATH).touch()

#
# definition :
#       td
#       [question]: task?
#       [question]: due date?
#

def is_bye():
    return(
              keyboard.is_pressed('enter')    or \
              keyboard.is_pressed('ctrl + c') or \
              keyboard.is_pressed('ctrl + d')
          )
def get_key_events(current_date):
    stopwatch = 0
    ceiling_amount = 8000

    while True: 
        stopwatch += 1
        try: 
            if(
                keyboard.is_pressed('enter')
            ):
                break;
            if(stopwatch > ceiling_amount):
                year  = current_date.year
                month = current_date.month
                day   = current_date.day
                if keyboard.is_pressed('j'):
                    month -= 1
                if keyboard.is_pressed('k'):
                    month += 1
                if keyboard.is_pressed('u'):
                    year  += 1
                if keyboard.is_pressed('f'):
                    year  -= 1
                if keyboard.is_pressed('h'):
                    day   -= 1
                if keyboard.is_pressed('l'):
                    day   += 1
                current_date = date(year, month, day)
                print("", end="\r")
                print(current_date, end="\r")
                stopwatch = 0
            else:
                pass
        except:
            if(
                keyboard.is_pressed('enter')    or \
                keyboard.is_pressed('ctrl+c') or \
                keyboard.is_pressed('ctrl+d')
            ):
                break;
            pass

def is_empty(output):
    return (output == None) or (output.strip() == "")

def abort(message):
    print(message)
    sys.exit()

def ask_for_input(message):
    output = input(message)
    if is_empty(output):
        return ask_for_input(message)
    return output

# task = ask_for_input("[describe your task]: ")
# print(task)
today = date.today()
task = get_key_events(today)
