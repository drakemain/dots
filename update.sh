#!/bin/bash
# Update dotfiles from home directory

# Copy if file exists
[ -f ~/.zshrc ] && cp ~/.zshrc ./.zshrc
[ -d ~/.oh-my-zsh.local ] && cp -r ~/.oh-my-zsh.local/* ./.oh-my-zsh.local/
[ -f ~/.vimrc ] && cp ~/.vimrc ./.vimrc
[ -f ~/.Xdefaults ] && cp ~/.Xdefaults ./.Xdefaults
[ -f ~/.gitconfig ] && cp ~/.gitconfig ./.gitconfig
[ -f ~/.ssh/config ] && cp ~/.ssh/config ./ssh-config
[ -d ~/.config/nvim ] && cp -r ~/.config/nvim/* ./nvim/
[ -d ~/.config/ghostty ] && cp -r ~/.config/ghostty/* ./ghostty/

echo "Dotfiles updated from home directory"
