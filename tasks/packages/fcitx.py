from pyinfra.operations import pacman


pacman.packages(
    name="Install fcitx",
    packages=[
        "fcitx",
        "fcitx-configtool",
        "fcitx-mozc"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
