from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


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
