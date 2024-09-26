#!/usr/bin/env bash

xinput --set-prop 11 "Coordinate Transformation Matrix" 0.75 0 0 0 0.5 0 0 0 1
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-3-1 --off --output DP-3-2 --mode 3440x1440 --pos 1920x0 --rotate normal --output DP-3-3 --mode 1920x1080 --pos 1920x1440 --rotate normal
