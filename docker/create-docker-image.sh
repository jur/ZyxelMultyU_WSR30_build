#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "$0")" || exit $?
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit $?

CONFIGDIR="$(dirname "${SCRIPTDIR}")"
source "${CONFIGDIR}/config.sh"

docker build --network="host" -t "${DOCKERIMAGE}" .
