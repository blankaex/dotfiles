#!/usr/bin/env ruby

exec(ARGV[1]) if `printf "No\\nYes" | rofi -dmenu -i -m primary -p "#{ARGV[0]}"`.strip() == "Yes"
