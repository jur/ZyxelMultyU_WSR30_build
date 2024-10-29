#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "$0")" || exit $?
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit $?

CONFIGDIR="${SCRIPTDIR}"
SCRIPTDIR="${SCRIPTDIR}/scripts"
source "${CONFIGDIR}/config.sh"
source "${SCRIPTDIR}/tools.sh"

FWFILE="${1:-fw.bin}"

if [ ! -e "${FWFILE}" ]; then
	echo >&2 "Error: Firmware file ${FWFILE} missing."
	exit 1
fi

cat >flashupdatecmds.txt <<EOF

eth
tftp 192.168.1.6
binary
put ${FWFILE}
quit
EOF

target_power_on

"${SCRIPTDIR}/sendscript.exp" "${SERIALDEVICE}" "flashupdatecmds.txt"
