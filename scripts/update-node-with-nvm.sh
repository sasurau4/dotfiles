#!/bin/sh

set -eu

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# you run before nvm ls-remote and check latest verion.
# null check
$1:?
nvm install $1

npm i -g yarn
yarn global add javascript-typescript-langserver
