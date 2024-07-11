#!/usr/bin/env fish

set -l tid (xinput | grep -i "touchpad" | cut -d "=" -f 2 | sed -e 's/\\s.*//g')
set -l tstate (xinput list-props $tid | grep "Device Enabled" | cut -d ":" -f 2 | sed -e 's/\\s*//g')
if test $tstate -eq 1
  xinput set-prop $tid "Device Enabled" 0
else
  xinput set-prop $tid "Device Enabled" 1
end
