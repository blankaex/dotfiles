# Source dependencies
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  source "/etc/profile.d/autojump.sh"
  source "/etc/grc.zsh"
  source "/usr/share/skim/key-bindings.zsh"
  source <(sk --shell zsh)
  eval "$(zoxide init zsh)"
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
alias aichat='aichat -r default -s'

# Aliases (programs)
alias j='z'
alias ji='zi'
alias ls='eza'
alias lf='/home/blankaex/.config/lf/lf-ueberzug'
alias find='fd'
alias erogays='vboxmanage startvm erogays'
alias mozc-dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'

# Zoxide skim integration
function __zoxide_zi() {
    \builtin local result
    result="$( \
        zoxide query -ls -- "$@" \
        | sk \
            --delimiter='[^\t\n ][\t\n ]+' \
            -n2.. \
            --no-sort \
            --keep-right \
            --height='40%' \
            --layout='reverse' \
            --exit-0 \
            --select-1 \
            --bind='ctrl-z:ignore' \
            --preview='\command -p ls -F --color=always {2..}' \
        ;
    )" \
        && __zoxide_cd "${result:7}"
}
