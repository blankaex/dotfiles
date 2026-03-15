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

# Keyboard options
# check fcitx settings if this is being overridden on window focus
setxkbmap -option caps:super # prevents https://bbs.archlinux.org/viewtopic.php?id=247759
xcape -e "Super_L=Escape"

# Configure xorg
xsetroot -cursor_name left_ptr &
xset s off -dpms
xset s noblank
xset r rate 220 60 # default 660 25

# Start services
redshift & 
fcitx5 &
sxhkd &
picom &

# Setup monitors
autorandr -c
wal -Re

# Launch WM
exec bspwm
