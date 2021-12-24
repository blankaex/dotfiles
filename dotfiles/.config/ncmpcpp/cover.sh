#!/bin/bash

function ImageLayer {
    ueberzug layer -sp json
}

COVER="$XDG_CACHE_HOME/cover.png"
X_PADDING=0
Y_PADDING=0

function add_cover {
    if [ -e $COVER ]; then
        echo "{\"action\": \"add\", \"identifier\": \"cover\", \"x\": $X_PADDING, \"y\": $Y_PADDING, \"path\": \"$COVER\"}";
    fi
}

clear
ImageLayer -< <(
    add_cover
    while inotifywait -q -q -e close_write "$COVER"; do
        add_cover
    done
)
