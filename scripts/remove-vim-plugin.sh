#!/bin/sh

set -eu
DOT_DIRECTORY="${HOME}/dotfiles"
VIM_PLUGIN_DIRECTORY="${DOT_DIRECTORY}/.vim/pack/mypackage/start/$1"
GIT_MODULE_DIRECTORY="${DOT_DIRECTORY}/.git/modules/.vim/pack/mypackage/start/$1"
git submodule deinit $VIM_PLUGIN_DIRECTORY
git rm $VIM_PLUGIN_DIRECTORY
rm -rf $GIT_MODULE_DIRECTORY
