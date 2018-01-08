#!/usr/bin/env bash
set -efu

SCRIPTS_DIR=$(dirname "$(python3 -c "import os; print(os.path.realpath('$0'))")")
# shellcheck source=_build.sh
. "${SCRIPTS_DIR}/_common.sh" "$@"

if [[ ! -d ${HOME}/.bin ]]; then
	mkdir -p "${HOME}/.bin"
fi

scripts=$(find -E "${SOURCE_DIR}/scripts" -type f -regex '.*\.(sh|py)$')

for file in $scripts; do
	if [[ ! -x "${file}" ]]; then
		echo "Set \"${file}\" as executable."
		chmod +x "${file}"
	fi
	base_name=${file##*/}
	base_name=${base_name%.*}
	echo "Linking \"${base_name}\"."
	ln -fs "${file}" "${BIN_DIR}/${base_name}"
done
