from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)


files.rsync(
    name="Deploy emoji list",
    src="dotfiles/.local/share/emoji",
    dest=f"{home}/.local/share/emoji"
)
