from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import server


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy feh configs",
    src="dotfiles/.fehbg.j2",
    dest=f"{home}/.fehbg",
    home=home,
    hostname=hostname
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
