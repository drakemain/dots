#!/bin/bash

cp ./.vimrc_home ~/.vimrc
cp ./.gvimrc_home ~/.gvimrc

mkdir -p ~/.vim/bundle

cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ./Vundle.vim
vim +PluginInstall +qall

cd YouCompleteMe
python3 install.py --rust-completer --clang-completer
