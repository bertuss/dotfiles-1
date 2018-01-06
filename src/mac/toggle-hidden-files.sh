#!/usr/bin/env bash

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")

# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

main() {
	CURRENT_SETTING="$(defaults read com.apple.finder AppleShowAllFiles)"

	if [ $CURRENT_SETTING == 'YES' ] || [ $CURRENT_SETTING == 'TRUE' ]; then
		defaults write com.apple.finder AppleShowAllFiles NO
		killall Finder /System/Library/CoreServices/Finder.app
		echo "Not showing hidden files."
	elif [ $CURRENT_SETTING == 'NO' ] || [ $CURRENT_SETTING == 'FALSE' ]; then
		defaults write com.apple.finder AppleShowAllFiles YES
		killall Finder /System/Library/CoreServices/Finder.app
		echo "Showing hidden files."
	fi
}

assert_mac
confirm
main
