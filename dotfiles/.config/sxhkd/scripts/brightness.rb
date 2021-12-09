#!/bin/ruby 

brightness = `printf "0.5\\n1.0" | rofi -dmenu -i -m primary -p "Brightness"`.strip
system "xrandr --output DVI-D-0 --brightness #{brightness}"
system "xrandr --output DVI-I-1 --brightness #{brightness}"
