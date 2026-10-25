# Keep the first occurrence of each command and completion directory.
typeset -U path fpath

# Initialize Homebrew before loading plugins.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Stop initialization if bootstrap fails, rather than calling a missing zinit.
if [[ ! -d "$ZINIT_HOME/.git" ]]; then
  mkdir -p "${ZINIT_HOME:h}" &&
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" || return 1
fi
source "${ZINIT_HOME}/zinit.zsh" || return 1

# Load pure prompt
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure
# prompt styling
zstyle ':prompt:pure:git:stash' show yes

# add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::docker-compose

# load completions
fpath+=("$HOME/.zfunc")
autoload -Uz compinit
compinit
zinit cdreplay -q
zinit light Aloxaf/fzf-tab

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always -- "$realpath"'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always -- "$realpath"'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# vim mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
ZVM_VI_HIGHLIGHT_FOREGROUND=#c5c9c7
ZVM_VI_HIGHLIGHT_BACKGROUND=#3E424A

# aliases
alias rm="trash"
alias vim="nvim"
alias ls="eza --icons=auto --color=auto"
alias la="ls -a"
alias ll="ls -l" 
alias lt="ls --tree"
alias t="todopher"
alias y="yazi"
alias k="clear"

# exports
export EDITOR=nvim

path=(
  "$HOME/go/bin"
  "$HOME/.antigravity/antigravity/bin"
  $path
)

# fzf styling
export FZF_DEFAULT_OPTS="--multi"

# shell integrations
# Vi mode initializes lazily and would overwrite earlier fzf bindings.
zvm_after_init() {
  eval "$(fzf --zsh)"
  bindkey -M viins "©" fzf-cd-widget
  bindkey -M viins "^r" fzf-history-widget
}
eval "$(zoxide init --cmd j zsh)"
eval "$(direnv hook zsh)"

# Activate Node.js versions with fnm and switch on directory changes.
eval "$(fnm env --use-on-cd --shell zsh)"

# Load after plugins and integrations that wrap line-editor widgets.
zinit light zsh-users/zsh-syntax-highlighting
