#!/usr/bin/env ruby

source = `pactl get-default-source`.strip
system "pactl set-source-mute #{source} toggle"
muted = `pactl get-source-mute #{source}`.strip == "Mute: yes" ? true : false

if muted
    exec "dunstify -r 103 マイク：ミュート"
else
    exec "dunstify -r 103 マイク：ミュート解除"
end
