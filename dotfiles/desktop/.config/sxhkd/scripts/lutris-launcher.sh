#!/bin/sh

game=$(lutris -lj 2> /dev/null | jq '.[].name' 2> /dev/null | tr -d '"'| rofi -dmenu -i -m primary -p "Game") || exit 1

lutris lutris:rungame/$(lutris -lj 2> /dev/null | jq ".[] | select(.name==\"$game\") | .slug" 2> /dev/null | tr -d '"')
