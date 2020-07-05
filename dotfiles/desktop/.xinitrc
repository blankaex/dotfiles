#!/bin/sh

# Load X stuff
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*;  do
		[ -x "f" ] && . "$f"
	done
	unset f
fi

# Xresources colours
[ -f ~/.cache/wal/colors.Xresources ] && xrdb -merge ~/.cache/wal/colors.Xresources

# Keyboard options
setxkbmap -option caps:super
xcape -e "Super_L=Escape"

# Configure screens
xrandr --output DVI-I-1 --auto --primary --pos 1080x340 --output DVI-D-0 --rotate left --pos 0x0
xset -dpms
xset s off
xset s noblank

# Start services
start-pulseaudio-x11 &
dunst &
redshift & 
fcitx &
wal -R &
$HOME/.fehbg &
sxhkd &

# Launch WM
exec i3
# exec bspwm
