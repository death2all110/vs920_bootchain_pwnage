@echo off
cd "%~dp0"
color 02
TITLE LG VS920 Bootloader Pwnage Tool
echo [*] Method by: Neph81, Script by death2all110
pause
echo [*]
echo [*] ======================================================================
echo [*] ======================Bootloader Pwnage Tool==========================
echo [*] =========================Method By: Neph81============================
echo [*] ======================Script By:death2all110==========================
echo [*] ==============Special Thanks To: tdm, jcase, PlayfulGod===============
echo [*]
echo [*]   Make sure that USB Debugging is enabled,all drivers are installed,
echo [*]        and that USB Internet Connection is selected in usb mode
echo [*]
echo [*] ======================================================================
pause
:DISCLAIMER
echo [*] ==============================Disclaimer==============================
echo [*]
echo [*]  /*
echo [*]   * Your warranty is now void.
echo [*]   *
echo [*]   * Neither Neph81, PlayfulGod, tdm, I, Jcase, nor anyone else
echo [*]   * in the LG Spectrum Development Community are responsible for 
echo [*]   * bricked devices, dead SD cards, thermonuclear war, global warming, 
echo [*]   * your GPS failing, spilling coffee on your work shirt, car problems, 
echo [*]   * technical difficulties, or you getting fired because the alarm app 
echo [*]   * failed. 
echo [*]   *
echo [*]   * YOU are choosing to make these modifications, and if you point the
echo [*]   * finger at me, or anyone else for messing up your device, I will
echo [*]   * point and laugh at you for your own damn stupidity.
echo [*]   *
echo [*]   * UNDERSTOOD? Good. Now please continue....
echo [*]   *
echo [*]   */
echo [*]
echo [*] ======================================================================
echo [*] Do you understand and agree to the Disclaimer?
echo [*]
echo [*] Y (Yes)
echo [*] N (No)
echo [*]
SET /P M=Make a selection then press ENTER:
IF %M%==Y GOTO MENU
IF %M%==y GOTO MENU
IF %M%==N GOTO BYE
IF %M%==n GOTO BYE

:MENU
pause
echo [*] Before continuing lets verify we have root ...
echo [*]
echo [*] Are you already rooted?
echo [*] Y (Yes)
echo [*] N (No)
echo [*] X (Exit!)
echo [*]
SET /P M=Make a selection then press ENTER:
IF %M%==Y GOTO BOOTLOADER
IF %M%==y GOTO BOOTLOADER
IF %M%==N GOTO ROOT
IF %M%==n GOTO ROOT
IF %M%==X GOTO BYE
IF %M%==x GOTO BYE

:ROOT
echo [*] You are now leaving this tool....
echo [*] Credits to Jcase for the exploit, PlayfulGod for the script.
echo [*]
call PG_ICS_ROOT\window-install.bat

:BOOTLOADER
setlocal ENABLEDELAYEDEXPANSION
echo [*]
cd stuff/
echo [*] Preparing to check md5 sums...
pause
echo [*]
echo [*] Checking MD5 Sums...
for /f %%f in ('dir "*.md5" /s/b') do (
	set file=%%f
	for /f %%a in ('type "!file!"') do (
		set md5=%%a
		set md5=!md5:"=!
		set file=!file:~,-4!
		for /f "skip=3" %%b in ('fciv "!file!"') do (
			if [!md5!]==[%%b] (
				echo [*] PASS: !file!
				echo [*] MD5: !md5! vs. %%b
				echo [*] md5 check passed > md5_pass.txt
				echo [*]
			) else (
				echo [*] !!! FAIL: !file!
				echo [*] MD5: !md5! vs. %%b
				echo [*] md5 check failed > md5_fail.txt
			)
		)
	)
)
echo [*]
echo [*] Checking if 1st stage MD5 Check passed.....
if exist md5_pass.txt (GOTO CONTINUE) ELSE IF EXIST md5_fail.txt GOTO ERR_VERIFY

:CONTINUE
echo [*] Sucess^^! MD5 Check Passed^^!
del md5_pass.txt
adb kill-server
adb wait-for-device
echo [*] Device found ^^!
echo [*] Pushing Files...
adb shell "mkdir /data/local/tmp/pwn"
adb push %cd%\pwn /data/local/tmp/pwn
adb push pwnage.sh /data/local/tmp/pwn/pwnage.sh
cd ..
echo [*] Remounting /system....
adb shell "su -c 'mount -o rw,remount /dev/block/mmcblk0p26 /system'"
adb shell "sh /data/local/tmp/pwn/pwnage.sh"
adb pull /data/local/tmp/pwn/pwn_success
if exist pwn_success (GOTO CLEAN) else GOTO ERR_GEN

:ERR_VERIFY
del md5_fail.txt
echo [*] Failed to verify md5 sums. Please re-download this package and try again.
pause
GOTO MENU

:ERR_GEN
echo [*] Fatal generic error! This can occur for 1 of 2 reasons:
echo [*]
echo [*] 1.) Either you exited the md5check.sh script prematurely, 
echo [*] 2.) Or MD5 check on device failed!
echo [*]
echo [*] Please try again!
pause

:CLEAN
echo [*] Cleaning up....
echo [*]
adb shell "busybox rm -rf /data/local/tmp/pwn"
del pwn_success
echo [*]
echo [*] All done!
pause
GOTO BYE

:BYE
cls
echo [*] Bootloader Pwnage Tool
echo [*] =========By: Neph81=========
echo [*] Script By: death2all110
echo [*] 
echo [*] Special thanks to TDM, Jcase, PlayfulGod.
echo [*]
echo [*] Hope you enjoyed! If you would like to 
echo [*] donate, follow the link in my signature!
echo [*] 
echo [*] © Copyright Spectrumhackers 2012
pause >NUL
exit
