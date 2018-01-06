#!/usr/bin/env bash
set -efu

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")
# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

CONFIG="${BASE_DIR}/install.conf.yaml"
DOTBOT_DIR="${BASE_DIR}/dotbot"
DOTBOT_BIN="${DOTBOT_DIR}/bin/dotbot"

cd "${BASE_DIR}"
git submodule update --init --recursive "${DOTBOT_DIR}"

"${DOTBOT_BIN}" -d "${BASE_DIR}" -c "${CONFIG}" "${@}"
