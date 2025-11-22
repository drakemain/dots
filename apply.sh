#!/bin/bash
# Apply dotfiles from this repo to home directory

# Always apply these basic configs
[ -f ./.zshrc ] && cp ./.zshrc ~/.zshrc
[ -d ./.oh-my-zsh.local ] && mkdir -p ~/.oh-my-zsh.local && cp -r ./.oh-my-zsh.local/* ~/.oh-my-zsh.local/
[ -f ./.vimrc ] && cp ./.vimrc ~/.vimrc
[ -f ./.Xdefaults ] && cp ./.Xdefaults ~/.Xdefaults
[ -f ./.gitconfig ] && cp ./.gitconfig ~/.gitconfig
[ -f ./ssh-config ] && mkdir -p ~/.ssh && cp ./ssh-config ~/.ssh/config

# Only apply if the application is installed
if command -v nvim &> /dev/null && [ -d ./nvim ]; then
    mkdir -p ~/.config/nvim
    cp -r ./nvim/* ~/.config/nvim/
    echo "✓ Applied nvim config"
fi

if command -v ghostty &> /dev/null && [ -d ./ghostty ]; then
    mkdir -p ~/.config/ghostty
    cp -r ./ghostty/* ~/.config/ghostty/
    echo "✓ Applied ghostty config"
fi

if command -v neovide &> /dev/null && [ -d ./neovide ]; then
    mkdir -p ~/.config/neovide
    cp -r ./neovide/* ~/.config/neovide/
    echo "✓ Applied neovide config"
fi

echo "Dotfiles applied to home directory"
