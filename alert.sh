#!/bin/bash

# ALERT
# author: Ondrej Kulaty (rubick)
#
# Plays a sound, can be used for various notifications.

aplay "$(dirname "${BASH_SOURCE[0]}")/res/alert.wav" 2>/dev/null
