install:
	stow --no-folding -vt $(HOME) home
	ln -sf $(XDG_CACHE_HOME)/wal/colors.Xresources $(HOME)/.Xresources
	ln -sf $(XDG_CACHE_HOME)/wal/colors-alacritty.toml $(XDG_CONFIG_HOME)/alacritty/alacritty.toml
	ln -sf $(XDG_CACHE_HOME)/wal/colors-ghostty.theme $(XDG_CONFIG_HOME)/ghostty/themes/wal
	ln -sf $(XDG_CACHE_HOME)/wal/colors-fcitx-theme.conf $(XDG_DATA_HOME)/fcitx5/themes/pywal/theme.conf

uninstall:
	stow -Dvt $(HOME) home
	rm $(HOME)/.Xresources
	rm $(XDG_CONFIG_HOME)/alacritty/alacritty.toml
	rm $(XDG_CONFIG_HOME)/ghostty/themes/wal
	rm $(XDG_DATA_HOME)/fcitx5/themes/pywal/theme.conf

all:
	install
