# set HOME "/home/(whoami)"

set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx JAVA_HOME $HOME/.sdkman/candidates/java/current/
set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,target/*}"'
set -gx PYTHONPATH /usr/bin/python3

fish_add_path -aU $HOME/Android/Sdk/platform-tools
fish_add_path -aU $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path -aU $ANDROID_HOME/emulator
fish_add_path -aU $HOME/shadow/
fish_add_path -aU $HOME/.local/bin
fish_add_path -aU $HOME/.yarn/bin
fish_add_path -aU /bin
fish_add_path -aU /usr/bin
fish_add_path -aU /usr/local/bin
fish_add_path -aU $HOME/.cabal/bin
fish_add_path -aU $HOME/.ghcup/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.fish.inc' ]; . '/opt/google-cloud-sdk/path.fish.inc'; end
