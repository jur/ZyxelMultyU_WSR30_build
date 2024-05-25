#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "$0")" || exit $?
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit $?

FWARCHIVE="WSR30_100ABMY13C0.tar.bz2"
FWSRCDIR="${SCRIPTDIR}/100ABMY13C0/rtl819x"

if  [ ! -e "${FWSRCDIR}" ]; then
	tar -jxvf "${FWARCHIVE}" || exit $?

	# Remove password:
	cd "${FWSRCDIR}" || exit $?
	mapfile -t FILES < <(find . -iname "shadow.sample")
	for FILE in "${FILES[@]}"; do
		sed -ie "s/root:[^:]*/root:/g" "${FILE}"
	done
fi

set -x
cd "${FWSRCDIR}" || exit $?

export TERM=xterm1
export TERMINFO=/usr/share/terminfo
make || exit $?
