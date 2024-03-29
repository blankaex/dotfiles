from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.operations import git
from pyinfra.operations import files
from pyinfra.operations import pacman


home = host.get_fact(Home)


pacman.packages(
    name="Install ranger",
    packages=[
        "ranger",
        "sxiv"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


git.repo(
    name="Clone ranger-autojump",
    src="https://github.com/fdw/ranger-autojump",
    dest=f"{home}/.local/src/ranger-autojump"
)


files.link(
    name="Symlink autojump plugin",
    target=f"{home}/.local/src/ranger-autojump/autojump.py",
    path=f"{home}/.config/ranger/plugins/autojump.py"
)
