#!/bin/sh
# title=SaveSync Main
# desc=Main menu of SaveSync
# author=NekoMichi

# Create log folder if needed
if [ ! -d ~/log/ ]; then
	mkdir ~/log
fi

# Display menu
MODE=$(dialog --clear --backtitle "SaveSync $APPVERSION" --title "SaveSync - Advanced" --menu "Please select an action. Use arrow keys to make your selection and press START to confirm." 18 35 7 \
1 "Debug backup" \
2 "Debug restore" \
3 "Debug sync" \
4 "Export" \
5 "Import" \
6 "Direct sync" \
7 "Compare" \
2>&1 >/dev/tty)

clear

if [ $MODE = "1" ]; then
	export TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)_testbackup
	./debug/drybackup.sh 2>&1 | tee ~/log/$TIMESTAMP.txt
fi
if [ $MODE = "2" ]; then
	export TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)_testrestore
	./debug/dryrestore.sh 2>&1 | tee ~/log/$TIMESTAMP.txt
fi
if [ $MODE = "3" ]; then
	export TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)_testsync
	./debug/drysync.sh 2>&1 | tee ~/log/$TIMESTAMP.txt
fi
if [ $MODE = "4" ]; then
	./tf1/tf1backup.sh
fi
if [ $MODE = "5" ]; then
	./tf1/tf1restore.sh
fi
if [ $MODE = "6" ]; then
	./tf1/tf1sync.sh
fi
if [ $MODE = "7" ]; then
	export TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)_diff
	./tf1/tf1diff.sh 2>&1 | tee ~/log/$TIMESTAMP.txt
fi

exit
