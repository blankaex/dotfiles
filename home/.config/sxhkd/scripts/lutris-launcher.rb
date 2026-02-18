#!/usr/bin/env ruby

require "json"

blob = JSON.parse(`lutris -ljo`)

games = blob.map{|object| object["name"]}

selection = `echo "#{games.join("\n")}" | rofi -dmenu -i -m primary -p "Game"`.strip

slug = blob.detect{|object| object["name"] == selection}["slug"]

exec("lutris lutris:rungame/#{slug}")
