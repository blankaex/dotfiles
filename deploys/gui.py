from pyinfra.api import deploy
from pyinfra.operations import files
from pyinfra.operations import pacman
from pyinfra.operations import server
from pyinfra.operations import systemd

# TODO: move package installation to respective function
@deploy("Install packages")
def packages(state=None, host=None, cfg=None):
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
        sudo=True,
        state=state,
        host=host
    )

    # TODO investigate why this step takes 10 years
    server.shell(
        name="Install gui packages [2/2] (AUR)",
        commands=[
          "trizen -Syu --noconfirm polybar i3lock-color otf-source-han-code-jp gtk2-patched-filechooser-icon-view gtk3-patched-filechooser-icon-view xcursor-openzone"
        ],
       state=state,
       host=host
    )


@deploy("Configure display server")
def display(state=None, host=None, cfg=None):
    files.template(
        name="Deploy xinit configs",
        src="dotfiles/.xinitrc.j2",
        dest=f"{cfg.home}/.xinitrc",
        hostname=cfg.hostname,
        state=state,
        host=host
    )

    files.sync(
        name="Deploy Redshift configs",
        src="dotfiles/.config/redshift",
        dest=f"{cfg.home}/.config/redshift",
        state=state,
        host=host
    )


@deploy("Configure window manager")
def wm(state=None, host=None, cfg=None):
    files.sync(
        name="Deploy bspwm configs [1/2]",
        src="dotfiles/.config/bspwm",
        dest=f"{cfg.home}/.config/bspwm",
        exclude="*.j2",
        state=state,
        host=host
    )

    files.template(
        name="Deploy bspwm configs [2/2]",
        src="dotfiles/.config/bspwm/bspwmrc.j2",
        dest=f"{cfg.home}/.config/bspwm/bspwmrc",
        hostname=cfg.hostname,
        state=state,
        host=host
    )


@deploy("Configure hotkey daemon")
def hotkey(state=None, host=None, cfg=None):
    files.sync(
        name="Deploy sxhkd configs [1/2]",
        src="dotfiles/.config/sxhkd",
        dest=f"{cfg.home}/.config/sxhkd",
        exclude="*.j2",
        state=state,
        host=host
    )

    files.template(
        name="Deploy sxhkd configs [2/2]",
        src="dotfiles/.config/sxhkd/sxhkdrc.j2",
        dest=f"{cfg.home}/.config/sxhkd/sxhkdrc",
        hostname=cfg.hostname,
        state=state,
        host=host
    )


@deploy("Configure monitor")
def monitor(state=None, host=None, cfg=None):
    files.template(
        name="Deploy polybar configs [1/2]",
        src="dotfiles/.config/polybar/config.j2",
        dest=f"{cfg.home}/.config/polybar/config",
        hostname=cfg.hostname,
        state=state,
        host=host
    )

    files.template(
        name="Deploy polybar configs [2/2]",
        src="dotfiles/.config/polybar/launch.sh.j2",
        dest=f"{cfg.home}/.config/polybar/launch.sh",
        hostname=cfg.hostname,
        state=state,
        host=host
    )


@deploy("Configure run dialog")
def run_dialog(state=None, host=None, cfg=None):
    files.sync(
        name="Deploy Rofi configs",
        src="dotfiles/.config/rofi",
        dest=f"{cfg.home}/.config/rofi",
        state=state,
        host=host
    )


@deploy("Configure notification daemon")
def notification(state=None, host=None, cfg=None):
    # TODO template screen geometry
    files.template(
        name="Deploy Dunst config [1/2]",
        src="dotfiles/.config//dunst/dunstrc.j2",
        dest=f"{cfg.home}/.config/dunst/dunstrc",
        colors=cfg.colors,
        home=cfg.home,
        state=state,
        host=host
    )

    # TODO template this
    files.template(
        name="Deploy Dunst config [2/2]",
        src="dotfiles/.config//dunst/notify-sound.sh.j2",
        dest=f"{cfg.home}/.config/dunst/notify-sound.sh",
        state=state,
        host=host
    )


@deploy("Configure wallpaper")
def wallpaper(state=None, host=None, cfg=None):
    # TODO download and set a temp wallpaper
    files.template(
        name="Deploy feh configs",
        src="dotfiles/.fehbg.j2",
        dest=f"{cfg.home}/.fehbg",
        hostname=cfg.hostname,
        state=state,
        host=host
    )


@deploy("Configure gtk")
def gtk(state=None, host=None, cfg=None):
    files.sync(
        name="Deploy gtk themes",
        src="dotfiles/.themes",
        dest=f"{cfg.home}/.themes",
        state=state,
        host=host
    )

    files.put(
        name="Deploy gtk2 config",
        src="dotfiles/.gtkrc-2.0",
        dest=f"{cfg.home}/.gtkrc-2.0",
        state=state,
        host=host
    )
    
    files.sync(
        name="Deploy gtk3 config",
        src="dotfiles/.config/gtk-3.0",
        dest=f"{cfg.home}/.config/gtk-3.0",
        state=state,
        host=host
    )
    
    files.sync(
        name="Deploy gtk file chooser config",
        src="dotfiles/.config/gtk-2.0",
        dest=f"{cfg.home}/.config/gtk-2.0",
        state=state,
        host=host
    )
    
    server.shell(
        name="Download gtk icons",
        commands=[
            f"svn checkout https://github.com/ahodesuka/dotfiles/trunk/.icons/ahoka {cfg.home}/.icons/ahoka"
        ],
        state=state,
        host=host
    )


@deploy("Configure input method editor")
def ime(state=None, host=None, cfg=None):
    # TODO template the skin maybe
    files.sync(
        name="Deploy fcitx configs",
        src="dotfiles/.config/fcitx",
        dest=f"{cfg.home}/.config/fcitx",
        state=state,
        host=host
    )


@deploy("Configure sound server")
def audio(state=None, host=None, cfg=None):
    systemd.service(
        name="Configure PipeWire",
        service="pipewire-pulse",
        running=True,
        enabled=True,
        user_mode=True,
        state=state,
        host=host
    )
