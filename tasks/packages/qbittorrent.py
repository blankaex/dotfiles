from pyinfra.operations import server


server.shell(
    name="Install qBittorrent",
    commands=[
      "trizen -Syu --noconfirm qbittorrent-enhanced-qt5"
    ]
)
