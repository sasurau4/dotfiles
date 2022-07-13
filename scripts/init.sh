#!/bin/bash

set -eu
echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# install neovim
# echo $(tput setaf 4)Install python related packages from pip3.$(tput sgr0)
# pip3 install --upgrade --user msgpack
# echo $(tput setaf 4)python packages installed! ✔︎$(tput sgr0)


# install nerd fonts
if [ -e ${HOME}/nerd-fonts ]; then
  echo $(tput setaf 4)Already exists nerd-fonts dir, skip install.$(tput sgr0)
else
  echo $(tput setaf 4)Install nerd fonts.$(tput sgr0)
  git clone --depth 1 -- https://github.com/ryanoasis/nerd-fonts.git ${HOME}/nerd-fonts
  ${HOME}/nerd-fonts/install.sh
  echo $(tput setaf 4)nerd fonts installed! ✔︎$(tput sgr0)
fi

# install Rust
echo $(tput setaf 4)Install Rust.$(tput sgr0)
curl https://sh.rustup.rs -sSf | sh
echo $(tput setaf 4)Install Rust completed! ✔︎$(tput sgr0)
source $HOME/.cargo/env

echo $(tput setaf 4)Install daily development toolchains depend on platform.$(tput sgr0)
if [ "$(uname)" = "Darwin" ]; then
  echo $(tput setaf 4)OS is Mac OSX.$(tput sgr0)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install gh
  brew install peco
  # For asdf-nodejs
  brew install gpg
  brew install coreutils
  # rcm
  brew tap thoughtbot/formulae
  brew install rcm
  # fish
  brew install fish
  brew install neovim

  # For shell change
  echo "$(which fish)" | sudo tee -a /etc/shells

elif [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
  echo $(tput setaf 4)OS is WSL2.$(tput sgr0)
  sudo apt install ubuntu-wsl
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  echo $(tput setaf 4)OS is Linux.$(tput sgr0)
  sudo apt update
  # install build-essential
  sudo apt install build-essential
  # for rcm
  sudo apt install rcm
  # For asdf-nodejs
  sudo apt-get install gpg
  sudo apt-get install dirmngr
  # For daily util
  sudo apt install peco
  sudo apt install fish
  sudo apt install vim
  # For gh
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update
  sudo apt install gh
  # For docker
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt get update
  sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

# Tools installed via cargo
if ! [ -x "$(command -v rg)"]; then
  cargo install ripgrep
fi

cargo install starship --locked

# deploy
cd ${DOT_DIRECTORY}
./scripts/deploy.sh -none

echo $(tput setaf 4)Setup nextdns.$(tput sgr0)
sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'
echo $(tput setaf 4)Setup nextdns end ✔$(tput sgr0)

# install asdf
if [ -e ${HOME}/.asdf ]; then
  echo $(tput setaf 4)Already exists .asdf dir, skip install.$(tput sgr0)
else
  echo $(tput setaf 4)Install asdf .$(tput sgr0)
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
  echo $(tput setaf 4)Install asdf completed! ✔︎$(tput sgr0)
fi

echo $(tput setaf 4)Login shell chainging.$(tput sgr0)
chsh -s $(which fish)
echo $(tput setaf 4)Login shell changed ✔︎$(tput sgr0)

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎ Please run post-init$(tput sgr0)
