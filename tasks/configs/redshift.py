from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy Redshift configs",
    src="dotfiles/.config/redshift",
    dest=f"{home}/.config/redshift"
)
