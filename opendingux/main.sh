#!/bin/sh
# title=SaveSync Main
# desc=Main menu of SaveSync
# author=NekoMichi

export APPVERSION="v1.4"
export INTPATH="/media/data/local/home/"
export EXTPATH="/media/sdcard/"

MODE=$(dialog --clear --backtitle "SaveSync $APPVERSION" --title "SaveSync" --menu "Please select an action. Use arrow keys to make your selection and press START to confirm." 15 35 4 \
1 "Backup" \
2 "Restore" \
3 "Sync" \
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

exit
