#!/bin/sh
# title=TF1 Check
# desc=Checks to see if the card in slot 2 is valid
# author=NekoMichi

echo "===Card Check==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if the card in slot 2 has a system partition
if [ ! -b /dev/mmcblk1p2 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Invalid SD Card" --msgbox "The card in slot-2 is not a valid OpenDingux formatted card.\n\nPress START to exit." 9 31
	exit
fi

PARTPATH=$(findmnt -n --output=target /dev/mmcblk1p2 | head -1)
EXTPATH="$PARTPATH/local/home"

# Checks to see if the card in slot 2 has a system partition
if [ ! -d $EXTPATH ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Invalid SD Card" --msgbox "The card in slot-2 is not a valid OpenDingux formatted card.\n\nPress START to exit." 9 31
	exit
fi

# Debug message
dialog --clear --backtitle "SaveSync $APPVERSION" --title "Debug Message" --msgbox "PARTPATH\n$PARTPATH\n\nEXTPATH\n$EXTPATH" 9 35

# dialog --clear --backtitle "SaveSync $APPVERSION" --title "Found Home Folder" --msgbox "$EXTPATH\n\nPress START to exit." 9 31

exit
