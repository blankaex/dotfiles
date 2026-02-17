from pyinfra.operations import pacman


pacman.packages(
    name="Install eza",
    packages=[
        "eza"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
