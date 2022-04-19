from pyinfra import local

# dependencies
local.include("tasks/packages/git.py")
local.include("tasks/packages/trizen.py")

# shell
local.include("tasks/packages/nvim.py")
local.include("tasks/packages/pywal.py")
local.include("tasks/packages/ranger.py")
local.include("tasks/packages/ripgrep.py")
local.include("tasks/packages/zsh.py")

# desktop environment
local.include("tasks/packages/bspwm.py")
local.include("tasks/packages/dunst.py")
local.include("tasks/packages/feh.py")
local.include("tasks/packages/fonts.py")
local.include("tasks/packages/gtk.py")
local.include("tasks/packages/pipewire.py")
local.include("tasks/packages/polybar.py")
local.include("tasks/packages/redshift.py")
local.include("tasks/packages/rofi.py")
local.include("tasks/packages/sxhkd.py")
local.include("tasks/packages/xorg.py")

# user applications
local.include("tasks/packages/ahoviewer.py")
local.include("tasks/packages/alacritty.py")
local.include("tasks/packages/fcitx.py")
local.include("tasks/packages/firefox.py")
local.include("tasks/packages/mpd.py")
local.include("tasks/packages/mpv.py")
local.include("tasks/packages/neofetch.py")
local.include("tasks/packages/qbittorrent.py")
local.include("tasks/packages/thunderbird.py")
local.include("tasks/packages/vivaldi.py")
local.include("tasks/packages/weechat.py")
local.include("tasks/packages/yt-dlp.py")
local.include("tasks/packages/zathura.py")
