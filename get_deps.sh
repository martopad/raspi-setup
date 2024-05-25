#!/bin/bash



SCRIPT_DIR=$(realpath "$0")
BASE_DIR=$(dirname "$SCRIPT_DIR")
git -C "${BASE_DIR}" submodule update --init --recursive

wget -c -P "${BASE_DIR}/root/var/cache/distfiles/" "http://distfiles.gentoo.org/distfiles/b4/NetworkManager-1.46.0.tar.xz"


# Scriptified mechanism to fetch stage3 acquired from:
# https://github.com/gentoo/gentoo-docker-images/blob/master/stage3.Dockerfile
BASE_URL="https://ftp.agdsn.de/gentoo/releases/arm64/autobuilds/"
TXT_FILE="latest-stage3-aarch64_be-openrc.txt"
FULL_URL="${BASE_URL}/${TXT_FILE}"
wget -c -P "${BASE_DIR}" "${FULL_URL}"
STAGE3_PATH="$(sed -n '6p' "${TXT_FILE}" | cut -f 1 -d ' ')"
wget -c -P "${BASE_DIR}" "${BASE_URL}/${STAGE3_PATH}"


echo "Deps fetching done. You can proceed to deployment now."
