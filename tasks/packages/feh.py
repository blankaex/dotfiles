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

files.rsync(
    name="Deploy temporary wallpaper",
    src="config/wallpaper.jpg",
    dest=f"{home}/Pictures/wallpapers/wallpaper.jpg"
)


server.shell(
    name="Apply temporary wallpaper",
    commands=[
        f"feh --bg-fill {home}/Pictures/wallpapers/wallpaper.jpg"
    ]
)
