from pyinfra.operations import server


server.shell(
    name="Install Polybar",
    commands=[
      "trizen -Syu --noconfirm polybar"
    ]
)
