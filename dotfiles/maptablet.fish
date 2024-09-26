#!/usr/bin/env fish

set elements (xsetwacom --list devices)
for e in $elements
  set id (string trim (string split "type: " (string split "id: " $e)[2])[1]) 
  xsetwacom --set "$id" MapToOutput DP-3-3
end
