#!/bin/bash

profile() {
    echo "============= profile script version =================="
    echo 0.4
    echo
	echo "============= running uname -a ========================"
	uname -a
	echo 
	echo "============= running cat /proc/cpuinfo ==============="
	cat /proc/cpuinfo
	echo 
	echo "============= scanning memory info ===================="
	echo "--- system:"
	grep Total /proc/meminfo
	echo
	echo "--- video:"
	grep Memory /var/log/Xorg.*.log
	echo
	echo "============= running cat /etc/issue =================="
	cat /etc/issue
	echo 
	echo "============= getting session type ===================="
	echo ${DESKTOP_SESSION}
	echo
	echo "============= running glxinfo ========================="
	glxinfo
	echo 
	echo "============= running lspci ==========================="
	if [ -f /sbin/lspci ]; then
	/sbin/lspci
	else
	lspci
	fi
	echo 
	echo "============= running lsusb ==========================="
	if [ -f /sbin/lsusb ]; then
	/sbin/lsusb
	else
	lsusb
	fi
	echo 
	echo "============= running aplay -l ========================"
	aplay -l
	echo
	echo "============= running processes ======================="
	ps alx
}

rm -rf ~/.vidyo-temp
mkdir ~/.vidyo-temp
cd ~/.vidyo-temp

date=`date +%Y%m%d-%H%M%S`

cp /opt/vidyo/VidyoDesktop/VidyoDesktop .
cp /opt/vidyo/VidyoDesktop/core*.* .
cp /opt/vidyo/VidyoDesktop/core* .
cp ~/.vidyo/VidyoDesktop/*.log .
cp /var/log/Xorg.*.log .
if test -f /etc/X11/xorg.conf ; then
	cp /etc/X11/xorg.conf . ; fi
profile >system-profile.txt
echo "packing vidyo-debug-$date.tar.gz..."
if test -d ~/Desktop ; then
    tar -cvzf ~/Desktop/vidyo-debug-$date.tar.gz *
else
    tar -cvzf ~/vidyo-debug-$date.tar.gz *
fi
cd ~/
rm -rf ~/.vidyo-temp
exit 0

