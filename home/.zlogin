#
# Executes commands at login post-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

  QUOTES=(
    "Peaceful days are over. Let's survive.\n  --女神異聞録デビルサバイバー"
    "何でもは知らないわよ。知ってることだけ。\n  --羽川翼"
    "その幻想をぶち殺す！\n  --上条当麻"
    "未来を買い戻す\n  --余賀公麿"
    "今後も救世主たらんことを。\n  --JUIZ"
    "メギドラオンでございます。\n --エリザベス"
    "そう。私に読めないのは空気だけ。\n --戦場ヶ原ひたぎ"
    "あなたが考えているほど、世界は悪くないから。\n --セルティ・ストゥルルソン"
    "いっぺん、死んでみる？\n --閻魔あい"
    "か弱いワタシに加減を頼むよ？\n --真紅の抗戦者・モノ"
    "なるほどSUNDAYじゃねーの\n --跡部景吾"
    "俺様の美技に酔いな！\n --跡部景吾"
    "倍プッシュだ。\n --赤木しげる"
    "禁則事項です。\n --朝比奈みくる"
    "万物にはすべて綻びがある。\n --両儀式"
    "生きているのなら、神様だって殺してみせる。\n --両儀式"
  )
  
  # Print a randomly-chosen message:
  echo $QUOTES[$(($RANDOM % ${#QUOTES} + 1))]

} >&2
