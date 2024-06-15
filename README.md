# raspi-setup

My simple way of documenting how to provision my raspi 3B for Gentoo.

Tools dependencies:
1) sys-fs/dosfstools: to write vfat to the boot partition

Directories/files description:
1) `boot` and `root`
    - Contains the files that will be copied to /boot and / in the storage medium.
    - In the setup, these are mounted in /mnt/boot and /mnt/gentoo.
2) `deployment`
    - contains the scripts that will prepare and copy the files to the storage device. This includes:
        - Wiping and formatting the target storage device.
        - copying firmware files for both boot and root.
        - copy the configuration and script files to both boot and root.
3) `get_deps.sh`
    - clones the submodules
    - gets the stage3 tarball
    - gets portage packages for bootstrapping

Steps:
1) run get_deps.sh script
2) run deployment/setup.sh script passing the storage device the you want to format
    - This is destructive. Double check the storage device that you will pass.

Missing implementations:
1) setting root password in etc/shadow (no ssh service is still installed)
2) Whole system setup is not performed-- steps done when chrooting to root dir.
    - So whent the raspi is booted, portage, timezone, mirros, binrepo, are not setup.

Notes:
1) Committing hard coded passwords, even though hashed/obfuscated, in source-control is bad practice:
    - etc/shadow file is not included in this commit. Added also in .gitignore.
    - This will be fixed in the future once I enable ssh-only root login
2) Artifacts needed for deployment needs a seperate download step:
    - firmware submodules
    - stage 3 file
    - networkmanager tar file. To bootstrap networkmanager installation for wifi-only raspi.
