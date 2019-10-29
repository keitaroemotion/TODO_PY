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

def get_key_events(current_date):
    stopwatch = 0
    ceiling_amount = 8000

    while True: 
        stopwatch += 1
        try: 
            if keyboard.is_pressed('enter'):
                    break;
            if(stopwatch > ceiling_amount):
                if keyboard.is_pressed('j'):
                        current_date = date(
                                           current_date.year,
                                           current_date.month - 1,
                                           current_date.day
                                       )
                if keyboard.is_pressed('k'):
                        current_date = date(
                                           current_date.year,
                                           current_date.month + 1,
                                           current_date.day
                                       )
                if keyboard.is_pressed('right'):
                        current_date = date(
                                           current_date.year + 1,
                                           current_date.month,
                                           current_date.day
                                       )
                if keyboard.is_pressed('left'):
                        current_date = date(
                                           current_date.year - 1,
                                           current_date.month,
                                           current_date.day
                                       )
                if keyboard.is_pressed('h'):
                        current_date = current_date - timedelta(days = 1) 
                if keyboard.is_pressed('l'):
                        current_date = current_date + timedelta(days = 1) 
                print("", end="\r")
                print(current_date, end="\r")
                stopwatch = 0
            else:
                pass
        except:
            break  

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
