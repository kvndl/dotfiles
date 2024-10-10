
# ░▀█▀░▄▀▀░█▄█▒█▀▄░▄▀▀
# ░█▄▄▒▄██▒█▒█░█▀▄░▀▄▄

path_append() {
  updated=false
  for dir in "$@"; do
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
      PATH="$PATH:$dir"
      updated=true
    fi
  done
  $updated && export PATH
}

path_append \
  "$HOME/.local/bin" "/usr/local/bin" "$HOME/bin" \
  "$HOME/go/bin" "$HOME/.go/bin" "$HOME/.tfenv/bin" \
  "$HOME/.pulumi/bin" "$HOME/.cargo/bin" "$HOME/dotnet"

# Specific configurations
[[ -d "$HOME/.go" ]] && path_append "$HOME/.go/bin"
[[ -d "$HOME/.nvm" && -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
[[ -d "$HOME/.local/share/pnpm" ]] && path_append "$HOME/.local/share/pnpm"

# Other configs and exports
export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export DOTNET_ROOT="$HOME/dotnet"
export GPG_TTY=$TTY
export TENV_AUTO_INSTALL=true

# Load (secret) environment variables
if [ -f "$HOME/.env.secrets" ]; then
    source "$HOME/.env.secrets"
fi

# Plugins
plugins=(git)

# Zsh config
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_UPDATE_PROMPT="true"
export ZSH_THEME="ys"
source "$ZSH/oh-my-zsh.sh"

# Aliases
alias c='clear'
alias ..='cd ../'
alias ...='cd ../../'
alias tfp='terraform init && terraform plan'

# Go config
if [[ -d "$HOME/.go" ]]; then
  export GOPATH="$HOME/.go"
  export GOBIN="$HOME/.go/bin"
fi

# PNPM config
if [[ -d "$HOME/.local/share/pnpm" ]]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
