from pyinfra.operations import pacman


pacman.packages(
    name="Install Pipewire",
    packages=[
        "pipewire",
        "pipewire-pulse"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
