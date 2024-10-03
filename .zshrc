PATH="$PATH:$HOME/.local/bin:/usr/local/bin:$HOME/bin"
PATH="$PATH:$HOME/go/bin:$GOPATH/bin:$HOME/.go/bin:/usr/local/go/bin"
PATH="$PATH:$HOME/.pulumi/bin:$HOME/.cargo/bin::$HOME/.cargo/env"
PATH="$PATH:$HOME/.config/hypr/bin:$HOME/.tfenv/bin"
export PATH

plugins=(git)

export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export EDITOR="nano"
export GPG_TTY=$TTY
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export TENV_AUTO_INSTALL=true

# aliases
alias c='clear'
alias ..='cd ../'
alias tfp='terraform init && terraform plan'
# aliases end

# zsh
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_UPDATE_PROMPT="true"
export ZSH_THEME="ys"
source $ZSH/oh-my-zsh.sh
# zsh end

# (d)nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if [ -f "$HOME/.local/share/dnvm/env" ]; then
    . "$HOME/.local/share/dnvm/env"
fi
# (d)nvm end

# pnpm
export PNPM_HOME="/home/knoodle/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
