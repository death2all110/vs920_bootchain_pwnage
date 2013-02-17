#!/system/bin/busybox sh

cd /data/local/tmp/pwn

echo "Flashing Bootloader!"

#P7
if [ `busybox md5sum /data/local/tmp/pwn/mmcblk0p7.img | busybox cut -d ' ' -f 1` != 528f925fcc6cb66d16260a6ac5410dc2 ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/mmcblk0p7.img of=/dev/block/mmcblk0p7 bs=4096'

echo "Flashing CWM Recovery...."
if [ `busybox md5sum /data/local/tmp/pwn/cwmrecovery.img | busybox cut -d ' ' -f 1` != 44a7e770d4decd7a44e6c3c23f1b928d ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/cwmrecovery.img of=/dev/block/mmcblk0p13 bs=4096'

#P2
if [ `busybox md5sum /data/local/tmp/pwn/mmcblk0p2.img | busybox cut -d ' ' -f 1` != 8d4575aebfd32c599ef505d9c2d518fb ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/mmcblk0p2.img of=/dev/block/mmcblk0p2 bs=4096'

#P3
if [ `busybox md5sum /data/local/tmp/pwn/mmcblk0p3.img | busybox cut -d ' ' -f 1` != db6c453eb6c69d9273daa97ff02a29a2 ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/mmcblk0p3.img of=/dev/block/mmcblk0p3 bs=4096'

#P5
if [ `busybox md5sum /data/local/tmp/pwn/mmcblk0p5.img | busybox cut -d ' ' -f 1` != 9b99629290e183c627e46795d352ec87 ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/mmcblk0p5.img of=/dev/block/mmcblk0p5 bs=4096'

#P6
if [ `busybox md5sum /data/local/tmp/pwn/mmcblk0p6.img | busybox cut -d ' ' -f 1` != 664cbefd609c8866b35f51f93a5e2d25 ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!" 
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/mmcblk0p6.img of=/dev/block/mmcblk0p6 bs=4096'

#P9
if [ `busybox md5sum /data/local/tmp/pwn/mmcblk0p9.img | busybox cut -d ' ' -f 1` != b508eda5aa1eb658b2cf75587276dfda ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/mmcblk0p9.img of=/dev/block/mmcblk0p9 bs=4096'

#P8
if [ `busybox md5sum /data/local/tmp/pwn/boot_nowallpaper.img | busybox cut -d ' ' -f 1` != 5e47b4574a752bfcc497bac660098cf6 ]
then
	echo "PROBLEM! MD5SUM of download and actual file do not match! Danger!"
	exit 3
fi
su -c 'busybox dd if=/data/local/tmp/pwn/boot_nowallpaper.img of=/dev/block/mmcblk0p8 bs=4096'
echo "Done!"

su -c 'rm /system/etc/fota_post_boot_up.sh'
su -c 'rm /data/gpscfg/*'
su -c 'rm /system/etc/install-recovery.sh'
su -c 'rm /system/etc/recovery-from-boot.p'

touch /data/local/tmp/pwn/pwn_success
