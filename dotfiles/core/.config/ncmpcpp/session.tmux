set -g default-command bash
set -g status off
set -g pane-active-border-style fg=black
set -g pane-border-style fg=black
neww
send-keys '$XDG_CONFIG_HOME/ncmpcpp/cover.sh' C-m
split-window -h
resize-pane -t 0 -x 36
select-pane -t 1
send-keys 'ncmpcpp' C-m
