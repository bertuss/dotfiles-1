#!/usr/bin/env bash
set -efu
set -o pipefail

CURRENT_USER=$(whoami)
OS="$(uname -s)"
BASE_DIR=$(dirname "${SCRIPTS_DIR}")
SOURCE_DIR=${BASE_DIR}/src
BIN_DIR=${HOME}/.bin

export CURRENT_USER
export OS
export BASE_DIR
export SOURCE_DIR
