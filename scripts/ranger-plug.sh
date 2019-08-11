#!/usr/bin/bash
mkdir -p "$HOME/.local/src/" "${XDG_CONFIG_HOME}/ranger/plugins"

git clone https://github.com/fdw/ranger-autojump "$HOME/.local/src/"
ln -s "$HOME/.local/src/ranger-autojump/autojump.py" "${XDG_CONFIG_HOME}/ranger/plugins/autojump.py"
