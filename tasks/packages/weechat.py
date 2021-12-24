from pyinfra.operations import pacman


pacman.packages(
    name="Install WeeChat",
    packages=[
        "weechat"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
