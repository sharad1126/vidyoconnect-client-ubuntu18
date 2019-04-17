#!/bin/sh
# A uvd callable script to attempt uvd update installation.
# Tries to identify correct packaging tools and options to do upgrade install.
fuser -k 63457/tcp
case "$DESKTOP_SESSION" in
KDE*)
	sudo="kdesudo"
	;;
*)
	sudo=""
	;;
esac

if test ! -f "$*" ; then
	echo "*** no package specified" ; exit 2 ; fi

case "$*" in
*/*Vidyo*.deb)
	case "$DESKTOP_SESSION" in
	KDE*)
		pkgtools="gdebi-kde gdebi-gtk apper software-center"
		;;
	*)
		pkgtools="software-center"
		;;
	esac
	;;
*/*Vidyo*.rpm)
	case "$DESKTOP_SESSION" in
	KDE*)
		pkgtools="apper yast2 yum"
		;;
	*)
		pkgtools="yast2 yum"
		;;
	esac
	;;
*)
	echo "*** $*: unknown or invalid package"
	exit 2
	;;
esac

#if test ! -x /usr/bin/$sudo ; then
#	echo "*** no sudo support" ; exit 1 ; fi

for pkgtool in $pkgtools ; do
	if test -x /usr/bin/$pkgtool ; then
		case "$pkgtool" in
		yum)
			pkgopts="-q -y install"
			;;
		yast2)
			pkgopts="--install"
			;;
		*)
			pkgopts=""
			;;
		esac
		$sudo $pkgtool $pkgopts "$*" &
		exit 0
	fi
done
echo "*** no package tool" ; exit 1

	
