#!/usr/bin/env python3

import os
from pathlib import Path

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

task = ask_for_input("[describe your task]: ")

print(task)
