from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


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
    mode="755",
    hostname=hostname
)
