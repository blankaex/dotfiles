#!/bin/sh

# Load X stuff
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*;  do
		[ -x "f" ] && . "$f"
	done
	unset f
fi

# Xresources colours
xrdb -merge "$HOME/.Xresources"

# Keyboard options
# check fcitx settings if this is being overridden on window focus
setxkbmap -option caps:super # prevents https://bbs.archlinux.org/viewtopic.php?id=247759
xcape -e "Super_L=Escape"

# Configure screens
xsetroot -cursor_name left_ptr &
autorandr -c
xset -dpms
xset s off
xset s noblank

# Start services
dunst &
redshift & 
fcitx &
$HOME/.fehbg &
sxhkd &

# Launch WM
echo "startup" > "$XDG_CACHE_HOME/xstatus"
exec bspwm
