export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"


plugins=(
  vi-mode
  aliases
  brew
	git
  macos
  safe-paste
  tmux
  web-search
  zsh-syntax-highlighting
	zsh-autosuggestions
)


KEYTIMEOUT=1

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=nvim

# export TERM=screen-256color

export VI_MODE_SET_CURSOR=true

# Line for custom utils
export PATH="$HOME/Developer/utils:$PATH"

# direnv 
eval "$(direnv hook zsh)"

# fzf options
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--border --reverse --height 80% --preview 'bat {}'"
export FZF_DEFAULT_COMMAND="fd --type f"
bindkey "©" fzf-cd-widget
bindkey "^F" fzf-file-widget
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

function take {
  mkdir -p $1
  cd $1
}
alias rm="trash"
alias vim="nvim"
alias gcc="/opt/homebrew/bin/gcc-14"
alias m="make"
alias mr="make run"
alias mc="make clean"
alias bmr="make clean && bear -- make all"
alias ls="lsd"
alias lsa="ls -a"
alias lst="ls --tree"
alias btop="bpytop"
alias y="yazi"

# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/usr/local/mysql/bin/:$PATH"
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/23/libexec/openjdk.jdk/Contents/Home"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
# export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
# export DYLD_LIBRARY_PATH="/usr/local/Cellar/openssl@1.1/1.1.1g/lib:$DYLD_LIBRARY_PATH"
# export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig/"
# source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

eval "$(zoxide init --cmd cd zsh)"

eval $(thefuck --alias)

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zencat.toml)"

