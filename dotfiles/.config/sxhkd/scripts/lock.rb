#!/usr/bin/env ruby

require 'json'

file = File.read("#{ENV["HOME"]}/.cache/wal/colors.json")
json = JSON.parse(file)
colors = json["special"].merge(json["colors"])
alpha1 = colors.inject({}) {|h, (k, v)| h[k] = v + "ff"; h}
alpha2 = colors.inject({}) {|h, (k, v)| h[k] = v + "80"; h}

exec "i3lock --blur=5 --clock --indicator --radius=150 --ring-width=5.0 \
    --time-color=#{alpha1["foreground"]} --time-str='%H時%M分' --time-font='Source Han Sans JP' \
    --date-color=#{alpha1["foreground"]} --date-str='%m月%d日' --date-font='Source Han Sans JP' \
    --inside-color=#{alpha2["color0"]} --insidever-color=#{alpha2["color0"]} --insidewrong-color=#{alpha2["color0"]} \
    --ring-color=#{alpha1["color6"]} --ringver-color=#{alpha1["color6"]} --ringwrong-color=#{alpha1["color3"]} \
    --line-uses-inside --separator-color=#{alpha1["color6"]} \
    --keyhl-color=#{alpha1["color3"]} --bshl-color=#{alpha1["color3"]} \
    --verif-color=#{alpha1["foreground"]} --verif-font='Source Han Sans JP' \
    --wrong-color=#{alpha1["foreground"]} --wrong-font='Source Han Sans JP' \
    --verif-text='認証中' --wrong-text='認証失敗' --noinput-text='入力なし' \
    --lock-text='ロック中' --lockfailed-text='ロック失敗'"
