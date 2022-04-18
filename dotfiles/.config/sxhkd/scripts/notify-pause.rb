#!/usr/bin/env ruby

options = [
    30,
    60,
    "Unpause"
]

selection = `printf "#{options.join("\\n")}" | rofi -dmenu -i -m primary -p "Pause"`.strip()

if selection.to_i > 0
    system "dunstctl set-paused true"
    sleep(selection.to_i * 60)
    exec "dunstctl set-paused false"
elsif selection == "Unpause"
    exec "dunstctl set-paused false"
end
