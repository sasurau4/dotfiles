#orginally
export PATH=/usr/local:$PATH

#loading
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G' 

# PYTHONPATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

#GOPATH
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin



# Shortcuts
alias d="cd ~/Documents/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
alias g="git"
alias h="history"
alias j="jobs"
alias gst="git status"
alias grv="git remote -v"
alias gcm="git commit -m"
alias gc="git checkout"
alias gaa="git add *"
alias gb="git branch"
alias gbb="git branch -b"

export PATH="$HOME/.cargo/bin:$PATH"

if [ "$(uname)" = "Darwin" ]; then
  export PATH="${PATH}:${HOME}/homebrew/bin"
  export SHELL=${HOME}/homebrew/bin/zsh
  exec ${HOME}/homebrew/bin/zsh -l
fi
