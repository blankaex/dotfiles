from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import server


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Sync Prezto configs",
    src="dotfiles/.zprezto/runcoms/",
    dest=f"{home}/.zprezto/runcoms/",
    flags=[
        "-a",
        "--exclude '*.j2'"
    ]
)


files.template(
    name="Deploy .zprofile",
    src="dotfiles/.zprezto/runcoms/zprofile.j2",
    dest=f"{home}/.zprezto/runcoms/zprofile",
    hostname=hostname
)
