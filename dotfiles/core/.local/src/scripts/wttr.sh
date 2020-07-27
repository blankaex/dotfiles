#!/bin/sh

if [ $(stat --format='%Y' "$XDG_CACHE_HOME/wttr") -lt $(date -d 'now - 1 day' +%s) ]; then
    curl wttr.in/$WTTR_LOCATION > $XDG_CACHE_HOME/wttr
fi

bspc rule -a Alacritty:wttr -o state=floating center=on rectangle=1024x700+0+0
alacritty --class wttr -e less $XDG_CACHE_HOME/wttr
