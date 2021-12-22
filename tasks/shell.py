from glob import glob
from os.path import basename
from pyinfra import host
from pyinfra.facts.server import *
from pyinfra.operations import files
from pyinfra.operations import pacman


home = host.get_fact(Home)
hostname = host.get_fact(Hostname)


files.rsync(
    name="Deploy git config",
    src="dotfiles/.gitconfig",
    dest=f"{home}/.gitconfig"
)


files.rsync(
    name="Sync Prezto configs",
    src="dotfiles/.zprezto/runcoms",
    dest=f"{home}/.zprezto/runcoms",
    flags=[
        "--exclude '*.j2'"
    ]
)


files.template(
    name="Deploy .zprofile",
    src="dotfiles/.zprezto/runcoms/zprofile.j2",
    dest=f"{home}/.zprezto/runcoms/zprofile",
    hostname=hostname
)


files.template(
    name="Deploy .zshenv",
    src="dotfiles/.zprezto/runcoms/zshenv.j2",
    dest=f"{home}/.zprezto/runcoms/zshenv",
    hostname=hostname
)

for zfile in glob(f"{home}/.zprezto/runcoms/z*"):
    zfile = basename(zfile)
    files.link(
        name=f"Symlink {zfile}",
        target=f"{home}/.zprezto/runcoms/{zfile}",
        path=f"{home}/.{zfile}"
    )


files.rsync(
    name="Install Prezto theme",
    src="dotfiles/.zprezto/modules/prompt/functions/prompt_kyoto_setup",
    dest=f"{home}/.zprezto/modules/prompt/functions/prompt_kyoto_setup"
)


files.rsync(
    name="Deploy Neovim configs",
    src="dotfiles/.config/nvim",
    dest=f"{home}/.config/nvim"
)


files.link(
    name="Symlink vim -> nvim",
    target="/usr/bin/nvim",
    path="/usr/bin/vim",
    sudo=True
)


files.rsync(
    name="Deploy ranger configs",
    src="dotfiles/.config/ranger",
    dest=f"{home}/.config/ranger"
)
