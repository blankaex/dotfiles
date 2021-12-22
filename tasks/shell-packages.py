from pyinfra.operations import git
from pyinfra.operations import pacman
from pyinfra.operations import server

#TODO

pacman.packages(
    name="Install pacman packages",
    packages=[
        "git",
        "subversion",
        "zsh",
        "python-pywal",
        "neovim",
        "ranger"
    ],
    update=True,
    upgrade=True,
    sudo=True,
    state=state,
    host=host
)

git.repo(
    name="Clone Pacman wrapper",
    src="https://aur.archlinux.org/trizen.git",
    dest=f"{cfg.home}/.local/src/trizen",
    state=state,
    host=host
)

server.shell(
    name="Install Pacman wrapper",
    commands=[
        f"cd {cfg.home}/.local/src/trizen/ && makepkg -si --noconfirm"
    ],
    state=state,
    host=host
)

server.shell(
    name="Install AUR packages",
    commands=[
        "trizen -Syu --noconfirm autojump"
    ],
    state=state,
    host=host
)


git.repo(
    name="Clone Prezto",
    src="https://github.com/sorin-ionescu/prezto.git",
    dest=f"{cfg.home}/.zprezto",
    update_submodules=True,
    recursive_submodules=True,
    state=state,
    host=host
)

git.repo(
    name="Clone zsh-git-prompt",
    src="https://github.com/blankaex/zsh-git-prompt",
    dest=f"{cfg.home}/.local/src/zsh-git-prompt",
    state=state,
    host=host
)

server.shell(
    name="Install vim-plug",
    commands=[
        f"sh -c 'curl -fLo {cfg.home}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
    ],
    state=state,
    host=host
)
