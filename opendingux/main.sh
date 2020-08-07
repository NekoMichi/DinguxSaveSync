#!/bin/sh
# title=SaveSync Main
# desc=Main menu of SaveSync
# author=NekoMichi

export APPVERSION="v2.2"

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

export SDPATH=$(findmnt -n --output=target /dev/mmcblk1p1 | head -1)
export INTPATH="/media/data/local/home"
export EXTPATH="$SDPATH/backup"

MODE=$(dialog --clear --backtitle "SaveSync $APPVERSION" --title "SaveSync" --menu "Please select an action. Use arrow keys to make your selection and press START to confirm." 15 35 5 \
1 "Backup" \
2 "Restore" \
3 "Sync" \
4 "Snapshots" \
5 "Advanced..." \
2>&1 >/dev/tty)

clear

if [ $MODE = "1" ]; then
	./backup.sh
fi
if [ $MODE = "2" ]; then
	./restore.sh
fi
if [ $MODE = "3" ]; then
	./sync.sh
fi
if [ $MODE = "4" ]; then
	./snapshots.sh
fi
if [ $MODE = "5" ]; then
	./extras.sh
fi

exit
