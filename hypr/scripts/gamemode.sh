HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
	hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
	notify-send -a "Hyprland" -t 1000 -u low "Gaming Mode Activated" "Gaming mode toggled ON"
	exit
fi

hyprctl reload
notify-send -a "Hyprland" -t 1000 -u low "Gaming Mode Deactivated" "Gaming mode toggled OFF"
