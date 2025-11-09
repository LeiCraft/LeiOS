#!/bin/sh

set -e

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
# use default mirrors
#--mirror-bootstrap http://ftp.tw.debian.org/debian/ \
#--mirror-chroot http://ftp.tw.debian.org/debian/ \
#--mirror-binary http://ftp.tw.debian.org/debian/ \
#--mirror-binary-security http://security.debian.org/ \
#--mirror-chroot-security http://security.debian.org/ \
--archive-areas 'main contrib non-free non-free-firmware' \
--backports true \
--security true \
--updates true \
--source false \
--linux-packages linux-image-5.15.59 \
--linux-flavours amd64 \
--apt-recommends false \
--binary-filesystem ext4 \
--firmware-binary true \
--firmware-chroot true \
--initramfs live-boot \
--iso-publisher LeiCraft_MC \
--iso-volume LeiOS-0.1.0 \
"${@}"

cp -r ../preseed.cfg config/includes.installer