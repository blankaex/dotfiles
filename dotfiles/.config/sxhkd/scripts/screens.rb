#!/usr/bin/env ruby 

profiles = `autorandr --list`.split("\n")
selection = `echo "#{profiles.join("\n")}" | rofi -dmenu -i -m primary -p "Screen (#{`autorandr --current`.strip})"`.strip

if !selection.empty? and profiles.include? selection
    exec "autorandr #{selection}"
end
