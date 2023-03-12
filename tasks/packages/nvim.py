from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import server


home = host.get_fact(Home)


pacman.packages(
    name="Install nvim",
    packages=[
        "neovim"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


files.link(
    name="Symlink vim -> nvim",
    target="/usr/bin/nvim",
    path="/usr/bin/vim",
    sudo=True
)


server.shell(
    name="Install vim-plug",
    commands=[
        f"sh -c 'curl -fLo {home}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
    ]
)
