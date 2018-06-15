#!/bin/sh

# install vim plugin as submodule
DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}/.vim/pack/mypackage/start/
git submodule add $1
cd ${DOT_DIRECTORY}
