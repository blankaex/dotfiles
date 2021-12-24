from pyinfra.operations import pacman


pacman.packages(
    name="Install Vivaldi",
    packages=[
        "vivaldi"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


#TODO install profile
