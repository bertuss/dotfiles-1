#!/usr/bin/env bash

assert_mac() {
	if [[ "$(uname)" -ne "Darwin" ]]; then
		echo "This command is only usable in macOS"
		exit 1
	fi
}

confirm() {
	read -p "Are you sure? [y/n]" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		return 0
	else
		echo "User exit"
		exit 1
	fi
}
