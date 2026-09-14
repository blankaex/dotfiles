#!/usr/bin/env ruby

require "tempfile"

svg = <<~SVG
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
    <!-- outline -->
    <circle cx="16" cy="16" r="10" stroke="#4C4F69" stroke-width="3"/>
    <circle cx="16" cy="16" r="3" fill="#4C4F69"/>

    <!-- foreground -->
    <circle cx="16" cy="16" r="10" stroke="#EFF1F5" stroke-width="2"/>
    <circle cx="16" cy="16" r="1.5" fill="#EFF1F5"/>
  </svg>
SVG

svg_file = Tempfile.new(["crosshair-", ".svg"])
png_file = Tempfile.new(["crosshair-", ".png"])
cfg_file = Tempfile.new(["crosshair-", ".cfg"])

begin
  svg_file.write(svg)
  svg_file.close
  png_file.close
  cfg_file.close

  system("magick", svg_file.path, png_file.path) ||
    abort("ImageMagick failed")

  File.write(cfg_file.path, "32 16 16 #{png_file.path}\n")

  system("xcursorgen", cfg_file.path, "crosshair") ||
    abort("xcursorgen failed")
ensure
  [svg_file, png_file, cfg_file].each do |file|
    file.unlink rescue nil
  end
end
