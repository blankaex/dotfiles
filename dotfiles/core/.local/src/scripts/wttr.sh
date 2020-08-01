#!/bin/sh

# only update cached weather info if it's older than one day
if [ $(stat -c '%Y' $XDG_CACHE_HOME/wttr) -lt $(date -d 'now - 1 day' +%s) ]; then
    curl wttr.in/$WTTR_LOCATION | awk 'NR>=2&&NR<=37' > $XDG_CACHE_HOME/wttr
fi

bspc rule -a Alacritty:wttr -o monitor=DVI-I-1 state=floating follow=on center=on rectangle=1024x660+0+0
alacritty --class wttr -e less $XDG_CACHE_HOME/wttr
