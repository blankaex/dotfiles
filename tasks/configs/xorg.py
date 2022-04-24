from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy xinit configs",
    src="dotfiles/.xinitrc",
    dest=f"{home}/.xinitrc"
)


files.template(
    name="Deploy Xresources",
    src="dotfiles/.Xresources.j2",
    dest=f"{home}/.Xresources",
    colors=colors
)
