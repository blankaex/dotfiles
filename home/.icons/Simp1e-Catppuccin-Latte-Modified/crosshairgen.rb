#!/usr/bin/env ruby

require "tempfile"

foreground = "#EFF1F5"
background = "#4C4F69"

svgs = {
  "circle" => <<~SVG,
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
      <!-- outline -->
      <circle cx="16" cy="16" r="10" stroke="#{background}" stroke-width="3"/>
      <circle cx="16" cy="16" r="2" fill="#{background}"/>

      <!-- foreground -->
      <circle cx="16" cy="16" r="10" stroke="#{foreground}" stroke-width="2"/>
      <circle cx="16" cy="16" r="1.5" fill="#{foreground}"/>
    </svg>
  SVG

  "diamond" => <<~SVG,
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
      <!-- outline -->
      <path d="M16 6l10 10-10 10L6 16z"
            stroke="#{background}" stroke-width="3" stroke-linejoin="round"/>
      <circle cx="16" cy="16" r="2" fill="#{background}"/>

      <!-- foreground -->
      <path d="M16 6l10 10-10 10L6 16z"
            stroke="#{foreground}" stroke-width="2" stroke-linejoin="round"/>
      <circle cx="16" cy="16" r="1.5" fill="#{foreground}"/>
    </svg>
  SVG

  "brackets" => <<~SVG,
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
      <!-- outline -->
      <path d="M11 6H7a1 1 0 0 0-1 1v4"
            stroke="#{background}" stroke-width="3" stroke-linecap="round"/>
      <path d="M21 6h4a1 1 0 0 1 1 1v4"
            stroke="#{background}" stroke-width="3" stroke-linecap="round"/>
      <path d="M11 26H7a1 1 0 0 1-1-1v-4"
            stroke="#{background}" stroke-width="3" stroke-linecap="round"/>
      <path d="M21 26h4a1 1 0 0 0 1-1v-4"
            stroke="#{background}" stroke-width="3" stroke-linecap="round"/>
      <circle cx="16" cy="16" r="2" fill="#{background}"/>

      <!-- foreground -->
      <path d="M11 6H7a1 1 0 0 0-1 1v4"
            stroke="#{foreground}" stroke-width="2" stroke-linecap="round"/>
      <path d="M21 6h4a1 1 0 0 1 1 1v4"
            stroke="#{foreground}" stroke-width="2" stroke-linecap="round"/>
      <path d="M11 26H7a1 1 0 0 1-1-1v-4"
            stroke="#{foreground}" stroke-width="2" stroke-linecap="round"/>
      <path d="M21 26h4a1 1 0 0 0 1-1v-4"
            stroke="#{foreground}" stroke-width="2" stroke-linecap="round"/>
      <circle cx="16" cy="16" r="1.5" fill="#{foreground}"/>
    </svg>
  SVG

  "cross" => <<~SVG,
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
      <!-- outline -->
      <line x1="16" y1="2" x2="16" y2="10"
            stroke="#{background}" stroke-width="3"/>
      <line x1="16" y1="22" x2="16" y2="30"
            stroke="#{background}" stroke-width="3"/>
      <line x1="2" y1="16" x2="10" y2="16"
            stroke="#{background}" stroke-width="3"/>
      <line x1="22" y1="16" x2="30" y2="16"
            stroke="#{background}" stroke-width="3"/>
      <circle cx="16" cy="16" r="2" fill="#{background}"/>

      <!-- foreground -->
      <line x1="16" y1="2" x2="16" y2="10"
            stroke="#{foreground}" stroke-width="2"/>
      <line x1="16" y1="22" x2="16" y2="30"
            stroke="#{foreground}" stroke-width="2"/>
      <line x1="2" y1="16" x2="10" y2="16"
            stroke="#{foreground}" stroke-width="2"/>
      <line x1="22" y1="16" x2="30" y2="16"
            stroke="#{foreground}" stroke-width="2"/>
      <circle cx="16" cy="16" r="1.5" fill="#{foreground}"/>
    </svg>
  SVG

  "triangle" => <<~SVG,
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
      <!-- outline -->
      <path d="M16 7l11 18H5z"
            stroke="#{background}" stroke-width="3" stroke-linejoin="round"/>
      <circle cx="16" cy="18" r="2" fill="#{background}"/>

      <!-- foreground -->
      <path d="M16 7l11 18H5z"
            stroke="#{foreground}" stroke-width="2" stroke-linejoin="round"/>
      <circle cx="16" cy="18" r="1.5" fill="#{foreground}"/>
    </svg>
  SVG
}

selection = IO.popen(
  ["sk", "--prompt=Crosshair) "], "r+"
) do |io|
  io.write(svgs.keys.join("\n"))
  io.close_write
  io.read.strip
end

abort("No selection") if selection.empty?

svg = svgs.fetch(selection)

svg_file = Tempfile.new(["crosshair-", ".svg"])
png_file = Tempfile.new(["crosshair-", ".png"])
cfg_file = Tempfile.new(["crosshair-", ".cfg"])

begin
  svg_file.write(svg)
  svg_file.close
  png_file.close
  cfg_file.close

  system("magick", "-background", "none", svg_file.path, png_file.path) ||
    abort("ImageMagick failed")

  File.write(cfg_file.path, "32 16 16 #{png_file.path}\n")

  system("xcursorgen", cfg_file.path, "crosshair") ||
    abort("xcursorgen failed")
ensure
  [svg_file, png_file, cfg_file].each do |file|
    file.unlink rescue nil
  end
end
