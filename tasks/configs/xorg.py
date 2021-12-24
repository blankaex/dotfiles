from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy xinit configs",
    src="dotfiles/.xinitrc.j2",
    dest=f"{home}/.xinitrc",
    hostname=hostname
)


files.template(
    name="Deploy Xresources",
    src="dotfiles/.Xresource.j2",
    dest=f"{home}/.Xresources",
    hostname=hostname,
    colors=colors
)
