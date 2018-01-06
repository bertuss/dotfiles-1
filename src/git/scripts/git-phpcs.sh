#!/bin/bash

files=$(git ls-files -om --exclude-standard)

if [[ -z "$files" ]]; then
	echo 'No files to check'
else
	phpcs $files
fi
