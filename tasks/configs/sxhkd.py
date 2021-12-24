from config.colors import colors
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy sxhkd config",
    src="dotfiles/.config/sxhkd/sxhkdrc.j2",
    dest=f"{home}/.config/sxhkd/sxhkdrc",
    hostname=hostname
)


files.rsync(
    name="Deploy sxhkd scripts",
    src="dotfiles/.config/sxhkd/scripts",
    dest=f"{home}/.config/sxhkd/scripts"
)
