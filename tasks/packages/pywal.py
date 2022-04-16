from pyinfra.operations import pacman


pacman.packages(
    name="Install pywal",
    packages=[
        "python-pywal"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
