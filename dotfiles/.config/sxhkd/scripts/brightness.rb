#!/usr/bin/env ruby 

if ARGV.length == 2 and ["-u", "-d"].include? ARGV[0] and ARGV[1].to_i > 0
  # clean this up
  brightness = `brightnessctl`.split("\n")[1].split("(")[1].split("%")[0].to_i
  value = case
      when ARGV[0] == "-u"
        brightness + ARGV[1].to_i
      when ARGV[0] == "-d"
        brightness - ARGV[1].to_i
      end
  new = `brightnessctl s #{value}%`.split("\n")[2].split("(")[1].split("%")[0]
  exec "dunstify -r 102 '明るさ: #{new}'"
end
