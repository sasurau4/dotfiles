#!/bin/sh

set -eu

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

# see https://askubuntu.com/questions/1029128/inverted-horizontal-scrolling-ubuntu-18-04
xinput set-prop 10 332 -74, -74
