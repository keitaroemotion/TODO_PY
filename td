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


