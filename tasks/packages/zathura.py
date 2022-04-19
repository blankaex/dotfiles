from pyinfra.operations import pacman


pacman.packages(
    name="Install zathura",
    packages=[
        "zathura",
        "zathura-pdf-mupdf"
    ],
    update=True,
    upgrade=True,
    sudo=True
)
