from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.template(
    name="Deploy feh configs",
    src="dotfiles/.fehbg.j2",
    dest=f"{home}/.fehbg",
    home=home
)
