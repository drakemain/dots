#!/bin/bash

DOTS_DIR=$(pwd)

# -- Arch

# install base packages
sudo pacman -Sy cmake clang curl wget zsh git rustup man-db neovim neovide ghostty

#install omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh

# copy configs
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/ghostty/
cp -r ./ghostty/* ~/.config/ghostty/
cp ./.zshrc ~/.zshrc
cp -r ./.oh-my-zsh.local/ ~/.oh-my-zsh.local/
cp ./.vimrc ~/.vimrc
cp ./.Xdefaults ~/.Xdefaults
cp ./.gitconfig ~/.gitconfig
cp ./ssh-config ~/.ssh/config
cp -r nvim/* ~/.config/nvim/

# install rust
rustup default stable

# install paru
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru && makepkg -si

cd $DOTS_DIR
# -- /Arch

# install nvm, node lts
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts

mkdir -p ~/.vim/bundle
mkdir -p ~/.config/urxvt/colorschemes
