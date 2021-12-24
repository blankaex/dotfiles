from pyinfra.operations import pacman


pacman.packages(
    name="Install mpd + ncmpcpp",
    packages=[
        "mpd",
        "ncmpcpp",
        "ueberzug"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
