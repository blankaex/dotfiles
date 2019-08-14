#!/bin/bash

# "vol" ascii -> dec
id="118111108"

changeVol () 
{
	if pactl list sinks | rg "Mute: yes"; then
        dunstify -r $id -i audio-volume-muted "ミュートになってます"
        exit 0
	fi

	pactl set-sink-volume 0 $1%
	vol=$(pactl list sinks | rg '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) |\
        tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
	dunstify -r $id -i audio-volume-high "ボリューム："$vol
}

toggleMute ()
{
	pactl set-sink-mute 0 toggle
	if pactl list sinks | rg "Mute: yes"; then
		mute="ミュート"
	else
		mute="ミュート解除"
	fi
	dunstify -r $id -i audio-volume-muted $mute
}
 
while getopts 'u:d:m' flag; do
	case "${flag}" in
		u) changeVol +${OPTARG} ;;
		d) changeVol -${OPTARG} ;;
		m) toggleMute ;;
		*) exit 1 ;;
	esac
done

exit 0
