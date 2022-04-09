from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy gtk2 config",
    src="dotfiles/.gtkrc-2.0/",
    dest=f"{home}/.gtkrc-2.0/",
    flags=[
        "-a"
    ]
)


files.rsync(
    name="Deploy gtk3 config",
    src="dotfiles/.config/gtk-3.0/",
    dest=f"{home}/.config/gtk-3.0/",
    flags=[
        "-a"
    ]
)


files.rsync(
    name="Deploy gtk file chooser config",
    src="dotfiles/.config/gtk-2.0/",
    dest=f"{home}/.config/gtk-2.0/",
    flags=[
        "-a"
    ]
)


files.rsync(
    name="Deploy gtk themes",
    src="dotfiles/.themes/",
    dest=f"{home}/.themes/",
    flags=[
        "-a"
    ]
)
