from pyinfra import local

# shell
local.include("tasks/configs/git.py")
local.include("tasks/configs/zsh.py")
local.include("tasks/configs/nvim.py")
local.include("tasks/configs/ranger.py")

# desktop environment
local.include("tasks/configs/xorg.py")
local.include("tasks/configs/bspwm.py")
local.include("tasks/configs/sxhkd.py")
local.include("tasks/configs/polybar.py")
local.include("tasks/configs/rofi.py")
local.include("tasks/configs/dunst.py")
local.include("tasks/configs/pywal.py")
local.include("tasks/configs/feh.py")
local.include("tasks/configs/gtk.py")
local.include("tasks/configs/redshift.py")
local.include("tasks/configs/pipewire.py")

# user applications
local.include("tasks/configs/alacritty.py")
local.include("tasks/configs/fcitx.py")
#TODO
# local.include("tasks/configs/firefox.py")
local.include("tasks/configs/mpd.py")
local.include("tasks/configs/mpv.py")
#TODO not working for some reason
# local.include("tasks/configs/qbittorrent.py")
#TODO
# local.include("tasks/configs/thunderbird.py")
#TODO
# local.include("tasks/configs/vivaldi.py")
local.include("tasks/configs/yt-dlp.py")
