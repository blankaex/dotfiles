from pyinfra.operations import pacman


pacman.packages(
    name="Install Pipewire",
    packages=[
        "pipewire",
        "pipewire-pulse",
        "pavucontrol"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
