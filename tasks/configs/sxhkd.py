from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


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
