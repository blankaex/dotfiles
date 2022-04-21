from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy synaptics config",
    src="root/etc/X11/xorg.conf.d/70-synaptics.conf",
    dest=f"/etc/X11/xorg.conf.d/70-synaptics.conf",
    sudo=True
)
