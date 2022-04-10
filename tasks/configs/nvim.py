from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import server


home = host.get_fact(Home)


files.rsync(
    name="Deploy Neovim configs",
    src="dotfiles/.config/nvim/",
    dest=f"{home}/.config/nvim/",
    flags=[
        "-a"
    ]
)


server.shell(
    name="Install Neovim plugins",
    commands=[
        "nvim +'PlugInstall --sync' +qa"
    ]
)
