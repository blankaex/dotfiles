from pyinfra.operations import pacman


pacman.packages(
    name="Install Thunderbird",
    packages=[
        "thunderbird"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
