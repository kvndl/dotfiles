PATH="$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/go/bin"
PATH="$PATH:$HOME/go/bin:$HOME/.config/hypr/bin:$HOME/.tfenv/bin"
PATH="$PATH:$HOME/.pulumi/bin:$HOME/.cargo/bin:$GOPATH/bin:$HOME/.cargo/env"
PATH="$PATH:$HOME/.go/bin"
export PATH

plugins=(git)

. "$HOME/.cargo/env"

export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export EDITOR="nano"
export GPG_TTY=$TTY
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export TENV_AUTO_INSTALL=true

# zsh
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_UPDATE_PROMPT="true"
export ZSH_THEME="ys"
source $ZSH/oh-my-zsh.sh
# zsh end

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if [ -f "$HOME/.local/share/dnvm/env" ]; then
    . "$HOME/.local/share/dnvm/env"
fi
# nvm end

# pnpm
export PNPM_HOME="/home/knoodle/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# aliases
alias c='clear'
alias ..='cd ../'
alias tfp='terraform init && terraform plan'
# aliases end
