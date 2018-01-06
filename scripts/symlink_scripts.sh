#!/usr/bin/env bash
set -efu

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")
# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

SCRIPTS=$(find -E "${SOURCE_DIR}/scripts" -type f -regex '.*\.(sh|py)$')

for FILE in $SCRIPTS; do
	if [[ ! -x "${FILE}" ]]; then
		echo "Set \"${FILE}\" as executable."
		chmod +x "${FILE}"
	fi
	BASE_NAME=${FILE##*/}
	BASE_NAME=${BASE_NAME%.*}
	echo "Linking \"${BASE_NAME}\"."
	ln -fs "${FILE}" "${BIN_DIR}/${BASE_NAME}"
done
