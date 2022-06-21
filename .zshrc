export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="half-life"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
setopt auto_cd
eval "$(starship init zsh)"
source "$HOME/.cargo/env"
#source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
#source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[ -s "$HOME/.aliasrc"  ] && source "$HOME/.aliasrc"
[ -s "$HOME/.pathrc"  ] && source "$HOME/.pathrc"
[ -s "$HOME/.secret.aliasrc" ] && source "$HOME/.secret.aliasrc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


#[ -f "/home/voldemort/.ghcup/env" ] && source "/home/voldemort/.ghcup/env" # ghcup-env

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/home/ryuk/.ghcup/env" ] && source "/home/ryuk/.ghcup/env" # ghcup-env


# Load Angular CLI autocompletion.
source <(ng completion script)
fpath+="$HOME/.zsh_functions"
