#!/usr/bin/env ruby

source = `pactl get-default-source`.strip
system "pactl set-source-mute #{source} toggle"
notification = `pactl get-source-mute #{source}`.strip == 
  "Mute: yes" ? "マイク：ミュート" : "マイク：ミュート解除"
exec "dunstify -r 103 #{notification}"
