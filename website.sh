#!/bin/bash

# SCRIPT NAME
# author: Ondrej Kulaty (rubick)
#
# Helper script for editing my website
# - starts local http server
# - starts vim editor

# Navigate to website output directory
cd ~/other/website/output
# Start HTTP server here
python -m http.server 8000 1> /dev/null 2> /dev/null &
# Remember http server's PID
PID=$!
# navigate to input directory
cd ../input
# start my favorite text editor
vim
# once editing is finished, stop the HTTP server
kill $PID
