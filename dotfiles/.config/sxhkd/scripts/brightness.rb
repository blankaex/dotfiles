#!/usr/bin/env ruby 

if ARGV.length == 2 and ["-u", "-d"].include? ARGV[0] and ARGV[1].to_i > 0
    brightness = `ddcutil getvcp 10`.split[8].chomp(',').to_i
    brightness = case
        when ARGV[0] == "-u"
            brightness + ARGV[1].to_i
        when ARGV[0] == "-d"
            brightness - ARGV[1].to_i
    end
    if ( brightness >= 0 && brightness <= 100 )
        system "ddcutil setvcp 10 #{brightness}"
    end
    exec "dunstify -r 102 '明るさ: #{brightness}'"
end
