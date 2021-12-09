from pyinfra.api import deploy
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import server


@deploy("Install terminal emulator")
def terminal(state=None, host=None, cfg=None):
    pacman.packages(
        name="Install terminal emulator",
        packages=[
            "alacritty"
        ],
        update=True,
        upgrade=True,
        sudo=True,
        state=state,
        host=host
    )

    files.template(
        name="Deploy terminal emulator config",
        src="dotfiles/.config/alacritty/alacritty.yml.j2",
        dest=f"{cfg.home}/.config/alacritty/alacritty.yml",
        colors=cfg.colors,
        state=state,
        host=host
    )


@deploy("Install browser")
def browser(state=None, host=None, cfg=None):
    # ff viv
    pass


@deploy("Install torrent manager")
def torrent(state=None, host=None, cfg=None):
    pass


@deploy("Install image viewer")
def image(state=None, host=None, cfg=None):
    server.shell(
        name="Install image viewer",
        commands=[
          "trizen -Syu --noconfirm ahoviewer-git"
        ],
       state=state,
       host=host
    )


@deploy("Install video player")
def video(state=None, host=None, cfg=None):
    pass


@deploy("Install music player")
def music(state=None, host=None, cfg=None):
    # mpd mpc ncmpcpp
    pass


@deploy("Install mail client")
def mail(state=None, host=None, cfg=None):
    pacman.packages(
        name="Install mail client",
        packages=[
            "thunderbird"
        ],
        sudo=True,
        state=state,
        host=host
    )
    pass


@deploy("Install document viewer")
def document(state=None, host=None, cfg=None):
    pacman.packages(
        name="Install document viewer",
        packages=[
            "zathura",
            "zathura-pdf-mupdf"
        ],
        sudo=True,
        state=state,
        host=host
    )
