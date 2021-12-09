from glob import glob
from pathlib import Path
from pyinfra.api import deploy
from pyinfra.operations import files
from pyinfra.operations import git
from pyinfra.operations import pacman
from pyinfra.operations import server


# TODO: move package installation to respective function
@deploy("Install packages")
def packages(state=None, host=None, cfg=None):
    pacman.packages(
        name="Install base packages [1/2]",
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

    files.put(
        name="Deploy git config",
        src="dotfiles/.gitconfig",
        dest=f"{cfg.home}/.gitconfig",
        state=state,
        host=host
    )

    git.repo(
        name="Clone pacman wrapper",
        src="https://aur.archlinux.org/trizen.git",
        dest=f"{cfg.home}/.local/src/trizen",
        state=state,
        host=host
    )

    server.shell(
        name="Install pacman wrapper",
        commands=[
            f"cd {cfg.home}/.local/src/trizen/ && makepkg -si --noconfirm"
        ],
        state=state,
        host=host
    )

    server.shell(
        name="Install base packages [2/2] (AUR)",
        commands=[
            "trizen -Syu --noconfirm autojump"
        ],
        state=state,
        host=host
    )


@deploy("Configure shell")
def shell(state=None, host=None, cfg=None):
    git.repo(
        name="Clone Prezto",
        src="https://github.com/sorin-ionescu/prezto.git",
        dest=f"{cfg.home}/.zprezto",
        update_submodules=True,
        recursive_submodules=True,
        state=state,
        host=host
    )

    files.sync(
        name="Sync Prezto configs",
        src="dotfiles/.zprezto/runcoms",
        dest=f"{cfg.home}/.zprezto/runcoms",
        exclude="*.j2",
        state=state,
        host=host
    )

    files.template(
        name="Deploy .zprofile",
        src="dotfiles/.zprezto/runcoms/zprofile.j2",
        dest=f"{cfg.home}/.zprezto/runcoms/zprofile",
        hostname=cfg.hostname,
        state=state,
        host=host
    )

    files.template(
        name="Deploy .zshenv",
        src="dotfiles/.zprezto/runcoms/zshenv.j2",
        dest=f"{cfg.home}/.zprezto/runcoms/zshenv",
        hostname=cfg.hostname,
        state=state,
        host=host
    )

    # glob the local dir for filenames,
    for zfile in glob("dotfiles/.zprezto/runcoms/z*"):
        zfile = Path(zfile).stem
        # but symlink the remote files
        files.link(
            name=f"Symlink {zfile}",
            target=f"{cfg.home}/.zprezto/runcoms/{zfile}",
            path=f"{cfg.home}/.{zfile}",
            state=state,
            host=host
        )

    files.put(
        name="Install Prezto theme",
        src="dotfiles/.zprezto/modules/prompt/functions/prompt_kyoto_setup",
        dest=f"{cfg.home}/.zprezto/modules/prompt/functions/prompt_kyoto_setup",
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

    files.sync(
        name="Deploy Pywal configs",
        src="dotfiles/.config/wal",
        dest=f"{cfg.home}/.config/wal",
        state=state,
        host=host
    )

    server.shell(
        name="Apply Pywal theme",
        commands=[
            "wal --theme blank"
        ],
        state=state,
        host=host
    )


@deploy("Configure text editor")
def editor(state=None, host=None, cfg=None):
    files.sync(
        name="Deploy Neovim configs",
        src="dotfiles/.config/nvim",
        dest=f"{cfg.home}/.config/nvim",
        state=state,
        host=host
    )

    files.link(
        name="Symlink vim -> nvim",
        target="/usr/bin/nvim",
        path="/usr/bin/vim",
        sudo=True,
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


@deploy("Configure file manager")
def file_manager(state=None, host=None, cfg=None):
    files.sync(
        name="Deploy ranger configs",
        src="dotfiles/.config/ranger",
        dest=f"{cfg.home}/.config/ranger",
        state=state,
        host=host
    )
