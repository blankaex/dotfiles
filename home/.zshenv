# Ensure that a non-login, non-interactive shell has a defined environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Pywal Colours
source "$HOME/.cache/wal/colors.sh"

# XDG Base Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Default programs
export BROWSER='firefox'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export MANPAGER='bat -plman'

# Region & Language
export TZ='Asia/Tokyo'
if [[ -z "$LANG" ]]; then
  export LANG='ja_JP.utf8'
  # export LANG='en_US.utf8'
fi
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Program options
export KEYTIMEOUT=1
export QT_QPA_PLATFORMTHEME=gtk2
export _JAVA_AWT_WM_NONREPARENTING=1

# Secret env vars
source $XDG_CONFIG_HOME/.secrets

# Path
typeset -gU cdpath fpath mailpath path
cdpath=(
  $cdpath
)
path=(
  $HOME/.local/bin
  $path
)
