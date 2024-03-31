export PYENV_ROOT="$HOME/.pyenv"
export PATH=$HOME/.cargo/bin:$PYENV_ROOT:$HOME/scripts:$PATH
export LANG=en_US.UTF-8

source ~/.oh-my-zsh.local/theme.zsh-theme

alias pacup="sudo pacman -Syu"
alias pacin="sudo pacman -Sy"
alias pacun="sudo pacman -Rs"
alias ls="ls -h --color=auto"
alias ll="ls -lh --color=auto"
alias fix-playback="killall pulseaudio; rm -r ~/.config/pulse/*"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# nvm
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

export gpg_tty=$(tty)
