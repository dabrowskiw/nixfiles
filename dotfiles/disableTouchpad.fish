#!/usr/bin/env fish

set -l tid (xinput | grep -i "touchpad" | cut -d "=" -f 2 | sed -e 's/\\s.*//g')
set -l tstate (xinput list-props $tid | grep "Device Enabled" | cut -d ":" -f 2 | sed -e 's/\\s*//g')
xinput set-prop $tid "Device Enabled" 0
