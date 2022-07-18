export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
setopt auto_cd

eval "$(starship init zsh)"
alias vim=nvim
