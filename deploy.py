import json
import re

from deploys import apps
from deploys import base
from deploys import gui

from pyinfra import host
from pyinfra.facts.server import Home
from pyinfra.facts.server import Hostname

dispatch_base = {
    1: base.packages,
    2: base.shell,
    3: base.editor,
    4: base.file_manager
}

dispatch_gui = {
    1: gui.packages,
    2: gui.display,
    3: gui.wm,
    4: gui.hotkey,
    5: gui.monitor,
    6: gui.run_dialog,
    7: gui.notification,
    8: gui.wallpaper,
    9: gui.gtk,
    10: gui.ime,
    11: gui.audio
}

dispatch_apps = {
    1: apps.terminal,
    2: apps.browser,
    3: apps.torrent,
    4: apps.image,
    5: apps.video,
    6: apps.music,
    7: apps.mail,
    8: apps.document
}

# don't look at this
def prompt(dispatch, name):
    print(f"\n\nSelect {name} packages (0 = ALL, RETURN = NONE):")
    print("    ".join([ f"[{i}] {dispatch[i].__name__}" for i in dispatch ]))
    return [int(i) for i in re.sub("[^0-9|\s]", "", input("\nPackages: ")).split()]

class config():
    home = host.get_fact(Home)
    hostname = host.get_fact(Hostname)

    # TODO update to read from remote
    with open(f"{home}/.cache/wal/colors.json") as f:
        colors = json.load(f)

    commands_base = prompt(dispatch_base, "base")
    commands_gui = prompt(dispatch_gui, "GUI")
    commands_apps = prompt(dispatch_apps, "application")

cfg = config()

for command in dispatch_base:
    if command in cfg.commands_base or 0 in cfg.commands_base:
        dispatch_base[command](cfg=cfg)

for command in dispatch_gui:
    if command in cfg.commands_gui or 0 in cfg.commands_gui:
        dispatch_gui[command](cfg=cfg)

for command in dispatch_apps:
    if command in cfg.commands_apps or 0 in cfg.commands_apps:
        dispatch_apps[command](cfg=cfg)
