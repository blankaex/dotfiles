from pyinfra.operations import server


server.shell(
    name="Install ahoviewer",
    commands=[
      "trizen -Syu --noconfirm ahoviewer-git"
    ]
)
