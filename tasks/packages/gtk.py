from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.operations import server


home = host.get_fact(Home)


server.shell(
    name="Install gtk packages",
    commands=[
      "trizen -Syu --noconfirm gtk2-patched-filechooser-icon-view gtk3-patched-filechooser-icon-view xcursor-openzone"
    ]
)


server.shell(
    name="Download gtk icons",
    commands=[
        f"svn checkout https://github.com/ahodesuka/dotfiles/trunk/.icons/ahoka {home}/.icons/ahoka"
    ]
)
