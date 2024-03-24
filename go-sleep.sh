#!/bin/bash

# go-sleep.sh
#
# Yells at you if you are on PC instead of sleeping. And then locks your computer to annoy you.

while true; do
    current_time=$(date +"%H:%M")

    if [[ "$current_time" > "21:17" || "$current_time" < "05:00" ]]; then
        notify-send -u critical "😴 TIME TO SLEEP 😴" "LEAVE YOUR COMPUTER AND GO SLEEP!"
    fi

    if [[ "$current_time" > "21:27" || "$current_time" < "05:00" ]]; then
        i3lock -c ff0000
    fi

    sleep 10
done
