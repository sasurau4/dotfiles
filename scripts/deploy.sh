#!/bin/sh

set -eu
echo $(tput setaf 2)Deploy dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
CONFIG_DIR="${HOME}/.config"
cd ${DOT_DIRECTORY}
OPTION=${1:-no-update}

echo $(tput setaf 4)Update submodules start.$(tput sgr0)
git submodule init
git submodule update --recursive 
echo $(tput setaf 4)Update submodules done! ✔︎$(tput sgr0)

if [ "$OPTION" = "-u" -o "$OPTION" = "--update" ]
then
  echo $(tput setaf 4)Pull every submodules start.$(tput sgr0)
  git submodule update --remote --depth 1
  echo $(tput setaf 4)Pull every submodules done! ✔︎$(tput sgr0)
fi

echo $(tput setaf 4)Delete Untracked vim plugins.$(tput sgr0)
tput setaf 1 && git clean -diff .vim/pack/ && tput sgr0
# git clean command doesn't delete submodules without -f two times, so add ff option.
echo $(tput setaf 4)Delete Untracked vim plugins done! ✔︎$(tput sgr0)

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
