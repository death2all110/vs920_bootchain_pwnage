#!/bin/bash
##########################################################################
##
##  LG Spectrum ICS root script
##  Linux/OSX version
##
##  LG Spectrum ICS root by jcase
##
##  Shell script by PlayfulGod 
##
##  based from script by djrbliss
##
##########################################################################
##
## Instructions
##
##  1. Put your device in debugging mode
##
##  2. Attach it via USB
##
##  3. Run this script in the same directory as the rest of the extracted
##     zipfile
##
##########################################################################
platform=`uname`
if [ $(uname -p) = 'powerpc' ]; then
        echo "[-] PowerPC is not supported."
        exit 1
fi

if [ "$platform" = 'Darwin' ]; then
        adb="./adb.osx"
        version="OSX"
else
        adb="./adb.linux"
        version="Linux"
fi
chmod +x $adb

which adb > /dev/null 2>&1
if [ $? -eq 0 ]; then
        adb="adb"
fi

echo "[*] LG Spectrum ICS root script ($version version)"
echo "[*] Copyright (c) 2012 jcase"
echo "[*]"
echo "[*] Roots the ICS Upgrade on the LG Spectrum"
echo "[*]"
echo "[*] Before continuing, ensure USB debugging is enabled and that your"
echo "[*] phone is connected via USB."
echo "[*]"
echo "[*] Press enter to root your phone..."

read -n 1 -s

echo "[*]"
echo "[*] Waiting for device..."
$adb kill-server
$adb wait-for-device

echo "[*] Device found."

$adb shell "rm /data/vpnch/vpnc_starter_lock && ln -s /data/local.prop /data/vpnch/vpnc_starter_lock"

echo "[*] Rebooting..."
$adb reboot
echo "[*] Waiting for reboot..."
$adb wait-for-device

$adb shell "rm /data/vpnch/vpnc_starter_lock"
$adb shell "echo 'ro.kernel.qemu=1' > /data/local.prop"

echo "[*] Rebooting again..."
$adb reboot
echo "[*] Waiting for reboot..."
$adb wait-for-device

# Install the goods
echo "[*] Installing root tools... "
$adb shell "mount -o remount,rw /system"
$adb push su /system/xbin/su
$adb shell "chmod 6755 /system/xbin/su"
$adb shell "ln -s /system/xbin/su /system/bin/su"
$adb push Superuser.apk /system/app/Superuser.apk
$adb push busybox /system/xbin/busybox
$adb shell "chmod 755 /system/xbin/busybox"
$adb shell "/system/xbin/busybox --install /system/xbin"

# Clean up after ourselves
echo "[*] Cleaning up..."
$adb shell "rm /data/local.prop"

echo "[*] Rebooting one last time..."
$adb reboot

$adb wait-for-device
echo "[*] Root complete, enjoy!"
echo "[*] Press any key to exit."
read -n 1 -s
$adb kill-server
