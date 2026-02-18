install:
	stow --no-folding -vt $(HOME) home

uninstall:
	stow -Dvt $(HOME) home

all:
	install
