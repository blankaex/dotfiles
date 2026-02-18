# Source dependencies
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  source "/etc/profile.d/autojump.sh"
  source <(fzf --zsh)
  source /etc/grc.zsh
fi

# Vi mode
bindkey -v
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Command editing
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Aliases (flags)
alias cp='cp -iv'
alias mv='mv -iv'
alias sudo='sudo -E'
alias diff='diff --color=auto'
alias xclip='xclip -selection clipboard'
alias ncmpcpp='ncmpcpp --config $HOME/.config/ncmpcpp/config --bindings $HOME/.config/ncmpcpp/bindings'

# Aliases (programs)
alias ls='eza'
alias lf='lf-ueberzug'
alias erogays='vboxmanage startvm erogays'
alias mozc-dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
