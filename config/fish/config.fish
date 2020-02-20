# Starship
starship init fish | source

# asdf version manager
source ~/.asdf/asdf.fish

# Yarn
set -gx PATH ~/.yarn/bin $PATH

switch (uname)
case Darwin
  # For Android
  set -gx ANDROID_HOME $HOME/Library/Android/sdk $PATH
  # for vpnclient
  set -gx PATH $HOME/vpnclient $PATH
  # SDKROOT
  set -gx SDKROOT (env DEVELOPER_DIR=/Library/Developer/CommandLineTools xcrun --sdk macosx --show-sdk-path)
  # Brew
  set -gx PATH /usr/local/sbin $PATH
case Linux
  # Linux for private
  set -gx ANDROID_HOME $HOME/Android/Sdk
end

set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/ndk-bundle $PATH

# fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/dotfiles/config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
