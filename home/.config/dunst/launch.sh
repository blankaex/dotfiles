#!/usr/bin/sh

# Terminate already running dunst instances
killall -q dunst

# Wait until the processes have been shut down
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done

# Launch dunst
set -a && source $XDG_CACHE_HOME/wal/colors.sh
dunst -config <(envsubst < $XDG_CONFIG_HOME/dunst/dunstrc) &
