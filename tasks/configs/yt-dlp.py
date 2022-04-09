from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


#TODO
files.rsync(
    name="Deploy yt-dlp configs",
    src="dotfiles/.config/yt-dlp/",
    dest=f"{home}/.config/yt-dlp/",
    flags=[
        "-a"
    ]
)
