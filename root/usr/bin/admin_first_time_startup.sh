#!/bin/bash

emerge-webrsync

emerge --verbose --getbinpkg \
	cfg-update \
	net-misc/openssh \
	net-misc/ntp

rc-update del hwclock boot

rc-update add swclock boot
rc-service sshd start

rc-update add sshd default
rc-service sshd start

rc-update add ntp-client default
rc-service ntp-client start

echo "First time setup done. Restart is advised."
