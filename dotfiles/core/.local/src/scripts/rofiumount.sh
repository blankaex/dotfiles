#!/bin/sh

unmountusb() {
	[ -z "$drives" ] && exit
	chosen="$(echo "$drives" | rofi -m primary -dmenu -i -p "Unmount")" || exit 1
	chosen="$(echo "$chosen" | awk '{print $1}')"
	[ -z "$chosen" ] && exit
	sudo -A umount "$chosen" && notify-send "💻 USB unmounting" "$chosen unmounted."
	}

unmountandroid() { \
    chosen="$( awk '/simple-mtpfs/ {print $2}' /etc/mtab | rofi -m primary -dmenu -i -p "Unmount")" || exit 1
	[ -z "$chosen" ] && exit
	sudo -A umount -l "$chosen" && notify-send "🤖 Android unmounting" "$chosen unmounted."
	}

asktype() { \
	choice="$(printf "USB\\nAndroid" | rofi -m primary -dmenu -i -p "Unmount")" || exit 1
	case "$choice" in
		USB) unmountusb ;;
		Android) unmountandroid ;;
	esac
	}

drives=$(lsblk -nrpo "name,type,size,mountpoint" | rg -v "/media/" | awk '$4!~/\/boot|\/home$|SWAP/&&length($4)>1{printf "%s (%s)\n",$4,$3}')

if ! rg simple-mtpfs /etc/mtab; then
	[ -z "$drives" ] && notify-send "No drives to unmount." && exit
	echo "Unmountable USB drive detected."
	unmountusb
else
	if [ -z "$drives" ]
	then
		echo "Unmountable Android device detected."
	       	unmountandroid
	else
		echo "Unmountable USB drive(s) and Android device(s) detected."
		asktype
	fi
fi
