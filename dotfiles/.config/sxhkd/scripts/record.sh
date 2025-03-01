#!/bin/sh
xwininfo | {
    while IFS=: read -r k v; do
        case "$k" in
        *"Absolute upper-left X"*) x=$v;;
        *"Absolute upper-left Y"*) y=$v;;
        *"Border width"*) bw=$v ;;
        *"Width"*) w=$v;;
        *"Height"*) h=$v;;
        esac
    done
    for i in 3 2 1; do echo "$i"; sleep 1; done
    ffmpeg -y -f x11grab -framerate 30 \
           -video_size "$((w))x$((h))" \
           -i "+$((x+bw)),$((y+bw))" "$HOME/recording.mp4"
}
