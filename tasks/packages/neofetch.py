from pyinfra.operations import pacman


pacman.packages(
    name="Install neofetch",
    packages=[
        "neofetch"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
