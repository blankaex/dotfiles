from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy alacritty config",
    src="dotfiles/.config/alacritty/alacritty.yml.j2",
    dest=f"{home}/.config/alacritty/alacritty.yml",
    colors=colors,
    hostname=hostname
)
