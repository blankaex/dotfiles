#!/usr/bin/bash
mkdir -p "$HOME/.config/nvim/autoload" "$HOME/.config/nvim/bundle"
test -e "$HOME/.config/nvim/autoload/pathogen.vim" ||
    curl -LSso "$HOME/.config/nvim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

test -e "$HOME/.config/nvim/bundle/fcitx.vim" ||
    git clone https://github.com/vim-scripts/fcitx.vim "$HOME/.config/nvim/bundle/fcitx.vim"
test -e "$HOME/.config/nvim/bundle/goyo.vim" ||
    git clone https://github.com/junegunn/goyo.vim "$HOME/.config/nvim/bundle/goyo.vim"
test -e "$HOME/.config/nvim/bundle/vim-commentary" ||
    git clone https://github.com/tpope/vim-commentary "$HOME/.config/nvim/bundle/vim-commentary"
test -e "$HOME/.config/nvim/bundle/vim-surround" ||
    git clone https://github.com/tpope/vim-surround "$HOME/.config/nvim/bundle/vim-surround"
test -e "$HOME/.config/nvim/bundle/wal.vim" ||
    git clone https://github.com/dylanaraps/wal.vim "$HOME/.config/nvim/bundle/wal.vim"
