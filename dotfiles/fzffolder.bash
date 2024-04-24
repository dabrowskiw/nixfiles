#!/usr/bin/env bash

folder=$(find /home/wojtek/Maildir/htw/ -type d | grep -vE "/tmp$|/cur$|/new$" | fzf)


echo "push 'c$folder<enter>'"
