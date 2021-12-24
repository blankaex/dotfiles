from pyinfra.operations import pacman


pacman.packages(
    name="Install Rofi",
    packages=[
        "rofi"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
