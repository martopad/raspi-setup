# raspi-setup

My simple way of documenting how to provision my raspi 3B for Gentoo.

Notes:
1) Committing hard coded passwords, even though hashed/obfuscated, in source-control is bad practice:
    - etc/shadow file is not included in this commit. Added also in .gitignore.
    - This will be fixed in the future once I enable ssh-only root login
2) Artifacts needed for deployment needs a seperate download step:
    - firmware submodules
    - stage 3 file
    - networkmanager tar file. To bootstrap networkmanager installation for wifi-only raspi.
