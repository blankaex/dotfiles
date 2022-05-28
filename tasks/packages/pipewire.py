from pyinfra.operations import systemd
from pyinfra.operations import pacman


pacman.packages(
    name="Install Pipewire",
    packages=[
        "pipewire",
        "pipewire-pulse",
        "pipewire-alsa",
        "pavucontrol"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


systemd.service(
    name="Configure PipeWire",
    service="pipewire-pulse",
    running=True,
    enabled=True,
    user_mode=True
)
