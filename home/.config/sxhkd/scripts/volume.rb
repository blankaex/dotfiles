#!/usr/bin/env ruby

sink = `pactl get-default-sink`.strip
muted = `pactl get-sink-mute #{sink}`.include?("Mute: yes")

operation = {
  "-m" => :toggle_mute,
  "-u" => :increase,
  "-d" => :decrease
}[ARGV[0]]

case operation
when :toggle_mute
  system "pactl set-sink-mute #{sink} toggle"
  exec "dunstify -r 101 #{muted ? 'ミュート解除' : 'ミュート'}"

when :increase, :decrease
  exec "dunstify -r 101 ミュートになっています" if muted

  volume = `pactl get-sink-volume #{sink}`.split(" / ")[1].to_i
  value = (case operation
    when :increase then (volume + 10)
    when :decrease then (volume - 10)
  end).clamp(0, 100)

  system "pactl set-sink-volume #{sink} #{value}%"
  exec "dunstify -r 101 音量：#{value}"
end
