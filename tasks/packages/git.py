from pyinfra.operations import pacman


pacman.packages(
    name="Install git",
    packages=[
        "git",
        "subversion"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
