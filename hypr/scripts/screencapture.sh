#!/usr/bin/env bash

function notify_video() {
	if ! command -v notify-send 2>&1 >/dev/null; then
		exit 1
	fi
	notify-send "Screen captured video" -t 5000 -a "wf-recorder"
}

if [[ $1 == "image" ]]; then
	if ! command -v hyprshot 2>&1 >/dev/null; then
		exit 1
	fi

	if [[ $2 == "window" ]]; then
		hyprshot -o ~/Pictures/Hyprshot -m window -m active
	else
		hyprshot -o ~/Pictures/Hyprshot -m region
	fi
elif [[ $1 == "video" ]]; then
	if ! command -v wf-recorder 2>&1 >/dev/null; then
		exit 1
	fi

	if [[ ! -z $(pgrep wf-recorder) ]]; then
		pkill wf-recorder
		notify_video
		exit
	fi

	[ -z "$XDG_PICTURES_DIR" ] && type xdg-user-dir &>/dev/null && XDG_PICTURES_DIR=$(xdg-user-dir PICTURES)
	FILENAME="$(date +'%Y-%m-%d-%H%M%S_wf-recorder.mp4')"

	SAVEDIR="${XDG_PICTURES_DIR:=~}/WfRecorder"
	SAVE_FULLPATH="$SAVEDIR/$FILENAME"

	wf-recorder -f "$SAVE_FULLPATH" -g "$(slurp)"
fi
