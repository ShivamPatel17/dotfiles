#!/bin/bash

STATE_FILE="$HOME/.claude-waiting"

if [ -f "$STATE_FILE" ]; then
	# Check if file is recent (within last 5 minutes)
	if [ "$(uname)" = "Darwin" ]; then
		MTIME=$(stat -f %m "$STATE_FILE" 2>/dev/null)
	else
		MTIME=$(stat -c %Y "$STATE_FILE" 2>/dev/null)
	fi

	NOW=$(date +%s)
	AGE=$((NOW - MTIME))

	if [ $AGE -lt 30 ]; then
		# Show the widget
		sketchybar --set widgets.claude drawing=on

		# Parse session info if available
		SESSION=$(grep "session:" "$STATE_FILE" | cut -d: -f2)
		if [ -n "$SESSION" ]; then
			sketchybar --set widgets.claude label="$SESSION"
		fi
	else
		# Hide the widget (file is too old)
		sketchybar --set widgets.claude drawing=off
	fi
else
	# Hide the widget (no state file)
	sketchybar --set widgets.claude drawing=off
fi
