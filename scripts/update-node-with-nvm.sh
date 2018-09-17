#!/bin/sh

set -eu

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

npm i -g yarn
yarn global add javascript-typescript-langserver
