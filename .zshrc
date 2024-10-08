# Function to append to PATH only if the directory is not already present
path_append() {
  for dir in "$@"; do
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
      export PATH="$PATH:$dir"
    fi
  done
}

# Set GOPATH and related variables
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export DOTNET_ROOT="$HOME/dotnet"

# Append directories to PATH using the path_append function
path_append \
  "$HOME/.local/bin" \
  "/usr/local/bin" \
  "$HOME/bin" \
  "$HOME/go/bin" \
  "$GOPATH/bin" \
  "$HOME/.go/bin" \
  "/usr/local/go/bin" \
  "$HOME/.pulumi/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/.cargo/env" \
  "$HOME/dotnet" \
  "$HOME/.tfenv/bin"

# Export PATH
export PATH

# Plugins
plugins=(git)

# Locale and Editor Settings
export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export EDITOR="nano"

# GPG and Environment Settings
export GPG_TTY=$TTY
export TENV_AUTO_INSTALL=true

# Aliases
alias c='clear'
alias ..='cd ../'
alias tfp='terraform init && terraform plan'

# oh-my-zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_UPDATE_PROMPT="true"
export ZSH_THEME="ys"
source "$ZSH/oh-my-zsh.sh"

# nvm Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# pnpm Configuration
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
