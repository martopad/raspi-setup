#!/bin/bash


ARG_FILES_DIR=$1
ARG_PARTI_BOOT=$2
ARG_PARTI_ROOT=$3

MNT_PT_ROOT="/mnt/gentoo"
MNT_PT_BOOT="/mnt/boot"

mount "${ARG_PARTI_ROOT}" "${MNT_PT_ROOT}"
pushd "${ARG_FILES_DIR}"
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner -C ${MNT_PT_ROOT}

mount "${ARG_PARTI_BOOT}" "${MNT_PT_BOOT}"
rsync -a "${ARG_FILES_DIR}/firmware/boot/" "${MNT_PT_BOOT}/"
rsync -a "${ARG_FILES_DIR}/firmware/modules" "${MNT_PT_ROOT}/lib/"

rsync -a "${ARG_FILES_DIR}/boot/" "${MNT_PT_BOOT}/"
rsync -a "${ARG_FILES_DIR}/root/" "${MNT_PT_ROOT}/"

sed -ie 's/f0:12345/#0f:12345/' "${MNT_PT_ROOT}/etc/inittab"

#Wifi
#wget -P "${MNT_PT_ROOT}/lib/firmware/brcm" \
#	https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt 
#wget -P "${MNT_PT_ROOT}/lib/firmware/brcm" \
#	https://github.com/armbian/firmware/raw/master/brcm/brcmfmac43430-sdio.bin
rsync -a "${ARG_FILES_DIR}/firmware-nonfree/debian/config/brcm80211/brcm" "${MNT_PT_ROOT}/lib/firmware/"
rsync -a "${ARG_FILES_DIR}/firmware-nonfree/debian/config/brcm80211/cypress" "${MNT_PT_ROOT}/lib/firmware/"

#Bluetooth
#wget -P "${MNT_PT_ROOT}/lib/firmware/brcm" https://raw.githubusercontent.com/RPi-Distro/bluez-firmware/master/broadcom/BCM43430A1.hcd
#wget -P "${MNT_PT_ROOT}/lib/firmware/brcm" https://raw.githubusercontent.com/RPi-Distro/bluez-firmware/master/broadcom/BCM4345C0.hcd

#Bootstrap Network manager for Wifi internet puposes.
# Maybe its better to do this via wired connection in the future.
wget -P "${MNT_PT_ROOT}/var/cache/distfiles/" "http://distfiles.gentoo.org/distfiles/b4/NetworkManager-1.46.0.tar.xz"


echo "Done, congratulations! Safely unmounting, please wait.":
echo "Syncing and unmounting: ${MNT_PT_BOOT}"
umount "${MNT_PT_BOOT}"
echo "Done"
echo "Synching and unmounting: ${MNT_PT_ROOT}"
umount "${MNT_PT_ROOT}"
echo "Done"
