#!/bin/bash

create_docker()
{
	local IMGHASH="$(docker images -q "${DOCKERIMAGE}")"
	if [ "${IMGHASH}" = "" ]; then
		echo "Creating docker image..."
		"${SCRIPTDIR}/create-docker-image.sh" || exit $?

		"${SCRIPTDIR}/copy-to-docker.sh" || exit $?
	fi
}

start_docker()
{
	ISRUNING="$(docker container inspect -f '{{.State.Running}}' "${CONTAINER}")"
	if [ "${ISRUNING}" = "false" ]; then
		docker run -d -t --name "${CONTAINER}" --user "${BUILDUSER}" "${DOCKERIMAGE}"
		docker start "${CONTAINER}"
	fi
	CURUSER="$(docker container inspect -f '{{.Config.User}}' "${CONTAINER}")"
	if [ "${CURUSER}" != "${BUILDUSER}" ]; then
		set -x
		docker stop "${CONTAINER}"
		docker run -d -t --name "${CONTAINER}" --user "${BUILDUSER}" "${DOCKERIMAGE}"
		set +x
	fi

	docker ps -l
}
