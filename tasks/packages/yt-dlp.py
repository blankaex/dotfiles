from pyinfra.operations import pacman


pacman.packages(
    name="Install yt-dlp",
    packages=[
        "yt-dlp"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
