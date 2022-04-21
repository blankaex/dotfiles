from pyinfra.operations import pacman


pacman.packages(
    name="Install Synaptics driver",
    packages=[
        "xf86-input-synaptics"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
