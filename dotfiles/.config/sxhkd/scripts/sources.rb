#!/usr/bin/env ruby 

output = `pactl list sources`.split("\n")
sinks = output.select{|line| line.include? "Name: "}.map{|line| line.split(": ")[1]}
selection = `echo "#{sinks.join("\n")}" | rofi -dmenu -i -m primary -p "#{`pactl get-default-source`}"`.strip

if !selection.empty? and sinks.include? selection
    exec "pactl set-default-source #{selection}"
end
