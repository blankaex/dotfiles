from pyinfra.operations import pacman
from pyinfra.operations import server


pacman.packages(
    name="Install fonts",
    packages=[
        "adobe-source-code-pro-fonts",
        "adobe-source-han-sans-jp-fonts",
        "noto-fonts",
        "noto-fonts-cjk",
        "noto-fonts-emoji"
    ],
    update=True,
    upgrade=True,
    sudo=True
)


server.shell(
    name="Install fonts (AUR)",
    commands=[
      "trizen -Syu --noconfirm otf-source-han-code-jp"
    ]
)
