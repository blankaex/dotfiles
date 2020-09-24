#!/bin/sh

n=$(bspc query -N -n .hidden | wc -l)
if [ $n -eq 1 ]; then
    node=$(bspc query -N -n .hidden -n .sticky | tail -n1)
elif [ $n -gt 1 ]; then
    node=$(bspc query -N -n .hidden -n .sticky | xargs xtitle -f "%s: %u\n"| rofi -m primary -dmenu -i -p "Unhide" | sed 's/.*: //' | xargs printf "0x%x\n")
fi
bspc node $node -g hidden=off -g sticky=off
