#!/usr/bin/env bash
set -efu

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")
# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

if [ ! which yapf &>/dev/null ]; then
	pip3 install yapf
fi

if [ ! which shfmt &>/dev/null ]; then
	go get -u mvdan.cc/sh/cmd/shfmt
fi
