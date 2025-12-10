if ! command -v bc 2>&1 >/dev/null; then
	exit 1
fi

# bind = $mainMod SHIFT, mouse_up, exec, hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.2}")
# bind = $mainMod SHIFT, mouse_down, exec, hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.2}")
# bind = $mainMod SHIFT, z, exec, hyprctl keyword cursor:zoom_factor 1 # Reset zoom
if [[ $1 == "in" ]]; then 
	ZOOM_FACTOR=$(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}')
	NEW_ZOOM_FACTOR=$(echo "$ZOOM_FACTOR + 1" | bc)
	hyprctl keyword cursor:zoom_factor $NEW_ZOOM_FACTOR
elif [[ $1 == "out" ]]; then 
	ZOOM_FACTOR=$(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}')
	NEW_ZOOM_FACTOR=$(echo "$ZOOM_FACTOR - 1" | bc)
	hyprctl keyword cursor:zoom_factor $NEW_ZOOM_FACTOR
elif [[ $1 == "reset" ]]; then 
	hyprctl keyword cursor:zoom_factor 1
fi
