#!/bin/bash

. "$HOME/.cache/wal/colors.sh"
a="ff"
b="80"

i3lock --blur=5 --clock --indicator --radius=150 --ring-width=5.0 \
    --timecolor=$foreground$a --timestr='%H時%M分' --time-font='Source Han Sans JP' \
    --datecolor=$foreground$a --datestr='%m月%d日' --date-font='Source Han Sans JP' \
    --insidecolor=$color0$b --insidevercolor=$color0$b --insidewrongcolor=$color0$b  \
    --ringcolor=$color6$a --ringvercolor=$color6$a --ringwrongcolor=$color3$a \
    --line-uses-inside --separatorcolor=$color6$a \
    --keyhlcolor=$color3$a --bshlcolor=$color3$a \
    --verifcolor=$foreground$a --verif-font='Source Han Sans JP' \
    --wrongcolor=$foreground$a --wrong-font='Source Han Sans JP' \
    --veriftext='認証中' --wrongtext='認証失敗' --noinputtext='入力なし' \
    --locktext='ロック中' --lockfailedtext='ロック失敗'

exit 0
