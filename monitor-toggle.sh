#!/bin/bash

# monitor-toggle.sh
# author: Ondrej Kulaty (rubick)
#
# Switches on/off a secondary monitor

PRIMARY="HDMI1"
SECONDARY="LVDS1"

xrandr | grep -P "$SECONDARY connected [0-9]+x[0-9]+" > /dev/null
if [ $? -eq 0 ]; then
    xrandr --output $SECONDARY --off
else
    xrandr --output $SECONDARY --auto --left-of $PRIMARY
fi
