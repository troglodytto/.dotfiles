export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
setopt auto_cd

eval "$(starship init zsh)"
alias vim="nvim"
alias ls="exa -l --icons -a"
alias cat="bat"
alias tree="exa --tree --icons --level=4"
alias grep="rg"
alias cpoy="xclip -selection c"
alias pasta="xclip -selection c -o"
