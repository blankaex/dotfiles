#!/usr/bin/bash
test -e ~/.config/dunst/dunstrc ||
    ln -s ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
