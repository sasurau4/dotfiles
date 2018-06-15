#!/bin/sh

echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# install neovim
echo $(tput setaf 4)Install neovim from pip3.$(tput sgr0)
pip3 install --upgrade neovim
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

# install LSPs
echo $(tput setaf 4)Install Langage Server Protocols.$(tput sgr0)
# global install is not good, but no alternative idea.
yarn global add javascript-typescript-langserver
echo $(tput setaf 4)Langage Server Protocols installed! ✔︎$(tput sgr0)

# deploy
cd ${DOT_DIRECTORY}
./deploy.sh

# run install script about vim plugins
echo $(tput setaf 4)Build vim plugins.$(tput sgr0)
cd ${DOT_DIRECTORY}/.vim/pack/mypackage/start/LanguageClient-neovim
bash install.sh
cd ${DOT_DIRECTORY}

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎$(tput sgr0)
