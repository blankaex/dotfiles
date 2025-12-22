from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import systemd


home = host.get_fact(Home)


pacman.packages(
    name="Install mpd + dependencies",
    packages=[
        "mpd",
        "mpc",
        "rmpc",
        "ueberzugpp",
        "cava",
        "inotify-tools"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


systemd.service(
    name="Enable mpd",
    service="mpd",
    running=True,
    enabled=True,
    user_mode=True
)
