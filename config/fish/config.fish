# Starship
starship init fish | source

# asdf version manager
source ~/.asdf/asdf.fish

# Yarn
set -x PATH ~/.yarn/bin $PATH

switch (uname)
case Darwin
  # # For Android
  set -x ANDROID_HOME $HOME/Library/Android/sdk
  set -x PATH ANDROID_HOME $PATH
  # # for vpnclient
  set -x PATH $HOME/vpnclient $PATH
  # # SDKROOT
  # # set -x SDKROOT (env DEVELOPER_DIR=/Library/Developer/CommandLineTools xcrun --sdk macosx --show-sdk-path)
case Linux
  # Linux for private
  set -x ANDROID_HOME $HOME/Android/Sdk
  set -x PATH ANDROID_HOME $PATH
end

set -x PATH $ANDROID_HOME/emulator $PATH
set -x PATH $ANDROID_HOME/tools $PATH
set -x PATH $ANDROID_HOME/tools/bin $PATH
set -x PATH $ANDROID_HOME/platform-tools $PATH
set -x PATH $ANDROID_HOME/ndk-bundle $PATH

# fisher
# if not functions -q fisher
#     set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/dotfiles/config
#     curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
#     fish -c fisher
# end
