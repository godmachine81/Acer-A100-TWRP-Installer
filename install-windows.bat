@echo off
cls
echo ------------------------------------
echo.
echo  TWRP 2.2.2.0 Automated Install    
echo        Iconia Tab A100             
echo              by
echo         Godmachine81               
echo.
echo ------------------------------------

set /P ANSWER= Continue Flashing TWRP to your Acer A100 (Y/N)? 
if /i {%ANSWER%}== {y} (goto:yes)
if /i {%ANSWER%}== {yes} (goto:yes)
goto:no

:no
cls
@echo off
echo You Aborted Installation
pause
exit

:yes
cls
echo Installation started, installing TWRP to your A100


echo Preparing adb... 

adb kill-server
adb root

echo Checking if stock recover script exists and moving if so
adb shell su -c "mount -o remount, rw /system/; mv /etc/install-recovery.sh /etc/install-recovery.offsh;"

echo.

echo Rebooting to Bootloader
adb reboot bootloader
adb wait-for-device
echo.

echo Preparing to Flash
fastboot flash recovery recovery.img 
echo Recovery flashed, rebooting
fastboot reboot 
echo Waiting for adb connection...
adb wait-for-device 
echo Device Ready, rebooting into recovery
adb reboot recovery 
cls
echo Your device should now boot into TWRP
echo please give your device a minute to 
echo reboot and boot to recovery.
echo.
echo Thanks for using the A100 Automated
echo Installation Script - Godmachine81

pause>nul
