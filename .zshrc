# set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit, if it's not there yet
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load pure prompt
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure
# prompt styling
zstyle ':prompt:pure:git:stash' show yes

# add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::docker-compose

# load completions
autoload -U compinit && compinit

zinit cdreplay -q

# keybindings
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey "©" fzf-cd-widget

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab: complete:cd:*' ff-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# vim mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
ZVM_VI_HIGHLIGHT_FOREGROUND=#adacac
ZVM_VI_HIGHLIGHT_BACKGROUND=#333333

# aliases
function take {
  mkdir -p $1
  cd $1
}
alias rm="trash"
alias vim="nvim"
alias ls="eza --icons=auto --color=auto"
alias lsa="ls -a"
alias lsl="ls -l" 
alias lst="ls --tree"
alias t="todopher"
alias y="yazi"
alias k="clear"

# exports
export EDITOR=nvim
export TERM=xterm-256color
export PATH="$HOME/Developer/utils:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:"$HOME/fvm/default/bin"

# fzf styling
export FZF_DEFAULT_OPTS="--multi"

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd j zsh)"
eval "$(direnv hook zsh)"

## [Completion]
[[ -f /Users/daniele/.dart-cli-completion/zsh-config.zsh ]] && . /Users/daniele/.dart-cli-completion/zsh-config.zsh || true

## [Completion]
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
