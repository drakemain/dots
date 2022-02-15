#!/bin/bash

DOTS_DIR=$(pwd)

# -- Arch

sudo pacman -S gvim base-devel cmake clang clangd curl wget zsh python git go

# install yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

cd DOTS_DIR
# -- /Arch

# install nvm, node lts
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts

#install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir -p ~/.vim/bundle
mkdir -p ~/.config/urxvt/colorschemes

cp ./.vimrc ~/.vimrc
cp ./.gvimrc ~/.gvimrc
cp ./.zshrc

cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ./Vundle.vim
vim +PluginInstall +qall

cd YouCompleteMe
python3 install.py --rust-completer --clangd-completer --ts-completer --go-completer
