#PATH exclde same path
typeset -U path cdpath fpath manpath

#PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

#LS
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G'

#PYTHONPATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

#alias
alias g="git"
alias gco="git checkout"
alias gst="git status"
alias gcm="git commit -m"
alias gaa="git add ."
alias gsl="git stash list"
alias gb="git branch"
alias sagu="sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean"

#HISTORY
HISTFILE=$HOME/dotfiles/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

#HISTORY OPTIONS
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyを共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

#漢のzshから転用
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload -Uz colors
colors


# prompt
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# git設定
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd
# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Completion configuration
#
autoload -U compinit
compinit

## Alias configuration

# expand aliases before completing


#補完でカラーを使用する
zstyle ':completion:*' list-colors "${LS_COLORS}"
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"


alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# Golang
export GOPATH=${HOME}/.go
export PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rust
export PATH="${PATH}:${HOME}/.cargo/bin"

#EXERCISM
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi

# Mac OS for work
if [ "$(uname)" = "Darwin" ]; then
  export PATH="${PATH}:${HOME}/homebrew/bin"
  alias vim=${HOME}/homebrew/bin/vim
  alias atom="/Applications/Atom.app/Contents/Resources/app/atom.sh"
  alias android-studio="open -a /Applications/Android\ Studio.app/"
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/platform-tools
fi
