#!/bin/bash
#Acer A100 TWRP Recovery installer script for Linux
#By godmachine81 <Lance Poore  linuxsociety@gmail.com >



#Make sure that the recovery.img is in the correct location before continuing script
#if so continue script, if not skip to else statement to exit 1
if [ -f ./recovery.img ];then

#Prompt user for input of Y or y to make sure they want to flash TWRP recovery
read -p "Are you sure you want to flash TWRP to your A100: Press Y to continue   " -n 1 -r
	if [[ ! $REPLY =~ ^[Yy]$  ]] 
	then
		echo
		#If user didn't press Y or y then lets exit the script
		echo "You chose to not continue installation, Exiting"
		exit 1
	fi

#lets be sure that permissions are set properly on the files needed to run the script
chmod +x ./adb 
chmod +x ./fastboot
	
#Restart the adb server as root in case there are conflicting instances running
echo
echo "Restarting the adb server as root"
./adb kill-server
./adb root
echo "ADB restarted"


#Wait for a connection to the device before proceeding
echo
echo
echo "Please connect your A100 to the USB connection on your PC"
sleep 1
echo "Waiting for device connection"	
./adb wait-for-device
echo "Device Found....."

#Move the install-recovery.sh script to prevent OEM recovery installation
echo "Disabling the default install-recovery script on device if present"
./adb shell su -c "mount -o remount, rw /system/ && mv /etc/install-recovery.sh /etc/install-recovery.offsh;"
echo
echo "If output above read 'failed no such file/directory' don't be alarmed - this is normal, script will continue"


#Reboot to bootloader mode on the device 
./adb reboot bootloader
echo
echo "Rebooting Bootloader"
sleep 5

#Now Flash the recovery.img to the A100
echo "Flashing recovery.img - DO NOT DISCONNECT YOUR DEVICE!!" 
./fastboot flash recovery ./recovery.img
echo
sleep 1

#After flashing reboot the device
echo "Flash complete. Rebooting to Recovery"
./fastboot reboot

#Let android boot in a normal fasion until adb recognizes device
echo "Please Wait while we prepare to reboot into recovery"
./adb wait-for-device
echo

#After acknowledgment send the signal to reboot to recovery
echo "Device acknowledged, triggering reboot to recovery"
./adb reboot recovery
sleep 5;

#All done lets exit the script and take a look at the screen of the tab, should be in recovery
echo "Finished..Your device should now boot to TWRP Recovery" 
exit 0
	
	#In case someone messes up extracting the zip file and contents lets not try to continue the script, recovery.img missing
	else
		echo "Please ensure that recovery.img is in the same directory you are running this script from "
	exit 1
fi


