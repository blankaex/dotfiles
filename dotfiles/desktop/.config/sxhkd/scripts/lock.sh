#!/bin/bash

. "$HOME/.cache/wal/colors.sh"
a="ff"
b="80"

i3lock --blur=5 --clock --indicator --radius=150 --ring-width=5.0 \
    --time-color=$foreground$a --time-str='%H時%M分' --time-font='Source Han Sans JP' \
    --date-color=$foreground$a --date-str='%m月%d日' --date-font='Source Han Sans JP' \
    --inside-color=$color0$b --insidever-color=$color0$b --insidewrong-color=$color0$b  \
    --ring-color=$color6$a --ringver-color=$color6$a --ringwrong-color=$color3$a \
    --line-uses-inside --separator-color=$color6$a \
    --keyhl-color=$color3$a --bshl-color=$color3$a \
    --verif-color=$foreground$a --verif-font='Source Han Sans JP' \
    --wrong-color=$foreground$a --wrong-font='Source Han Sans JP' \
    --verif-text='認証中' --wrong-text='認証失敗' --noinput-text='入力なし' \
    --lock-text='ロック中' --lockfailed-text='ロック失敗'

exit 0
