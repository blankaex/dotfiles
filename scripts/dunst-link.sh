#!/usr/bin/bash
mkdir -p "${XDG_CONFIG_HOME}/dunst"
ln -s "$HOME/.cache/wal/dunstrc" "${XDG_CONFIG_HOME}/dunst/dunstrc"
