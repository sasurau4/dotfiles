# gcc
alias gcc 'gcc-9'
alias g++ 'g++-9'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# Shortcuts
alias dl 'cd ~/Downloads'
alias rf 'rm -rf'

# bundler shortcuts
alias bi 'bundle install --path vendor/bundle --jobs=(getconf _NPROCESSORS_ONLN)'
alias be 'bundle exec'

# homebrew shortcut
alias brewup 'brew update && brew upgrade && brew cask upgrade && brew cleanup && brew doctor && brew cask doctor'

# opam shortcut
alias opamup 'opam update --all --upgrade --jobs=(getconf _NPROCESSORS_ONLN) --yes'

# IP addresses
alias pubip4 'dig +short -4 myip.opendns.com @resolver1.opendns.com'
alias pubip6 'dig +short -6 myip.opendns.com aaaa @resolver1.ipv6-sandbox.opendns.com'
alias localip 'ifconfig | grep -Eo "inet (addr:)?([0-9]*\\.){3}[0-9]*" | grep -Eo "([0-9]*\\.){3}[0-9]*" | grep -v "127.0.0.1"'
alias ips 'ifconfig -a | grep -o "inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)" | awk "{ sub(/inet6? (addr:)? ?/, \"\"); print }"'

# Show active network interfaces
alias ifactive 'ifconfig | pcregrep -M -o "^[^\t:]+:([^\n]|\n\t)*status: active"'

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'

# Copy working directory
alias cwd 'pwd | tr -d "\r\n" | pbcopy'

# macOS has no `md5sum`, so use `md5` as a fallback
alias md5sum 'md5'

# youtube-dl
alias mp3dl 'youtube-dl -f mp3'
alias mp4dl 'youtube-dl -f mp4'

# git related
alias g 'git'
alias gco 'git checkout'
alias gst 'git status'
alias gcm 'git commit -m'
alias gaa 'git add .'
alias gsl 'git stash list'
alias gsp 'git stash pop'
alias gsc 'git stash clear'
alias gd 'git diff'
alias gdc 'git diff --cached'
alias gb 'git branch'
alias gpushh 'git push origin HEAD'
alias gpullm 'git pull origin master'
alias gpullh 'git pull origin HEAD'
alias gpullu 'git pull upstream master'
alias grau 'git remote add upstream'
alias ghp 'cd (ghq root)/(ghq list | peco)'
alias gcop "git branch -a | peco | xargs git checkout"
alias grsoa "git remote set-head origin --auto"
alias gcod "git switch (git symbolic-ref refs/remotes/origin/HEAD --short | sed 's/origin\///')"
alias gpod "git pull origin (git symbolic-ref refs/remotes/origin/HEAD --short | sed 's/origin\///')"
alias gpr "gh pr create --web"
alias grebasei 'git rebase -i (git log -n 1 upstream/master --pretty=format:"%H")'
alias clang 'clang++-18'
alias lld-link 'lld-link-18'
## Usage gfork sasurau4/profile
function gfork
  set -l ORIGINAL_TARGET $argv[1]
  echo ORIGINAL_TARGET is $ORIGINAL_TARGET
  set -l OWNER (string split / $ORIGINAL_TARGET)[1]
  set -l REPO_NAME (string split / $ORIGINAL_TARGET)[2]
  echo OWNER is $OWNER
  echo REPO_NAME is $REPO_NAME
  ghq get -p $ORIGINAL_TARGET
  mv (ghq root)/github.com/$ORIGINAL_TARGET/ (ghq root)/github.com/sasurau4/$REPO_NAME/
  cd (ghq root)/github.com/sasurau4/$REPO_NAME
  gh repo fork --remote=true --clone=false
end

# apt
alias sagu "sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean"

# emulate vim
alias :q "exit"
alias v "vim"

# Platform specific
switch (uname)
case Darwin
  # Google Chrome
  alias chrome '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

  # Kill all the tabs in Chrome to free up memory
  # [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
  alias chromekill 'ps ux | grep "[C]hrome Helper --type=renderer" | grep -v extension-process | tr -s " " | cut -d " " -f2 | xargs kill'

  # Lock the screen (when going AFK)
  alias afk '/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
case Linux
end

