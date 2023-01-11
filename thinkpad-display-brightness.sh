#!/bin/sh
# Source: https://github.com/sv0/scripts/thinkpad-display-brightness.sh
# This script is a part of my note(post)
# "How to fix not working brightness control keys"
# available at https://slavik.svyrydiuk.eu/how-to-fix-not-working-xf86-brightness-control-keys.html

# Usage:
#   thinkpad-display-brightness.sh up
#   thinkpad-display-brightness.sh down

# This script is licensed under The WTFPL (see LICENCE for more information).

# [1] https://unix.stackexchange.com/questions/526653/control-screen-brightness-in-i3

BASE_DIR=/sys/class/backlight/intel_backlight

test -d $BASE_DIR || exit 0

MIN=50
MAX=$(cat $BASE_DIR/max_brightness)
ACTUAL=$(cat $BASE_DIR/actual_brightness)

if [ "$1" = down ]; then
    ACTUAL=$((ACTUAL-100))
else
    ACTUAL=$((ACTUAL+100))
fi

if [ "$ACTUAL" -lt $MIN ]; then
    ACTUAL=$MIN
elif [ "$ACTUAL" -gt "$MAX" ]; then
    ACTUAL=$MAX
fi

echo "$ACTUAL" > "$BASE_DIR/brightness"
