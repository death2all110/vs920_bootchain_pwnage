@echo off
cd "%~dp0"

echo [*] LG Spectrum ICS Root script (Windows version)
echo [*] Copyright (c) 2012 jcase
echo [*]
echo [*] Roots the ICS Upgrade for the LG Spectrum
echo [*]
echo [*] Before continuing, ensure USB debugging is enabled, that you
echo [*] have the latest LG drivers installed, and that your phone is
echo [*] connected via USB.
echo [*]
echo [*] Press enter to root your phone...
pause
echo [*] 

echo [*] Waiting for device...
adb kill-server
adb wait-for-device

echo [*] Device found.

adb shell "rm /data/vpnch/vpnc_starter_lock && ln -s /data/local.prop /data/vpnch/vpnc_starter_lock"

echo [*] Rebooting...
adb reboot
echo [*] Waiting for reboot...
adb wait-for-device

adb shell "rm /data/vpnch/vpnc_starter_lock"
adb shell "echo 'ro.kernel.qemu=1' > /data/local.prop"

echo [*] Rebooting again...
adb reboot
echo [*] Waiting for reboot...
adb wait-for-device

# Install the goods
echo [*] Installing root tools... 
adb remount
adb push su /system/bin/su
adb shell "chmod 6755 /system/bin/su"
adb shell "ln -s /system/bin/su /system/xbin/su"
adb push Superuser.apk /system/app/Superuser.apk
adb push busybox /system/xbin/busybox
adb shell "chmod 755 /system/xbin/busybox"
adb shell "/system/xbin/busybox --install /system/xbin"

# Clean up after ourselves
echo [*] Cleaning up...
adb shell "rm /data/local.prop"

echo [*] Rebooting one last time...
adb reboot

adb wait-for-device
echo [*] Root complete, enjoy!
echo [*] Press any key to exit.
pause
adb kill-server
cd ..
call bootloader_pwn.bat