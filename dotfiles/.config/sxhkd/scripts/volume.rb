#!/usr/bin/env ruby

sink = `pactl get-default-sink`.strip
muted = `pactl get-sink-mute #{sink}`.strip == "Mute: yes" ? true : false

if ARGV.length == 1 and ARGV[0] == "-m"
    system "pactl set-sink-mute #{sink} toggle"
    if muted
        exec "dunstify -r 101 ミュート解除"
    else
        exec "dunstify -r 101 ミュート"
    end
elsif ARGV.length == 2 and ["-u", "-d"].include? ARGV[0] and ARGV[1].to_i > 0
    if muted
        exec "dunstify -r 101 ミュートになっています"
    else
        volume = `pactl get-sink-volume #{sink}`.split(" / ")[1].to_i
        value = case
            when ARGV[0] == "-u"
                volume + ARGV[1].to_i
            when ARGV[0] == "-d"
                volume - ARGV[1].to_i
        end
        system "pactl set-sink-volume #{sink} #{value}%"
        exec "dunstify -r 101 ボリューム：#{value}"
    end
end
