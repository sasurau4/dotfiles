#!/bin/sh

echo $(tput setaf 2)Deploy dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

echo $(tput setaf 4)Cloning submodules start.$(tput sgr0)
git submodule update --recursive
git submodule foreach git pull origin master
echo $(tput setaf 4)Cloning submodules done! ✔︎$(tput sgr0)

echo $(tput setaf 4)Create or update symlinnks for dotfiles$(tput sgr0)
for f in .??*
do
  # 無視したいファイルやディレクトリはこんな風に追加してね
  [ ${f} = ".git" ] && continue
  [ ${f} = ".gitignore" ] && continue
  [ ${f} = ".gitmodules" ] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
echo $(tput setaf 4)Create or update symlinnks for dotfiles done! ✔︎$(tput sgr0)

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
