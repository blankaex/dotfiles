from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy mpd configs",
    src="dotfiles/.config/mpd/",
    dest=f"{home}/.config/mpd/",
    flags=[
        "-a"
    ]
)


files.rsync(
    name="Deploy ncmpcpp configs",
    src="dotfiles/.config/ncmpcpp/",
    dest=f"{home}/.config/ncmpcpp/",
    flags=[
        "-a"
    ]
)
