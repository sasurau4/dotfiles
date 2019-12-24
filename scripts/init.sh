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
cargo install ripgrep

# deploy
cd ${DOT_DIRECTORY}
./scripts/deploy.sh -none

echo $(tput setaf 4)Install daily development toolchains depend on platform.$(tput sgr0)
if [ "$(uname)" = "Darwin" ]; then
  echo $(tput setaf 4)OS is Mac OSX.$(tput sgr0)
  brew install hub
  brew install peco
  brew install ghq
  // For asdf-nodejs
  brew install gpg
  brew install coreutils
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  echo $(tput setaf 4)OS is Linux.$(tput sgr0)
  // For asdf-nodejs
  apt-get install gpg
  apt-get install dirmngr
  sudo apt install hub
  sudo apt install peco
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

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎$(tput sgr0)
