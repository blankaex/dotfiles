#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*;  do
		[ -x "f" ] && . "$f"
	done
	unset f
fi

[ -f ~/.cache/wal/colors.Xresources ] && xrdb -merge ~/.cache/wal/colors.Xresources

start-pulseaudio-x11 &
dunst &
wal -R &
$HOME/.fehbg &
setxkbmap jp
setxkbmap -option caps:super
xcape -e "Super_L=Escape"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &
redshift &

exec i3
