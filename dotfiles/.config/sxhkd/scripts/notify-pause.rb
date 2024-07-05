#!/usr/bin/env ruby

options = [
    30,
    60,
    120
]

if `dunstctl is-paused`.strip() == "true"
    options.append("Unpause")
end

selection = `printf "#{options.join("\\n")}" | rofi -dmenu -i -m primary -p "Pause"`.strip()

if selection.to_i > 0
    system "dunstify 'Notifications Paused' 'Notifications paused for #{selection.to_i} minutes.'"
    sleep(3)
    system "dunstctl set-paused true"
    sleep(selection.to_i * 60)
    exec "dunstctl set-paused false"
elsif selection == "Unpause"
    system 'dunstify "Notifications Unpaused" "Notifications unpaused."'
    exec "dunstctl set-paused false"
end
