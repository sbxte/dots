#!/usr/bin/env bash

HYPRSHOT_PATH="$(xdg-user-dir)/Pictures/Hyprshot"
WFRECORDER_PATH="$(xdg-user-dir)/Pictures/WfRecorder"

function notify_video_start() {
	if ! command -v notify-send 2>&1 >/dev/null; then
		exit 1
	fi
	notify-send "Beginning screen video capture"
}
function notify_video_end() {
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
		hyprshot -o $HYPRSHOT_PATH -m window -m active
	elif [[ $2 == "monitor" ]]; then
		hyprshot -o $HYPRSHOT_PATH -m output -m active
	elif [[ $2 == "region" ]]; then
		hyprshot -o $HYPRSHOT_PATH -m region
	else 
		notify-send "Invalid/missing 2nd parameter for screencapture script"
	fi
elif [[ $1 == "video" ]]; then
	if ! command -v wf-recorder 2>&1 >/dev/null; then
		exit 1
	fi

	if [[ ! -z $(pgrep wf-recorder) ]]; then
		pkill wf-recorder
		notify_video_end
		exit
	fi

	# [ -z "$XDG_PICTURES_DIR" ] && type xdg-user-dir &>/dev/null && XDG_PICTURES_DIR=$(xdg-user-dir PICTURES)
	FILENAME="$(date +'%Y-%m-%d-%H%M%S_wf-recorder.mp4')"
	#
	# SAVEDIR="${XDG_PICTURES_DIR:=~}/WfRecorder"
	# SAVE_FULLPATH="$SAVEDIR/$FILENAME"

	SAVE_FULLPATH="$WFRECORDER_PATH/$FILENAME"

	notify_video_start
	wf-recorder -f "$SAVE_FULLPATH" -g "$(slurp)"
elif [[ $1 == "open" ]]; then 
	IMAGE_PATH="$HYPRSHOT_PATH/$(ls "$HYPRSHOT_PATH" -Art | tail -n 1)"
	VIDEO_PATH="$WFRECORDER_PATH/$(ls "$WFRECORDER_PATH" -Art | tail -n 1)"
	IMAGE_TIMESTAMP=$(stat -c "%Y" $IMAGE_PATH)
	VIDEO_TIMESTAMP=$(stat -c "%Y" $VIDEO_PATH)
	if [[ $IMAGE_TIMESTAMP -ge $VIDEO_TIMESTAMP ]]; then 
		xdg-open $IMAGE_PATH
	else
		xdg-open $VIDEO_PATH
	fi
fi
