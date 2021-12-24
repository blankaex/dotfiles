from pyinfra.operations import pacman


pacman.packages(
    name="Install Redshift",
    packages=[
        "redshift"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
