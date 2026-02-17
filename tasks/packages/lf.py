from pyinfra.operations import pacman


pacman.packages(
    name="Install lf",
    packages=[
        "lf"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
