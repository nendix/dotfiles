# set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit, if it's not there yet
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::vi-mode
zinit snippet OMZP::docker-compose

# load completions
autoload -U compinit && compinit

zinit cdreplay -q

# keybindings
bindkey -v
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

# vim mode styling
KEYTIMEOUT=1
export VI_MODE_SET_CURSOR=true

# aliases
function take {
  mkdir -p $1
  cd $1
}
alias vim="nvim"
alias ls="ls --color=always"
alias lsa="ls -a"
alias lsl="ls -l" 
alias y="yazi"
alias k="clear"

# exports
export EDITOR=nvim
export TERM=xterm-256color
export PATH=$PATH:"/snap/bin/"

# fzf styling
export FZF_DEFAULT_OPTS="--multi"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
--color=fg:#adacac,bg:#161616,hl:#8a879c,gutter:#161616
--color=fg+:#9c797d,bg+:#1b1c1d,hl+:#8a879c
--color=info:#696969,prompt:#8a879c,pointer:#9c797d
--color=marker:#a18b7f,spinner:#a18b7f,header:#a18b7f"
