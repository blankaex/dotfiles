#!/bin/bash

# "vol" ascii -> dec
LANG=en
id="118111108"
sink=`pactl list sinks | head -1 | sed 's/^Sink #\([0-9]\)$/\1/'`

changeVol () 
{
	if pactl list sinks | rg "Mute: yes"; then
        dunstify -r $id "ミュートになってます"
        exit 0
	fi

	pactl set-sink-volume $sink $1%
	vol=$(pactl list sinks | rg '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) |\
        tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
	dunstify -r $id "ボリューム："$vol
}

toggleMute ()
{
	pactl set-sink-mute $sink toggle
	if pactl list sinks | rg "Mute: yes"; then
        dunstify -r $id "ミュート"
	else
        dunstify -r $id "ミュート解除"
	fi
}
 
getopts 'u:d:m' flag
case "${flag}" in
    u) changeVol +${OPTARG} ;;
    d) changeVol -${OPTARG} ;;
    m) toggleMute ;;
    *) exit 1 ;;
esac

exit 0
