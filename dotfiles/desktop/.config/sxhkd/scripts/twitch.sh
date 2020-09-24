#!/bin/sh

stream=$(cat "$XDG_CACHE_HOME/twitch" | rofi -dmenu -i -m primary -p "Stream") || exit 1

rg -Fxq $stream "$XDG_CACHE_HOME/twitch" || echo $stream >> "$XDG_CACHE_HOME/twitch"

mpv "https://www.twitch.tv/$stream"
