from pyinfra.operations import pacman


pacman.packages(
    name="Install dunst",
    packages=[
        "dunst",
        "libnotify"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
