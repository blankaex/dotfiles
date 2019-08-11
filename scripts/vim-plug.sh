#!/usr/bin/bash
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle"
curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

git clone https://github.com/vim-scripts/fcitx.vim "$HOME/.vim/bundle/"
git clone https://github.com/junegunn/goyo.vim "$HOME/.vim/bundle/"
git clone https://github.com/tpope/vim-commentary "$HOME/.vim/bundle/"
git clone https://github.com/tpope/vim-surround "$HOME/.vim/bundle/"
git clone https://github.com/dylanaraps/wal.vim/tree/master/colors "$HOME/.vim/bundle/"
