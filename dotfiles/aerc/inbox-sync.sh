#!/usr/bin/env bash

MBSYNC=$(pgrep mbsync)
NOTMUCH=$(pgrep notmuch)

if [ -n "$MBSYNC" -o -n "$NOTMUCH" ]; then
    echo "Already running one instance of mbsync or notmuch. Exiting..."
    exit 0
fi

echo "Deleting messages tagged as *deleted*"
notmuch search --format=text0 --output=files tag:deleted | xargs -0 --no-run-if-empty rm -v

mbsync -V htw-inbox
mbsync -V posteo-inbox
notmuch new
