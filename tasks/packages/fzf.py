from pyinfra.operations import pacman


pacman.packages(
    name="Install fzf",
    packages=[
        "fzf"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
