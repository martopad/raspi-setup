#!/bin/bash

ARG_TARGET_DISK=$1
if [[ -z "${ARG_TARGET_DISK}" ]]; then
	echo "Empty target disk, exiting..."
	exit 1
fi

PARTI_BOOT="${ARG_TARGET_DISK}1"
PARTI_SWAP="${ARG_TARGET_DISK}2"
PARTI_ROOT="${ARG_TARGET_DISK}3"

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ROOTDIR="${SCRIPTPATH}/.."

"${SCRIPTPATH}/1_fs_provisioning.sh" $ARG_TARGET_DISK
"${SCRIPTPATH}/2_put_files.sh" "${ROOTDIR}" "${PARTI_BOOT}" "${PARTI_ROOT}"

echo "Setup done, you can remove your sd card: ${ARG_TARGET_DISK}"

