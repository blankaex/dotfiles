#!/usr/bin/env ruby

operation = {
  "-u" => :increase,
  "-d" => :decrease
}[ARGV[0]]

brightness = `ddcutil getvcp 10`.split[8].to_i

value = (case operation
  when :increase then brightness + 10
  when :decrease then brightness - 10
end).clamp(10, 100)

system "ddcutil setvcp 10 #{value.to_s}"
exec "dunstify -r 102 明るさ:#{value}"
