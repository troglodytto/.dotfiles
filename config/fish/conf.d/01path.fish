# Paths, and environment for tools that need registering.

fish_add_path -aU $HOME/.local/bin
fish_add_path -aU $HOME/go/bin
fish_add_path -aU /usr/local/go/bin

# Rust compilation cache. sccache 0.17.0
set -gx RUSTC_WRAPPER $HOME/.cargo/bin/sccache

# fzf 0.74 file list
set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,target/*}"'

set -gx EDITOR zed
