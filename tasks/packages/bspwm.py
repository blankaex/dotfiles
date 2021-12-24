from pyinfra.operations import pacman


pacman.packages(
    name="Install bspwm",
    packages=[
        "bspwm"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
