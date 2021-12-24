from pyinfra.operations import pacman


pacman.packages(
    name="Install Xorg",
    packages=[
        "xorg",
        "xorg-xev",
        "xorg-xinit",
        "xorg-xkill",
        "xorg-xprop",
        "xorg-xrandr",
        "xcape"
    ],
    sudo=True
)
