from pyinfra.operations import pacman
from pyinfra.operations import server


pacman.packages(
    name="Install sxhkd",
    packages=[
        "sxhkd",
        "ruby",
        "maim"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


server.shell(
    name="Install i3lock-color",
    commands=[
      "trizen -Syu --noconfirm i3lock-color"
    ]
)
