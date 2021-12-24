from pyinfra.operations import pacman


pacman.packages(
    name="Install feh",
    packages=[
        "feh"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
