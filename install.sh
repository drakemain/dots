#!/bin/bash

DOTS_DIR=$(pwd)

# -- Arch

# install base packages
sudo pacman -Syw gvim cmake clang curl wget zsh git rustup man-db neovim neovide

#install omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh

# copy configs
mkdir -p ~/.config/alacritty/
cp ./alacritty.toml ~/.config/alacritty/alacritty.toml
cp ./.zshrc ~/.zshrc
cp -r ./.oh-my-zsh.local/ ~/.oh-my-zsh.local/
cp ./.vimrc ~/.vimrc
cp ./.gvimrc ~/.gvimrc
cp ./.Xdefaults ~/.Xdefaults
cp ./.gitconfig ~/.gitconfig
cp ./ssh-config ~/.ssh/config
cp -r nvim/ ~/.config/nvim/

# install rust
rustup default stable

# install paru
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru && makepkg -si

cd DOTS_DIR
# -- /Arch

# install nvm, node lts
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts

mkdir -p ~/.vim/bundle
mkdir -p ~/.config/urxvt/colorschemes

# cd ~/.vim/bundle
# git clone https://github.com/VundleVim/Vundle.vim.git ./Vundle.vim
# vim +PluginInstall +qall
#
# cd YouCompleteMe
# python3 install.py --rust-completer --clang-completer --ts-completer --go-completer
