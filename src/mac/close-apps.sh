#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")

# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

main() {
	# Creates a comma-separated String of open applications and assign it to the APPS variable.
	APPS=$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)')

	# Convert the comma-separated String of open applications to an Array using IFS.
	# http://stackoverflow.com/questions/10586153/split-string-into-an-array-in-bash
	IFS=',' read -r -a OPEN_APPS <<<"$APPS"

	# Loop through each item in the 'myAppsArray' Array.
	for APP in "${OPEN_APPS[@]}"; do
		# Remove space character from the start of the Array item
		NAME=$(echo "$APP" | sed 's/^ *//g')

		# Avoid closing the "Finder" and your CLI tool.
		# Note: you may need to change "iTerm" to "Terminal"
		if [[ ! "$NAME" == "Finder" && ! "$NAME" == "iTerm2" ]]; then
			# quit the application
			echo "Closing $NAME"
			osascript -e 'quit app "'"$NAME"'"'
		fi
	done

}

assert_mac
confirm
main
