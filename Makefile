install:
	stow --no-folding -vt $(HOME) home
	ln -sf $(XDG_CACHE_HOME)/wal/colors.Xresources $(HOME)/.Xresources

uninstall:
	stow -Dvt $(HOME) home
	rm $(HOME)/.Xresources

all:
	install
