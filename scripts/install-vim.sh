#!/bin/sh

set -eu

<< COMMENTOUT
pre-requirements are on https://vim-jp.org/docs/build_linux.html
COMMENTOUT

echo $(tput setaf 2)install vim from source-build start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
VIM_DIRECTORY="${HOME}/vim"


if [ -e ${VIM_DIRECTORY} ]; then
  echo $(tput setaf 4)Already exists vim dir, pull updated repository.$(tput sgr0)
  cd ${VIM_DIRECTORY}
  git fetch origin master --update-shallow
  git reset --hard origin/master
else
  echo $(tput setaf 4)Clone vim repository $(tput sgr0)
  git clone --depth 1 -- https://github.com/vim/vim.git ${VIM_DIRECTORY}
  echo $(tput setaf 4)Vim repository cloned! ✔︎$(tput sgr0)
fi

echo $(tput setaf 4)Configure build.$(tput sgr0)
cd ${VIM_DIRECTORY}/src
make distclean

./configure \
  --with-features=huge \
  --enable-gui=gtk3 \
  --enable-python3interp \
  --enable-multibyte \
  --enable-fail-if-missing

echo $(tput setaf 4)Build start!$(tput sgr0)
sudo make install
echo $(tput setaf 4)Vim installed from its source 🎉$(tput sgr0)

cd ${DOT_DIRECTORY}
