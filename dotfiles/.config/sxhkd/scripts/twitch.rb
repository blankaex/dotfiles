#!/bin/env ruby

cache = File.readlines("#{ENV["XDG_CACHE_HOME"]}/twitch")

selection = `printf "#{cache.join()}" | rofi -dmenu -i -m primary -p "Stream"`

unless selection.empty?
    unless cache.include? selection
        File.write("#{ENV["XDG_CACHE_HOME"]}/twitch", selection, mode: "a")
    end

    exec "mpv 'https://www.twitch.tv/#{selection}'"
end
