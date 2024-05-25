#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "$0")" || exit $?
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit $?

CONFIGDIR="$(dirname "${SCRIPTDIR}")"
source "${CONFIGDIR}/config.sh"
source "${SCRIPTDIR}/tools.sh"

create_docker
start_docker

set -x
docker exec -it "${CONTAINER}" "/home/${BUILDUSER}/build.sh"
docker cp "${CONTAINER}:/home/${BUILDUSER}/100ABMY13C0/rtl819x/image/fw.bin" .
