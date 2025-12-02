# Environment variables
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
export PATH=$HOME/.cargo/bin:$PYENV_ROOT:$HOME/scripts:$PATH:$HOME/.local/bin
export LANG=en_US.UTF-8
export LIBCLANG_PATH=/usr/lib/libclang.so
export gpg_tty=$(tty)

# Theme
source ~/.oh-my-zsh.local/theme.zsh-theme

# Aliases
alias pacup="sudo pacman -Syu"
alias pacin="sudo pacman -Sy"
alias pacun="sudo pacman -Rs"
alias ll="eza --long"
alias fix-playback="killall pulseaudio; rm -r ~/.config/pulse/*"
alias vim="neovide . &"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
