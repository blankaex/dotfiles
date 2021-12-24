from pyinfra.operations import pacman


pacman.packages(
    name="Install qBittorrent",
    packages=[
        "qbittorrent"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
