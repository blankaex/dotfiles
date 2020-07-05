#!/bin/sh

getmount() { \
	[ -z "$chosen" ] && exit 1
        # shellcheck disable=SC2086
	mp="$(find $1 2>/dev/null | rofi -dmenu -i -p "Mount point")" || exit 1
	[ "$mp" = "" ] && exit 1
	if [ ! -d "$mp" ]; then
		mkdiryn=$(printf "No\\nYes" | rofi -dmenu -i -p "$mp does not exist. Create it?") || exit 1
		[ "$mkdiryn" = "Yes" ] && (mkdir -p "$mp" || sudo -A mkdir -p "$mp")
	fi
	}

mountusb() { \
	chosen="$(echo "$usbdrives" | rofi -dmenu -i -p "Mount")" || exit 1
	chosen="$(echo "$chosen" | awk '{print $1}')"
	sudo -A mount "$chosen" 2>/dev/null && notify-send "💻 USB mounting" "$chosen mounted." && exit 0
	alreadymounted=$(lsblk -nrpo "name,type,mountpoint" | awk '$3!~/\/boot|\/home$|SWAP/&&length($3)>1{printf "-not ( -path *%s -prune ) ",$3}')
	getmount "/mnt /media /mount /home -maxdepth 5 -type d $alreadymounted"
	partitiontype="$(lsblk -no "fstype" "$chosen")"
	case "$partitiontype" in
		"vfat") sudo -A mount -t vfat "$chosen" "$mp" -o rw,umask=0000;;
		*) sudo -A mount "$chosen" "$mp"; user="$(whoami)"; ug="$(groups | awk '{print $1}')"; sudo -A chown "$user":"$ug" "$mp";;
	esac
	notify-send "💻 USB mounting" "$chosen mounted to $mp."
	}

mountandroid() { \
    chosen="$(echo "$anddrives" | rofi -dmenu -i -p "Device")" || exit 1
    echo $anddrives
    chosen="$(echo "$chosen" | cut -d : -f 1)"
    if [ $(echo "$anddrives" | wc -l) -eq 1 ]; then
        mp="/media/android"
    else
        getmount "$HOME -maxdepth 3 -type d"
    fi
	simple-mtpfs --device "$chosen" "$mp"
	notify-send "🤖 Android Mounting" "Android device mounted to $mp."
	}

asktype() { \
	choice="$(printf "USB\\nAndroid" | rofi -dmenu -i -p "Mount")" || exit 1
	case $choice in
		USB) mountusb ;;
		Android) mountandroid ;;
	esac
	}

anddrives=$(simple-mtpfs -l 2>/dev/null)
usbdrives="$(lsblk -rpo "name,type,size,mountpoint" | rg -ve '/dev/s(r0|d[a-e])' | awk '$4==""{printf "%s (%s)\n",$1,$3}')"

if [ -z "$usbdrives" ]; then
	[ -z "$anddrives" ] && notify-send "No USB drive or Android device detected" && exit
	echo "Android device(s) detected."
	mountandroid
else
	if [ -z "$anddrives" ]; then
		echo "USB drive(s) detected."
		mountusb
	else
		echo "Mountable USB drive(s) and Android device(s) detected."
		asktype
	fi
fi
