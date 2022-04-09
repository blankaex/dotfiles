from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy mpv configs",
    src="dotfiles/.config/mpv/",
    dest=f"{home}/.config/mpv/",
    flags=[
        "-a"
    ]
)
