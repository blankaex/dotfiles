from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


# TODO template the skin maybe
files.rsync(
    name="Deploy fcitx configs",
    src="dotfiles/.config/fcitx",
    dest=f"{home}/.config/fcitx"
)
