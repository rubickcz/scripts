#!/bin/bash

# monitor-toggle.sh
# author: Ondrej Kulaty (rubick)
#
# Switches on/off a secondary monitor

# improvement:
# scan for any connected output (except laptop output) and activate them all 
# if no outpu is found, activate just laptop output

PRIMARY=`xrandr | grep -oP "(HDMI|DP)[0-9-]+(?= connected)"`
SECONDARY="VGA1"
LAPTOP_SCREEN="LVDS1"

if [ ! -z $PRIMARY ]; then
    # Primary monitor is connected
    xrandr --output $LAPTOP_SCREEN --off
    xrandr --output $PRIMARY --auto --primary
    xrandr --output $SECONDARY --auto --right-of $PRIMARY
else
    xrandr --output $SECONDARY --off
    xrandr --output $LAPTOP_SCREEN --auto
fi
