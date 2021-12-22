from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import systemd


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy xinit configs",
    src="dotfiles/.xinitrc.j2",
    dest=f"{home}/.xinitrc",
    hostname=hostname
)


files.rsync(
    name="Deploy Redshift configs",
    src="dotfiles/.config/redshift",
    dest=f"{home}/.config/redshift"
)


files.rsync(
    name="Deploy bspwm configs [1/2]",
    src="dotfiles/.config/bspwm",
    dest=f"{home}/.config/bspwm",
    flags=[
        "--exclude '*.j2'"
    ]
)


files.template(
    name="Deploy bspwm configs [2/2]",
    src="dotfiles/.config/bspwm/bspwmrc.j2",
    dest=f"{home}/.config/bspwm/bspwmrc",
    hostname=hostname,
    colors=colors
)


files.rsync(
    name="Deploy sxhkd configs [1/2]",
    src="dotfiles/.config/sxhkd",
    dest=f"{home}/.config/sxhkd",
    flags=[
        "--exclude '*.j2'"
    ]
)


files.template(
    name="Deploy sxhkd configs [2/2]",
    src="dotfiles/.config/sxhkd/sxhkdrc.j2",
    dest=f"{home}/.config/sxhkd/sxhkdrc",
    hostname=hostname
)


files.template(
    name="Deploy polybar configs [1/2]",
    src="dotfiles/.config/polybar/config.j2",
    dest=f"{home}/.config/polybar/config",
    hostname=hostname
)

files.template(
    name="Deploy polybar configs [2/2]",
    src="dotfiles/.config/polybar/launch.sh.j2",
    dest=f"{home}/.config/polybar/launch.sh",
    hostname=hostname
)


files.template(
    name="Deploy Rofi configs",
    src="dotfiles/.config/rofi/config.rasi.j2",
    dest=f"{home}/.config/rofi/config.rasi",
    colors=colors
)


# TODO template screen geometry
files.template(
    name="Deploy Dunst config [1/2]",
    src="dotfiles/.config/dunst/dunstrc.j2",
    dest=f"{home}/.config/dunst/dunstrc",
    colors=colors,
    home=home
)


# TODO template this
files.template(
    name="Deploy Dunst config [2/2]",
    src="dotfiles/.config/dunst/notify-sound.sh.j2",
    dest=f"{home}/.config/dunst/notify-sound.sh"
)


# TODO download and set a temp wallpaper
files.template(
    name="Deploy feh configs",
    src="dotfiles/.fehbg.j2",
    dest=f"{home}/.fehbg",
    hostname=hostname
)


files.rsync(
    name="Deploy gtk2 config",
    src="dotfiles/.gtkrc-2.0",
    dest=f"{home}/.gtkrc-2.0"
)


files.rsync(
    name="Deploy gtk3 config",
    src="dotfiles/.config/gtk-3.0",
    dest=f"{home}/.config/gtk-3.0"
)


files.rsync(
    name="Deploy gtk file chooser config",
    src="dotfiles/.config/gtk-2.0",
    dest=f"{home}/.config/gtk-2.0"
)


# TODO template the skin maybe
files.rsync(
    name="Deploy fcitx configs",
    src="dotfiles/.config/fcitx",
    dest=f"{home}/.config/fcitx"
)


systemd.service(
    name="Configure PipeWire",
    service="pipewire-pulse",
    running=True,
    enabled=True,
    user_mode=True
)
