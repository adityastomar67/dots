#!/bin/bash

LOCK_FILE="$HOME/.cache/eww-control-center.lock"
EWW_BIN="$HOME/.local/bin/eww"
ACTIVE_PLAYERS=$(playerctl -l | head -n 1)

fix_stacking_bug() {
	for entry in $(xdotool search --pid $(pidof eww)); do
		xdo below -N eww-control-panel $entry
	done
}

run() {
	eww -c ${rice_dir}/lei open control-center
	sleep 0.2
	fix_stacking_bug; eww -c ${rice_dir}/lei update ccenter=true; xdo raise -N eww-bar

	sleep 0.8 && [[ ! -z "$ACTIVE_PLAYERS" ]] && eww -c ${rice_dir}/lei update mp=true
	touch "$LOCK_FILE"
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
	eww -c ${rice_dir}/lei daemon
	sleep 1
else
	if [[ ! -f "$LOCK_FILE" ]]; then
		run
	else
		rm "$LOCK_FILE"
		[[ ! -z "$ACTIVE_PLAYERS" ]] && eww -c ${rice_dir}/lei update mp=false && sleep 0.4
		eww -c ${rice_dir}/lei update ccenter=false
		sleep 0.6
		eww -c ${rice_dir}/lei close control-center
		xdo lower -N eww-bar
	fi
fi
