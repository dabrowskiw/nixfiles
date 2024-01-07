#!/usr/bin/env bash
# Requires ueberzugpp: https://github.com/jstkdng/ueberzugpp/issues/56

h=`tmux display -p -t $SESSION:$TMUX_PANE '#{pane_height}'`
w=`tmux display -p -t $SESSION:$TMUX_PANE '#{pane_width}'`
mw=$((w*9))
mh=$((h*18))
UB_PID_FILE="/tmp/.$(uuidgen)"
ueberzugpp layer --no-cache --no-stdin --silent --pid-file "${UB_PID_FILE}"
UB_PID=`cat ${UB_PID_FILE}`
UBS=/tmp/ueberzugpp-"$UB_PID".socket
ueberzugpp cmd -s "${UBS}" -a "add" -i PREVIEW -x "$1" -y "$2" --max-width "$w" --max-height "$h" -f "$5"
read -n 1 < /dev/tty
ueberzugpp cmd -s "${UBS}" -a "exit"
rm ${UB_PID_FILE}
rm ${UBS}
echo ${UB_PID_FILE}
#tmux send-keys -t $SESSION:$TMUX_PANE $REPLY
