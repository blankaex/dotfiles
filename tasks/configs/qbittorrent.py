from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy qBittorrent configs",
    src="dotfiles/.config/qBittorrent/",
    dest=f"{home}/.config/qBittorrent/",
    flags=[
        "-a"
    ]
)
