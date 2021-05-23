#!/bin/sh

set -eu
echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# install neovim
echo $(tput setaf 4)Install python related packages from pip3.$(tput sgr0)
pip3 install --upgrade --user msgpack
echo $(tput setaf 4)python packages installed! ✔︎$(tput sgr0)

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

elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  echo $(tput setaf 4)OS is Linux.$(tput sgr0)
  # for rcm
  sudo wget -q https://apt.thoughtbot.com/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
  echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
  sudo apt-get update
  sudo apt-get install rcm
  # For asdf-nodejs
  sudo apt-get install gpg
  sudo apt-get install dirmngr
  # For daily util
  sudo apt install peco
  sudo apt install fish
  sudo apt install neovim
  # For gh
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update
  sudo apt install gh
fi

echo $(tput setaf 4)Setup fisher and fish plugins.$(tput sgr0)
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install decors/fish-ghq
fisher install oh-my-fish/plugin-peco
echo $(tput setaf 4)Setup fisher and fish plugins end ✔$(tput sgr0)

echo $(tput setaf 4)Setup nextdns.$(tput sgr0)
sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'
echo $(tput setaf 4)Setup nextdns end ✔$(tput sgr0)

echo $(tput setaf 4)Login shell chainging.$(tput sgr0)
chsh -s $(which fish)
echo $(tput setaf 4)Login shell changed ✔︎$(tput sgr0)

# install asdf
if [ -e ${HOME}/.asdf ]; then
  echo $(tput setaf 4)Already exists .asdf dir, skip install.$(tput sgr0)
else
  echo $(tput setaf 4)Install asdf and plugins.$(tput sgr0)
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
  . $HOME/.asdf/asdf.sh

  asdf plugin add nodejs
  asdf install nodejs latest
  asdf global nodejs $(asdf latest nodejs)

  asdf plugin add yarn
  asdf install yarn latest
  asdf global yarn $(asdf latest yarn)

  asdf plugin add ghq
  asdf install ghq latest
  asdf global ghq $(asdf latest ghq)

  asdf plugin add direnv
  asdf install direnv latest
  asdf global direnv $(asdf latest direnv)
  direnv allow
  echo $(tput setaf 4)Install asdf and plugins completed! ✔︎$(tput sgr0)
fi

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎$(tput sgr0)
