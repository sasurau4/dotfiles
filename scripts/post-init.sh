#!/usr/bin/env fish

set -eu
echo (tput setaf 2)initialize dotfiles start!.(tput sgr0)

set DOT_DIRECTORY "$HOME/dotfiles"
cd $DOT_DIRECTORY

echo (tput setaf 4)Setup fisher and fish plugins.(tput sgr0)
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install decors/fish-ghq
fisher install oh-my-fish/plugin-peco
echo (tput setaf 4)Setup fisher and fish plugins end ✔(tput sgr0)

# install asdf
echo (tput setaf 4)Install tools and plugins.(tput sgr0)

mise install nodejs ghq direnv

echo (tput setaf 4)Install asdf and plugins completed! ✔︎(tput sgr0)

echo (tput setaf 2)post initialize dotfiles complete!. ✔︎(tput sgr0)
