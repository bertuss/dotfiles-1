#!/bin/bash

files=$(git ls-files -om --exclude-standard)

if [[ -z "$files" ]]; then
	echo 'No files to open'
else
	$EDITOR_GUI $files
fi
