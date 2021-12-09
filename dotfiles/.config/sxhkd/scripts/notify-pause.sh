#!/bin/sh

[ "$(printf "Pause\\nUnpause" | rofi -dmenu -i -m primary -p "Notifications")" = "Pause" ] && 
    dunstctl set-paused true ||
    dunstctl set-paused false
