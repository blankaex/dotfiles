from pyinfra.operations import pacman


pacman.packages(
    name="Install alacritty",
    packages=[
        "alacritty"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
