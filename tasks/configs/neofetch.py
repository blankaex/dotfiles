from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy neofetch configs",
    src="dotfiles/.config/neofetch/",
    dest=f"{home}/.config/neofetch/",
    flags=[
        "-a"
    ]
)
