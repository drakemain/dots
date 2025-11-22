export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
export PATH=$HOME/.cargo/bin:$PYENV_ROOT:$HOME/scripts:$PATH
export LANG=en_US.UTF-8
export LIBCLANG_PATH=/usr/lib/libclang.so

source ~/.oh-my-zsh.local/theme.zsh-theme

alias pacup="sudo pacman -Syu"
alias pacin="sudo pacman -Sy"
alias pacun="sudo pacman -Rs"
alias ls="ls -h --color=auto"
alias ll="ls -lh --color=auto"
alias fix-playback="killall pulseaudio; rm -r ~/.config/pulse/*"
alias vim="neovide . &"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#source /usr/share/nvm/nvm.sh
#source /usr/share/nvm/bash_completion
#source /usr/share/nvm/install-nvm-exec

export gpg_tty=$(tty)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
