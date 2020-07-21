#!/bin/sh
# title=SaveSync Main
# desc=Main menu of SaveSync
# author=NekoMichi

# Checks to see if backup folder exists on card 2, if not then will create it
if [ ! -d $EXTPATH/backup/ ]; then
	mkdir $EXTPATH/backup
	mkdir $EXTPATH/backup/log
fi

# Checks to see if log folder exists on card 2, if not then will create it
if [ ! -d $EXTPATH/backup/log/ ]; then
	mkdir $EXTPATH/backup/log
fi

MODE=$(dialog --clear --backtitle "SaveSync $APPVERSION" --title "SaveSync - Advanced" --menu "Please select an action. Use arrow keys to make your selection and press START to confirm." 15 35 4 \
1 "Debug backup" \
2 "Debug restore" \
3 "Debug sync" \
2>&1 >/dev/tty)

clear

if [ $MODE = "1" ]; then
	export TIMESTAMP=$(date +%y-%m-%d_%H-%M-%S)_testbackup
	./debug/drybackup.sh | tee $EXTPATH/backup/log/$TIMESTAMP.txt
fi
if [ $MODE = "2" ]; then
	export TIMESTAMP=$(date +%y-%m-%d_%H-%M-%S)_testrestore
	./debug/dryrestore.sh | tee $EXTPATH/backup/log/$TIMESTAMP.txt
fi
if [ $MODE = "3" ]; then
	export TIMESTAMP=$(date +%y-%m-%d_%H-%M-%S)_testsync
	./debug/drysync.sh | tee $EXTPATH/backup/log/$TIMESTAMP.txt
fi

exit
