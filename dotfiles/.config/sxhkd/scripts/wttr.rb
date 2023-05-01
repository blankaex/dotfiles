#!/usr/bin/env ruby

cache = File.readlines("#{ENV["XDG_CACHE_HOME"]}/wttr")

location = `printf "#{cache.join()}" | rofi -dmenu -i -m primary -p "Location"`

unless location.empty?
    unless cache.include? location
        File.write("#{ENV["XDG_CACHE_HOME"]}/wttr", location, mode: "a")
    end

    system "curl -o #{ENV["XDG_CACHE_HOME"]}/wttr-cache wttr.in/#{location}"
    system "sed -i '1,7d;39,40d' #{ENV["XDG_CACHE_HOME"]}/wttr-cache"

    system "bspc rule -a wttr state=floating follow=on center=on rectangle=1530x880+0+0"
    exec "alacritty --class wttr -e less #{ENV["XDG_CACHE_HOME"]}/wttr-cache"
end
