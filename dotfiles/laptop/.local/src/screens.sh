#!/bin/bash
intern=LVDS1
vga=VGA1
hdmi=HDMI1

if xrandr | grep "$vga connected"; then
    xrandr --output $intern --mode 1280x720
    xrandr --output $vga --mode 1280x720
elif xrandr | grep "$hdmi connected"; then
    xrandr --output $intern --mode 1280x720
    xrandr --output $hdmi --mode 1280x720
else
    xrandr --output $intern --mode 1366x768
fi

exit 0
