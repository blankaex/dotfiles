from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import systemd


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


systemd.service(
    name="Configure PipeWire",
    service="pipewire-pulse",
    running=True,
    enabled=True,
    user_mode=True
)
