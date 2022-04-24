from glob import glob
from os.path import basename
from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.operations import git 
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import server


home = host.get_fact(Home)


pacman.packages(
    name="Install zsh",
    packages=[
        "zsh"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


server.shell(
    name="Install autojump",
    commands=[
      "trizen -Syu --noconfirm autojump"
    ]
)


git.repo(
    name="Clone Prezto",
    src="https://github.com/sorin-ionescu/prezto.git",
    dest=f"{home}/.zprezto",
    update_submodules=True,
    recursive_submodules=True
)


for zfile in glob(f"{home}/.zprezto/runcoms/z*"):
    zfile = basename(zfile)
    files.link(
        name=f"Symlink {zfile}",
        target=f"{home}/.zprezto/runcoms/{zfile}",
        path=f"{home}/.{zfile}"
    )


server.shell(
    name="Touch secret env vars",
    commands=[
      f"touch {home}/.config/.secrets"
    ]
)


files.rsync(
    name="Install Prezto theme",
    src="dotfiles/.zprezto/modules/prompt/functions/prompt_kyoto_setup",
    dest=f"{home}/.zprezto/modules/prompt/functions/prompt_kyoto_setup"
)


git.repo(
    name="Clone zsh-git-prompt",
    src="https://github.com/blankaex/zsh-git-prompt",
    dest=f"{home}/.local/src/zsh-git-prompt"
)
