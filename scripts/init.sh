#!/bin/bash

set -eu
echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)
echo "${HOME}"
DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# install Rust
echo $(tput setaf 4)Install Rust.$(tput sgr0)
curl https://sh.rustup.rs -sSf | sh
echo $(tput setaf 4)Install Rust completed! ✔︎$(tput sgr0)
source $HOME/.cargo/env

echo $(tput setaf 4)Install daily development toolchains depend on platform.$(tput sgr0)
if [ "$(uname)" = "Darwin" ]; then
  echo $(tput setaf 4)OS is Mac OSX.$(tput sgr0)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install gh peco fish jq awscli
  # rcm
  brew tap thoughtbot/formulae
  brew install rcm

  # For shell change
  echo "$(which fish)" | sudo tee -a /etc/shells

elif [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
  echo $(tput setaf 4)OS is WSL2.$(tput sgr0)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo add-apt-repository ppa:wslutilities/wslu
  sudo apt update
  sudo apt install -y ubuntu-wsl build-essential rcm gpg dirmngr peco fish vim gh unzip wslu
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  echo $(tput setaf 4)OS is Linux.$(tput sgr0)
  sudo apt update
  # install build-essential
  sudo apt install -y build-essential rcm gpg dirmngr peco unzip jq
  # Fish
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt install fish
  sudo apt install vim
  # For gh
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
fi

# Tools installed via cargo
if ! [ -x "$(command -v rg)"]; then
  cargo install ripgrep
fi

curl -sS https://starship.rs/install.sh | sh

# deploy
# cd ${DOT_DIRECTORY}
# ./scripts/deploy.sh -none

# echo $(tput setaf 4)Setup nextdns.$(tput sgr0)
# sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'
# echo $(tput setaf 4)Setup nextdns end ✔$(tput sgr0)

# install mise
curl https://mise.run | sh

echo $(tput setaf 4)Login shell chainging.$(tput sgr0)
chsh -s $(which fish)
echo $(tput setaf 4)Login shell changed ✔︎$(tput sgr0)

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎ Please run post-init$(tput sgr0)
