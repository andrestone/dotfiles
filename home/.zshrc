export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# prompt
# Build the first line with all info
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'
# Add padding and timestamp at the end of first line
PROMPT+='%{$fg[white]%} • %{$fg[cyan]%}%D{%m/%f/%y}|%D{%L:%M:%S}%{$reset_color%}'
if [[ -n $SSH_CONNECTION ]]; then
PROMPT="%{$fg[white]%}%n@%{$fg[green]%}%m%{$reset_color%} ${PROMPT}"
fi
# Second line for input
PROMPT+=$'\n› '

# vim
alias vim=nvim

# vim edit cmdline
export EDITOR=nvim
export VISUAL=nvim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
set -o vi

# lots of history
HISTFILE=$HOME/.local/.history
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# random
function cdr {
  cd $(git rev-parse --show-toplevel)
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/andre/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="$HOME/.local/bin:$PATH"

# Load pyenv automatically by appending
# the following to
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Unlock Keychain on login
if [ -n "$SSH_CONNECTION" ] && [ -z "$KEYCHAIN_UNLOCKED" ]; then
 security unlock-keychain ~/Library/Keychains/login.keychain-db
 export KEYCHAIN_UNLOCKED=true
fi
export PATH=$PATH:$HOME/.maestro/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH=$PATH:$HOME/.maestro/bin

# Added by Antigravity
export PATH="/Users/andre/.antigravity/antigravity/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/andre/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias claude="claude --allow-dangerously-skip-permissions --permission-mode auto"

# bun completions
[ -s "/Users/andre/.bun/_bun" ] && source "/Users/andre/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# personal scripts
export PATH="$HOME/bin:$PATH"


# machine-local secrets and overrides, never committed
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
