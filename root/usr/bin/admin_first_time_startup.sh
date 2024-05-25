#!/bin/bash

emerge-webrsync

emerge --verbose cfg-update
emerge --verbose networkmanager
emerge --verbose net-misc/ntp
emerge --verbose --oneshot net-misc/openssh

rc-update del hwclock boot

rc-update add swclock boot
rc-service sshd start

rc-update add NetworkManager default
rc-service NetworkManagfer start

rc-update add sshd default
rc-service sshd start

rc-update add ntp-client default
rc-service ntp-client start

echo "First time setup done. Restart is advised."
