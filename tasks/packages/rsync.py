from pyinfra.operations import pacman


pacman.packages(
    name="Install rsync",
    packages=[
        "rsync"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
