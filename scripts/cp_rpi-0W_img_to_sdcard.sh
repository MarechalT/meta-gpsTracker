#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)

usage="$(basename "$0") [-h] [-b d i p] == program to flash the yocto generated rpi image to the sdcard.

where:
	-b hardware/board used (rasberrypi, ${bold}raspberrypi0-wifi${normal}, raspberrypi3)
	-d drive to be flashed to (${bold}/dev/sdb${normal})
	-h show this help text
	-i image file to flash (core-image-base)
	-p path to the yocto deploy/images repository (${bold}tmp/deploy/images${normal})"

	IMGDIR="tmp/deploy/images"
        BOARD="raspberrypi0-wifi"
	IMGFILE="core-image-base-"
	DRIVE="/dev/sdb"

while getopts ':bdhip:' option; do
    case "$option" in
	h) echo "$usage"
	   exit
	   ;;
        b) BOARD=$OPTARG
	   ;;
	d) DRIVE=$OPTARG
	   ;;
   	i) IMGFILE=$OPTARG
	   ;;
	p) IMGDIR=$OPTARG
	   ;;
	:) printf "missing arg for -%s\n" "$OPTARG" >&2
	   echo "$usage" >&2
	   exit 1
	   ;;
    	\?) printf "illegal option : -%s\n" "$OPTARG" >&2
	    echo "$usage" >&2
 	    exit 1
	    ;;
    esac
done
shift $((OPTIND -1))

FILE=${IMGDIR}/${BOARD}/${IMGFILE}${BOARD}.rpi-sdimg
if [[ -f ${FILE} ]]; then
	echo "${FILE} exists."
	echo "Create blockmap image"
	rm ${FILE}.bmap
	bmaptool create ${FILE} > ${FILE}.bmap

	echo "SD card Drive : ${DRIVE}"
	if [ "${DRIVE}" == "/dev/sda" ]; then
		echo "Can't allow to flash to sda !";
		exit 1;
	fi
	if sudo df | grep -q "${DRIVE}" ; then
	        echo "Stopping the process, Drive ${DRIVE} already mounted" >&2
        	exit 1;
	else
	        echo "Drive unmounted. continue"
		sudo bmaptool copy ${FILE} ${DRIVE}
	fi
else
	echo "Couldn't find the file : ${FILE}" >&2
	exit 1;
fi
