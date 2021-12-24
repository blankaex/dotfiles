from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


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
