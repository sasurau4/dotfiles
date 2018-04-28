#!/bin/sh

echo $(tput setaf 2)initialize dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

git submodule init
git submodule update --depth= 1
echo $(tput setaf 4)Cloning submodules done! ✔︎$(tput sgr0)



echo $(tput setaf 4)install nerd fonts.$(tput sgr0)
./.vim/icons/nerd-fonts/install.sh
echo $(tput setaf 4)nerd fonts installed! ✔︎$(tput sgr0)

echo $(tput setaf 2)initialize dotfiles complete!. ✔︎$(tput sgr0)
