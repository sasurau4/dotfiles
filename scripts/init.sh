#!/bin/sh

set -eu
echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# install neovim
echo $(tput setaf 4)Install neovim from pip3.$(tput sgr0)
pip3 install --upgrade neovim
pip3 install --upgrade pynvim
echo $(tput setaf 4)neovim installed! ✔︎$(tput sgr0)

# install starship
curl -fsSL https://starship.rs/install.sh | bash

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

# install LSPs
echo $(tput setaf 4)Install Langage Server Protocols.$(tput sgr0)
# global install is not good, but no alternative idea.
yarn global add typescript-language-server
echo $(tput setaf 4)Langage Server Protocols installed! ✔︎$(tput sgr0)

# Tools installed via cargo
if ! [ -x "$(command -v rg)"]; then
  cargo install ripgrep
fi

# deploy
cd ${DOT_DIRECTORY}
./scripts/deploy.sh -none

echo $(tput setaf 4)Install daily development toolchains depend on platform.$(tput sgr0)
if [ "$(uname)" = "Darwin" ]; then
  echo $(tput setaf 4)OS is Mac OSX.$(tput sgr0)
  brew install hub
  brew install peco
  brew install ghq
  # For asdf-nodejs
  brew install gpg
  brew install coreutils
  # rcm
  brew tap thoughtbot/formulae
  brew install rcm
  # fish
  brew install fish
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  echo $(tput setaf 4)OS is Linux.$(tput sgr0)
  # for rcm
  sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
  sudo apt-get update
  sudo apt-get install rcm
  # For asdf-nodejs
  sudo apt-get install gpg
  sudo apt-get install dirmngr
  # For daily util
  sudo apt install hub
  sudo apt install peco
  sudo apt install fish
  GO111MODULE=on go get github.com/motemen/ghq
fi

# install asdf
if [ -e ${HOME}/.asdf ]; then
  echo $(tput setaf 4)Install asdf and plugins.$(tput sgr0)
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.5
  sudo apt install \
    automake autoconf libreadline-dev \
    libncurses-dev libssl-dev libyaml-dev \
    libxslt-dev libffi-dev libtool unixodbc-dev \
    unzip curl

  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
  asdf plugin-add yarn
  echo $(tput setaf 4)Install asdf and plugins completed! ✔︎$(tput sgr0)
fi

echo $(tput setaf 4)Login shell chainging.$(tput sgr0)
chsh -s /usr/bin/fish
echo $(tput setaf 4)Login shell changed ✔︎$(tput sgr0)

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎$(tput sgr0)
