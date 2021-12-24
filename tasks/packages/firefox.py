from pyinfra.operations import pacman


pacman.packages(
    name="Install Firefox",
    packages=[
        "firefox"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


#TODO install profile
