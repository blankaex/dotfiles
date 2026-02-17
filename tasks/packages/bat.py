from pyinfra.operations import pacman


pacman.packages(
    name="Install bat",
    packages=[
        "bat"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
