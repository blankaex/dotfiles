#!/usr/bin/bash
mkdir -p "$HOME/.local/src/" "$HOME/.config/ranger/plugins"

test -e "$HOME/.local/src/ranger-autojump" ||
    git clone https://github.com/fdw/ranger-autojump "$HOME/.local/src/ranger-autojump"
test -e "$HOME/.config/ranger/plugins/autojump.py" ||
    ln -s "$HOME/.local/src/ranger-autojump/autojump.py" "$HOME/.config/ranger/plugins/autojump.py"
