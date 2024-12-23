#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "$0")" || exit $?
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit $?

CONFIGDIR="$(dirname "${SCRIPTDIR}")"
source "${CONFIGDIR}/config.sh"

REPO="git@github.com:jur/100ABMY13C0.git"
TAG="ce634c2d9579a85fcb57ef84a8a18ba5c64cbcb4"

IMGHASH="$(docker images -q "${DOCKERIMAGE}")"
if [ "${IMGHASH}" = "" ]; then
	echo "Creating docker image..."
	"${SCRIPTDIR}/create-docker-image.sh" || exit $?
fi

ISRUNING="$(docker container inspect -f '{{.State.Running}}' "${CONTAINER}")"
if [ "${ISRUNING}" != "false" ]; then
	set -x
	docker stop "${CONTAINER}"
	set +x
fi

set -x
if [ ! -e "${SRCDIR}/WSR30_100ABMY13C0.tar.bz2" ]; then
	if [ ! -e 100ABMY13C0 ]; then
		git clone "${REPO}" || exit $?
	fi
	cd 100ABMY13C0 || exit $?
	mkdir -p "${SRCDIR}" || exit $?
	git archive  --format=tar --prefix="100ABMY13C0/" -o "${SRCDIR}/WSR30_100ABMY13C0.tar" "${TAG}" || exit $?
	bzip2 "${SRCDIR}/WSR30_100ABMY13C0.tar"
fi
docker cp "${SRCDIR}/WSR30_100ABMY13C0.tar.bz2" ${CONTAINER}:/home/${BUILDUSER}/
docker cp "${BUILDSCRIPTDIR}/build.sh" ${CONTAINER}:/home/${BUILDUSER}/
