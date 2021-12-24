from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy Neovim configs",
    src="dotfiles/.config/nvim",
    dest=f"{home}/.config/nvim"
)


files.link(
    name="Symlink vim -> nvim",
    target="/usr/bin/nvim",
    path="/usr/bin/vim",
    sudo=True
)


#TODO install plugins
