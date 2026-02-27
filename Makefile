install:
	stow --no-folding -vt $(HOME) home
	ln -sf $(XDG_CACHE_HOME)/wal/colors.Xresources $(HOME)/.Xresources
	ln -sf $(XDG_CACHE_HOME)/wal/colors-alacritty.toml $(XDG_CONFIG_HOME)/alacritty/alacritty.toml

uninstall:
	stow -Dvt $(HOME) home
	rm $(HOME)/.Xresources
	rm $(XDG_CONFIG_HOME)/alacritty/alacritty.toml

all:
	install
