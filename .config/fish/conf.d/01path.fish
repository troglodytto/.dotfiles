set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx JAVA_HOME $HOME/.sdkman/candidates/java/current/
set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,target/*}"'
set -gx PYTHONPATH /usr/bin/python3
set -gx RUSTC_WRAPPER /home/voldemort/.cargo/bin/sccache
set -gx PYENV_ROOT /home/voldemort/.pyenv
set -gx EDITOR code
# set -gx OPENSSL_DIR /usr/lib/ssl
# set -gx PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig/
set -gx OPENSSL_LIB_DIR /usr/lib/x86_64-linux-gnu
set -gx OPENSSL_INCLUDE /usr/include/openssl

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
fish_add_path -aU $PYENV_ROOT/bin
fish_add_path -aU /opt/flutter/bin
fish_add_path -aU /usr/local/go/bin/
fish_add_path -aU (pyenv root)/shims

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.fish.inc' ]
    . '/opt/google-cloud-sdk/path.fish.inc'
end
