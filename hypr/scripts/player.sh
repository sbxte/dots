#!/bin/bash

if ! command -v playerctl 2>&1 >/dev/null; then
	exit 1
fi

if [[ $1 == "stop" ]]; then
	playerctl stop
elif [[ $1 == "pause" ]]; then
	playerctl pause
elif [[ $1 == "play" ]]; then
	playerctl play
elif [[ $1 == "pp" ]]; then
	playerctl play-pause
elif [[ $1 == "next" ]]; then
	playerctl next
elif [[ $1 == "prev" ]]; then
	playerctl previous
fi
