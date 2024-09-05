# Exit if xbacklight does not exist
if ! command -v xbacklight &>/dev/null; then
	exit
fi

if [[ $1 = "inc" ]]; then
	xbacklight -inc 5
elif [[ $1 = "dec" ]]; then
	level=$(xbacklight -get)
	if [[ $level -ge 10 ]]; then
		xbacklight -dec 5
	fi
fi
