#!/bin/bash

if [[ $1 = "inc" ]]; then
	brightnessctl s 5%+
elif [[ $1 = "dec" ]]; then
	level=$(awk -F ',' '{print substr($4,0,2)}' <<<$(brightnessctl -m i))
	if [[ $level -ge 10 ]]; then
		brightnessctl s 5%-
	fi
fi
