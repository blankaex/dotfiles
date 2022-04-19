from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import git
from pyinfra.operations import systemd


home = host.get_fact(Home)


git.repo(
    name="Clone startpage",
    src="https://github.com/blankaex/devola",
    dest=f"{home}/.local/src/devola"
)


files.template(
    name="Deploy startpage service",
    src="root/etc/systemd/system/startpage.service.j2",
    dest=f"/etc/systemd/system/startpage.service",
    sudo=True,
    home=home
)


systemd.service(
    name="Enable startpage service",
    service="startpage",
    running=True,
    enabled=True,
    user_mode=True
)
