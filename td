#!/usr/bin/env python3

import keyboard
import os
import re
import sys 
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
def add_task():
    task  = ask_for_input("[describe your task]: ")
    today = date.today()
    print("[due date?]")
    print("")
    print("h ... day   - 1  |  l ... day   + 1")
    print("j ... month - 1  |  k ... month + 1")
    print("f ... year  - 1  |  u ... year  + 1")
    print("")
    due_date = get_key_events(today)
    return [task, due_date]

def add_todo(content):
    f = open(TODO_FILE_PATH, "a+") 
    f.write(content + "\n")
    f.close()
    print("[+] TODO added!")

DELIMITER = "$$"

def read_content():
    f = open(TODO_FILE_PATH, "r") 
    content = f.read()
    f.close()
    return content

def list_todos_for_modification():
    content = read_content()
    print("")
    lines = []
    i = 0
    csp = [x for x in content.split("\n") if (DELIMITER in x)]
    if(len(csp) == 0):
        abort("No TODOs found ...")

    for line in csp:
        lines.append(line)
        task, due_date = line.split(DELIMITER)
        print("[{}]: [{}] {}".format(i, task, due_date))
        i += 1
    print("")
    return lines 

def list_todos():
    content = read_content()
    print("")
    for line in content.split("\n"):
        if(DELIMITER in line):
            task, due_date = line.split(DELIMITER)
            print("[{}] {}".format(task, due_date))
    print("")

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

option = sys.argv[1] if len(sys.argv) > 1 else None

if(option == "-h" or option == "help"):
    print(
        ""                            + \
        "td add   ... add new todo"   + \
        "td rm    ... rm  todo"       + \
        "td help  ... show help menu" + \
        "" 
    )
elif(option == "update" or option == "u"):
    def update(index, lines):
        if not re.search("^\d+$", index):
            abort("you need to input index.")
            update(ask_for_input("which to update?: "), lines)
        # 
        #  overwrite TODO.md and exclude the target line
        # 
        i = 0
        f = open(TODO_FILE_PATH, "w+")
        for line in lines:
            if i == int(index):
                # XXX
                task, due_date = add_task()
                line = "{}{}{}".format(task, DELIMITER, due_date)
            f.write(line + "\n")
            i += 1
        f.close()
    lines = list_todos_for_modification()
    update(ask_for_input("which to update? : "), lines)

elif(option == "rm" or option == "r"):
    def remove(index, lines):
        if not re.search("^\d+$", index):
            abort("you need to input index.")
            remove(ask_for_input("which to remove?: "), lines)
        # 
        #  overwrite TODO.md and exclude the target line
        # 
        i = 0
        f = open(TODO_FILE_PATH, "w+")
        for line in lines:
            if i != int(index):
                f.write(line + "\n")
            i += 1
        f.close()

    lines = list_todos_for_modification()
    remove(ask_for_input("which to remove? : "), lines)

elif(option == "add") or (option == "a"):
    task, due_date = add_task()
    add_todo("{}{}{}".format(task, DELIMITER, due_date))
    list_todos()
else:
    list_todos()
