from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy Rofi configs",
    src="dotfiles/.config/rofi/config.rasi.j2",
    dest=f"{home}/.config/rofi/config.rasi",
    colors=colors,
    hostname=hostname
)
