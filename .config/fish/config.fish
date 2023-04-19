if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
bass source $HOME/.cargo/env

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/voldemort/.ghcup/bin # ghcup-env