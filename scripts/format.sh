#!/usr/bin/env bash
set -efu

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")
# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

# Shell script format
shfmt -l -w "${SOURCE_DIR}"
shfmt -l -w "${SCRIPTS_DIR}"

# Python scripts format
yapf --recursive --parallel "${SOURCE_DIR}"
yapf --recursive --parallel "${SCRIPTS_DIR}"
