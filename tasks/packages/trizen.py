from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.operations import git
from pyinfra.operations import server


home = host.get_fact(Home)


git.repo(
    name="Clone Trizen",
    src="https://aur.archlinux.org/trizen.git",
    dest=f"{home}/.local/src/trizen"
)


server.shell(
    name="Install Trizen",
    commands=[
        f"cd {home}/.local/src/trizen/ && makepkg -si --noconfirm"
    ]
)
