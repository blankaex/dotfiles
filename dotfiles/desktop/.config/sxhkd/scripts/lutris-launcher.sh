#!/bin/sh

game=$(lutris -l 2> /dev/null | head -n -1 | cut -d'|'  -f2 | awk '{$1=$1};1' | rofi -dmenu -i -m primary -p "Game") || exit 1

lutris lutris:rungame/$(lutris -l 2> /dev/null | rg "$game" | cut -d'|'  -f3 | awk '{$1=$1};1')
