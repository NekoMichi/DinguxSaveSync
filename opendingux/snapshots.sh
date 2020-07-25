#!/bin/sh
# title=SaveSync Snapshots
# desc=Snapshots menu of SaveSync
# author=NekoMichi

MODE=$(dialog --clear --backtitle "SaveSync $APPVERSION" --title "SaveSync - Snapshots" --menu "Please select an action. Use arrow keys to make your selection and press START to confirm." 13 35 3 \
1 "Create" \
2 "Load" \
3 "Delete" \
2>&1 >/dev/tty)

clear

if [ $MODE = "1" ]; then
	./snapshots/snapshotcreate.sh
fi
if [ $MODE = "2" ]; then
	./snapshots/snapshotload.sh
fi
if [ $MODE = "3" ]; then
	./snapshots/snapshotdelete.sh
fi

exit
