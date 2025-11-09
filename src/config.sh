#!/bin/bash

set -eo pipefail

if [ -d .os-build ]; then
    # check for -f or --force flag
    if [[ " $* " != *" -f "* &&  " $* " != *" --force "* ]]; then
        
        # prompt user for confirmation
        read -p ".os-build directory already exists. Do you want to remove it? (Y/n) " choice
        case "$choice" in
            n|N ) echo "Aborting build."; exit 1;;
            * ) echo "Removing existing .os-build directory.";;
        esac
    fi

    else
        sudo rm -rf .os-build
fi

mkdir -p .os-build
cd .os-build

lb config noauto \
--mode debian \
--system live \
--interactive shell \
--bootappend-live "boot=live components persistence persistence-encryption=luks console=tty1 console=ttyS0,115200" \
--bootloaders grub-efi \
--binary-image iso-hybrid \
--debian-installer live \
--debian-installer-distribution trixie \
--distribution trixie \
--debian-installer-gui true \
--architectures amd64 \
--archive-areas 'main contrib non-free non-free-firmware' \
--backports true \
--security true \
--updates true \
--source false \
--linux-packages linux-image-6.12.48 \
--linux-flavours amd64 \
--apt-recommends false \
--binary-filesystem ext4 \
--firmware-binary true \
--firmware-chroot true \
--initramfs live-boot \
--iso-publisher LeiCraft_MC \
--iso-volume LeiOS-0.1.0 \
"${@}"

cp -r ../src/preseed.cfg config/includes.installer