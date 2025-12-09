from pyinfra.operations import pacman


pacman.packages(
    name="Install grc",
    packages=[
        "grc"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
