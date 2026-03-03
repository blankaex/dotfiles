#!/bin/sh

# Load X configs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*;  do
		[ -x "f" ] && . "$f"
	done
	unset f
fi
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Xresources colours
xrdb -merge "$HOME/.Xresources"

# Configure xorg
xsetroot -cursor_name left_ptr &
xset s off -dpms
xset s noblank
xset r rate 330 50 # default 660 25

# Start services
redshift & 
fcitx5 &
sxhkd &
picom &

# Setup monitors
autorandr -c

# Launch WM
exec bspwm
