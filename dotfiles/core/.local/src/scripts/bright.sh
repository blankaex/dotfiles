#!/bin/bash

# "bri" ascii -> dec
id="98114105"

changeBright () 
{
    light $1 $2
    bright=$(light | sed -e 's/\..*//')
	dunstify -r $id -i audio-volume-high "明るさ："$bright
}
 
while getopts 'u:d:' flag; do
	case "${flag}" in
		u) changeBright "-A" ${OPTARG} ;;
		d) changeBright "-U" ${OPTARG} ;;
		*) exit 1 ;;
	esac
done

exit 0
