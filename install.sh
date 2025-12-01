#!/bin/bash

DOTS_DIR=$(pwd)

# -- Arch

# install base packages
sudo pacman -Sy cmake clang curl wget zsh git rustup man-db neovim neovide ghostty fakeroot debugedit

#install omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh

# Check if GPG key exists, if not generate one
if ! gpg --list-secret-keys --keyid-format=long | grep -q "sec"; then
    echo "No GPG key found. Generating ed25519 key..."

    # Generate key non-interactively
    gpg --batch --passphrase '' --quick-gen-key "Drake Main <drakemain@protonmail.com>" ed25519 sign never

    echo "GPG key generated successfully."
else
    echo "Existing GPG key found."
fi

# Get the signing key ID
GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep "sec" | head -n 1 | awk '{print $2}' | cut -d'/' -f2)

echo "Using GPG key: $GPG_KEY_ID"

# Update .gitconfig with the GPG key before copying
sed -i "s/signingkey = .*/signingkey = $GPG_KEY_ID/" ./.gitconfig

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
cp ./plasma/*.* ~/.config/
mkdir -p ~/.local/share/color-schemes/
cp ./plasma/color-schemes/* ~/.local/share/color-schemes/

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
