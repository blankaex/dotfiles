#!/bin/sh

[ "$(printf "No\\nYes" | rofi -dmenu -i -m primary -p "$1")" = "Yes" ] && $2
