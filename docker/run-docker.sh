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
docker exec -it "${CONTAINER}" /bin/bash
