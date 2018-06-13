#!/bin/sh

echo $(tput setaf 2)Deploy dotfiles start!.$(tput sgr0)

DOT_DIRECTORY="${HOME}/dotfiles"
cd ${DOT_DIRECTORY}

echo $(tput setaf 4)Update submodules start.$(tput sgr0)
git submodule init
git submodule update --recursive
echo $(tput setaf 4)Update submodules done! ✔︎$(tput sgr0)

if [ "$1" = "-u" -o "$1" = "--update" ]
then
  echo $(tput setaf 4)Pull every submodules start.$(tput sgr0)
  git submodule foreach git pull origin master
  echo $(tput setaf 4)Pull every submodules done! ✔︎$(tput sgr0)
fi

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

echo $(tput setaf 4)Delete Untracked vim plugins.$(tput sgr0)
tput setaf 1 && git clean -diff .vim/pack/ && tput sgr0
# git clean command doesn't delete submodules without -f two times, so add ff option.
echo $(tput setaf 4)Delete Untracked vim plugins done! ✔︎$(tput sgr0)

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
