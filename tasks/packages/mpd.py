from pyinfra.operations import pacman


pacman.packages(
    name="Install mpd + dependencies",
    packages=[
        "mpd",
        "mpc",
        "ncmpcpp",
        "ueberzug",
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


files.rsync(
    name="Touch cover image",
    src="dotfiles/.config/ncmpcpp/cover.png",
    dest=f"{home}/.cache/cover.png"
)
