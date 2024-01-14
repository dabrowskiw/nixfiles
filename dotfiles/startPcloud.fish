#!/usr/bin/env fish

set -l pcn (ps -aux | grep pCloudDr | wc -l)
if test "$pcn" -lt 2
  pcloudcc --username piotr.dabrowski@posteo.de -m /home/wojtek/pCloud -d
end
