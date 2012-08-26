@echo off
cls

echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo
echo  TWRP 2.2.2.0 Automated Install    
echo	   Iconia Tab A100             
echo		by
echo	     Godmachine81               
echo
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


pause

echo This will install TWRP to your A100
echo This is only for the Acer A100 tab,
echo if you would like to continue with
echo installation on A100 then press Y
echo otherwise press N to abort

IF '%var%' == Y goto start
IF '%var%' == y goto start
IF '%var%' == N goto no
IF '%var%' == n goto no

:no
cls
echo You chose to abort installation
echo Exiting...
pause 
exit

:yes

cls
echo Installation started, installing TWRP to your A100

pause
echo Preparing adb... 

adb kill-server
adb root

echo Checking if stock recover script exists and moving if so
adb shell su -c "mount -o remount, rw /system/; mv /etc/install-recovery.sh /etc/install-recovery.offsh;"

echo

echo Rebooting to Bootloader
adb reboot bootloader
adb wait-for-device
echo

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
echo
echo Thanks for using the A100 Automated
echo Installation Script - Godmachine81

pause > null
