{ pkgs, ... }:

let
  startPcloud = pkgs.writeTextFile {
    name = "startPcloud";
    destination = "/bin/startPcloud";
    executable = true;
    text = ''
#!/usr/bin/env fish

set -l pcn (ps -aux | grep pCloudDr | wc -l)
if test "$pcn" -lt 2
  pcloudcc --username piotr.dabrowski@posteo.de -m /home/wojtek/pCloud -d
end
    '';
  };
  toggleTouchpad = pkgs.writeTextFile {
    name = "toggleTouchpad";
    destination = "/bin/toggleTouchpad";
    executable = true;
    text = ''
#!/usr/bin/env fish

set -l tid (xinput | grep -i "touchpad" | cut -d "=" -f 2 | sed -e 's/\\s.*//g')
set -l tstate (xinput list-props $tid | grep "Device Enabled" | cut -d ":" -f 2 | sed -e 's/\\s*//g')
if test $tstate -eq 1
  xinput set-prop $tid "Device Enabled" 0
else
  xinput set-prop $tid "Device Enabled" 1
end
    '';
  };
  screenMouseHome = pkgs.writeTextFile {
    name = "screenMouseHome";
    destination = "/bin/screenMouseHome";
    executable = true;
    text = ''
#!/usr/bin/env bash

xinput --set-prop 11 "Coordinate Transformation Matrix" 0.75 0 0 0 0.5 0 0 0 1
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-3-1 --off --output DP-3-2 --mode 3440x1440 --pos 1920x0 --rotate normal --output DP-3-3 --mode 1920x1080 --pos 1920x1440 --rotate normal
    '';
  };
  disableTouchpad = pkgs.writeTextFile {
    name = "disableTouchpad";
    destination = "/bin/disableTouchpad";
    executable = true;
    text = ''
#!/usr/bin/env fish

set -l tid (xinput | grep -i "touchpad" | cut -d "=" -f 2 | sed -e 's/\\s.*//g')
set -l tstate (xinput list-props $tid | grep "Device Enabled" | cut -d ":" -f 2 | sed -e 's/\\s*//g')
xinput set-prop $tid "Device Enabled" 0
    '';
  };
  runlutrisgame = pkgs.writeTextFile {
    name = "runlutrisgame";
    destination = "/bin/runlutrisgame";
    executable = true;
    text = ''
#/usr/bin/env bash

gameid=`lutris --list-games | grep  "$1" | head -n 1 | cut -d "|" -f 1 | sed -e 's/ //g'`
lutriscmd="env LUTRIS_SKIP_INIT=1 lutris lutris:rungameid/$gameid"
$lutriscmd
    '';
  };
  i3config = pkgs.writeTextFile {
    name = "i3config";
    destination = "/share/i3.config";
    text = ''
# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod1
set $altgr Mod3

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:monospace 8

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Start XDG autostart .desktop files using dex. See also
# https://wiki.archlinux.org/index.php/XDG_Autostart
exec --no-startup-id dex --autostart --environment i3

# The combination of xss-lock, nm-applet and pactl is a popular choice, so
# they are included here as an example. Modify as you see fit.

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

exec --no-startup-id xsetroot -solid "#001122"

#exec_always --no-startup-id espanso service start --unmanaged
exec_always --no-startup-id fish ${disableTouchpad}/bin/disableTouchpad 

exec_always --no-startup-id ${startPcloud}/bin/startPcloud

exec_always --no-startup-id xsetwacom --set "23" MapToOutput DP-3-3
exec_always --no-startup-id xsetwacom --set "11" MapToOutput DP-3-3

# Use pactl to adjust volume in PulseAudio.
set $refresh_i3status killall -SIGUSR1 i3-status
#bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && pactl play-sample bleep 0 && $refresh_i3status
#bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && pactl play-sample bleep && $refresh_i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id /home/wojtek/Documents/Private/IT/i3scipts/increase_volume.sh && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id /home/wojtek/Documents/Private/IT/i3scipts/decrease_volume.sh && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# move tiling windows via drag & drop by left-clicking into the title bar,
# or left-clicking anywhere into the window while holding the floating modifier.
# tiling_drag modifier titlebar

# start a terminal
#bindsym $mod+Return exec i3-sensible-terminal
#bindsym $mod+Return exec alacritty -e /usr/bin/fish
bindsym $mod+Return exec contour -e fish

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec --no-startup-id dmenu_run
# A more modern dmenu replacement is rofi:
# bindcode $mod+40 exec "rofi -modi drun,run -show drun"
# There also is i3-dmenu-desktop which only displays applications shipping a
# .desktop file. It is a wrapper around dmenu, so you need that installed.
# bindcode $mod+40 exec --no-startup-id i3-dmenu-desktop

# set keyboard layout
bindsym $mod+t exec --no-startup-id setxkbmap -model pc105 -layout de && $refresh_i3status
bindsym $mod+Shift+t exec --no-startup-id setxkbmap -model pc105 -layout pl && $refresh_i3status
bindsym $mod+space exec --no-startup-id espanso cmd search

# toggle touchpad
bindsym $mod+m exec --no-startup-id ${toggleTouchpad}/bin/toggleTouchpad

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right
bindsym $altgr+h focus left
bindsym $altgr+j focus down
bindsym $altgr+k focus up
bindsym $altgr+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+Ctrl+h split h

# split in vertical orientation
bindsym $mod+Ctrl+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+Shift+s layout stacking
bindsym $mod+Shift+w layout tabbed
bindsym $mod+Shift+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

# switch to workspace
bindsym $mod+1 workspace number $ws1
bindsym $mod+2 workspace number $ws2
bindsym $mod+3 workspace number $ws3
bindsym $mod+4 workspace number $ws4
bindsym $mod+5 workspace number $ws5
bindsym $mod+6 workspace number $ws6
bindsym $mod+7 workspace number $ws7
bindsym $mod+8 workspace number $ws8
bindsym $mod+9 workspace number $ws9
bindsym $mod+0 workspace number $ws10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+6 move container to workspace number $ws6
bindsym $mod+Shift+7 move container to workspace number $ws7
bindsym $mod+Shift+8 move container to workspace number $ws8
bindsym $mod+Shift+9 move container to workspace number $ws9
bindsym $mod+Shift+0 move container to workspace number $ws10

bindsym $mod+Shift+Ctrl+l move workspace to output right
bindsym $mod+Shift+Ctrl+h move workspace to output left

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
#bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym odiaeresis resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}

bindsym $mod+r mode "resize"

set $i3lockwall i3lock -c 000000 

# network management
set $mode_actions (c) onnect WWAN, (d) isconnect WWAN, connect (V)PN, disconnect (v)pn, (h)ome screen config

mode "$mode_actions" {
    bindsym c exec --no-startup-id nmcli connection up a2bff2f1-22f2-4c20-8f27-90913578abff, mode "default"
    bindsym d exec --no-startup-id nmcli connection down a2bff2f1-22f2-4c20-8f27-90913578abff, mode "default"
    bindsym Shift+v exec --no-startup-id sudo /home/wojtek/Documents/HTW/IT/HTW-SSH-Split.sh, mode "default"
    bindsym v exec --no-startup-id sudo /home/wojtek/Documents/HTW/IT/stop_openconnect.sh, mode "default"
    bindsym h exec --no-startup-id ${screenMouseHome}/bin/screenMouseHome, mode "default"

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
# shutdown / restart / suspend...
set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (CTRL+s) shutdown

mode "$mode_system" {
    bindsym l exec --no-startup-id $i3lockwall, mode "default"
    bindsym e exec --no-startup-id i3-msg exit, mode "default"
    bindsym s exec --no-startup-id $i3lockwall && systemctl suspend, mode "default"
    bindsym h exec --no-startup-id $i3lockwall && systemctl hibernate, mode "default"
    bindsym r exec --no-startup-id systemctl reboot, mode "default"
    bindsym Ctrl+s exec --no-startup-id systemctl poweroff -i, mode "default"

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# lutris games
set $mode_lutris (p)layground sessions

mode "$mode_lutris" {
    bindsym p exec --no-startup-id ${runlutrisgame}/bin/runlutrisgame playground-sessions, mode "default"

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
# shutdown / restart / suspend...

bindsym $mod+BackSpace mode "$mode_system"
bindsym $mod+Ctrl+a mode "$mode_actions"
bindsym $mod+Ctrl+l mode "$mode_lutris"

workspace 1 output eDP-1 eDP-1-1 DP-3-2
workspace 3 output eDP-1 eDP-1-1 DP-3-2
workspace 5 output eDP-1 eDP-1-1 DP-3-2
workspace 7 output eDP-1 eDP-1-1 DP-3-2
workspace 9 output eDP-1 eDP-1-1 DP-3-2
workspace 2 output DP-3-2 DP-4 DP-2-2 DP-1-2-2 eDP-1
workspace 4 output DP-3-2 DP-4 DP-2-2 DP-1-2-2 eDP-1
workspace 6 output DP-3-2 DP-4 DP-2-2 DP-1-2-2 eDP-1
workspace 8 output DP-3-2 DP-4 DP-2-2 DP-1-2-2 eDP-1
workspace 0 output DP-3-2 DP-4 DP-2-2 DP-1-2-2 eDP-1

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  status_command bumblebee-status -m xrandr load disk memory battery pasink pasource brightness layout datetime -t gruvbox -p xrandr.autotoggle=true datetime.format="%a, %d.%m.%Y %H:%M:%S"
}

assign [title="zoom"] 9
    '';
  };
in
{ 
  home.file.".config/i3/config".source = "${i3config}/share/i3.config";
  home.packages = [
    startPcloud
    toggleTouchpad
    disableTouchpad
    runlutrisgame
    screenMouseHome
    startPcloud
    i3config
  ];
}

