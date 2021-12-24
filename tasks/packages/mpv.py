from pyinfra.operations import pacman


pacman.packages(
    name="Install mpv",
    packages=[
        "mpv"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
