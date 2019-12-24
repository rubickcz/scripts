#!/bin/bash

# STRETCH BREAK
# author: Ondrej Kulaty (rubick)
#
# This script is intended to mitigate effects of long sitting in front of PC.
# It pops notification every 60 minutes, informing you to go away from PC and stretch yourself.

while true; do
    sleep 3600
    notify-send "Stretch break" "Leave the computer and stretch yourself for 5 minutes!"
done
