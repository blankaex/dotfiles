from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import server


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


pacman.packages(
    name="Install feh",
    packages=[
        "feh"
    ],
    update=True,
    upgrade=True,
    sudo=True
)

server.shell(
    name="Create wallpaper directory",
    commands=[
        f"mkdir -p {home}/Pictures/wallpapers/"
    ]
)

files.rsync(
    name="Deploy temporary wallpaper",
    src="config/wallpaper.jpg",
    dest=f"{home}/Pictures/wallpapers/wallpaper.jpg"
)
