from pyinfra.api import deploy
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import server
from pyinfra.operations import systemd

#TODO

pacman.packages(
    name="Install gui packages [1/2]",
    packages=[
        "xorg",
        "xorg-xinit",
        "bspwm",
        "ruby",
        "maim",
        "sxhkd",
        "rofi",
        "dunst",
        "redshift",
        "pipewire-pulse",
        "feh",
        "sxiv",
        "ueberzug",
        "xcape",
        "fcitx",
        "fcitx-mozc",
        "fcitx-configtool",
        "adobe-source-code-pro-fonts",
        "adobe-source-han-sans-jp-fonts",
        "noto-fonts",
        "noto-fonts-cjk"
    ],
    sudo=True
)


# TODO investigate why this step takes 10 years
server.shell(
    name="Install gui packages [2/2] (AUR)",
    commands=[
      "trizen -Syu --noconfirm polybar i3lock-color otf-source-han-code-jp gtk2-patched-filechooser-icon-view gtk3-patched-filechooser-icon-view xcursor-openzone"
    ]
)


server.shell(
    name="Download gtk icons",
    commands=[
        f"svn checkout https://github.com/ahodesuka/dotfiles/trunk/.icons/ahoka {cfg.home}/.icons/ahoka"
    ],
)
