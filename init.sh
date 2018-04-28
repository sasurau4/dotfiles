#!/bin/sh

echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

echo $(tput setaf 4)install nerd fonts.$(tput sgr0)
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ${HOME}/nerd-fonts
${HOME}/nerd-fonts/install.sh
echo $(tput setaf 4)nerd fonts installed! ✔︎$(tput sgr0)

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎$(tput sgr0)
