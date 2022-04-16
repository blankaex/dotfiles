from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import server


home = host.get_fact(Home)


files.rsync(
    name="Deploy pywal configs",
    src="dotfiles/.config/wal/",
    dest=f"{home}/.config/wal/",
    flags=[
        "-a"
    ]
)


server.shell(
    name="Install pywal theme",
    commands=[
        "wal --theme blank"
    ]
)
