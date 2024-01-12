export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh

plugins=(
  # vi-mode
  aliases
  brew
	git
  macos
  safe-paste
  tmux
  web-search
	zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vim-mode
)
MODE_CURSOR_VIINS="#f4dbd6 blinking bar"
MODE_CURSOR_REPLACE="#f4dbd6 blinking underline"
MODE_CURSOR_VICMD="#f4dbb6 steady block"
MODE_CURSOR_SEARCH="#f4dbd6 steady underline"
MODE_CURSOR_VISUAL="#f4dbb6 steady block"
MODE_CURSOR_VLINE="#f4dbd6 steady block"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=nvim

# Line for custom utils
export PATH="/Users/daniele/Developer/utils:$PATH"

# fzf options
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--border --reverse --height 80% --preview 'bat {}'"
export FZF_DEFAULT_COMMAND="fd --type f"
bindkey "©" fzf-cd-widget
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

alias vim="nvim"
alias gcc="/opt/homebrew/bin/gcc-13"
alias m="make"
alias mr="make run"
alias mc="make clean"
alias bmr="make clean && bear -- make all"
alias vi="vim"
alias ls="lsd"
alias lsa="ls -a"
alias lst="ls --tree"
alias btop="bpytop"
alias rng="ranger"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/usr/local/mysql/bin/:$PATH"
