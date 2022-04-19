from pyinfra.operations import pacman


pacman.packages(
    name="Install ripgrep",
    packages=[
        "ripgrep"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
