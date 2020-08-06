#!/bin/sh
# title=Debug Save Restore
# desc=Debug restore save data from external SD card
# author=NekoMichi

echo "===Restore Saves (Test)==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	echo "Could not detect secondary micro SD card."
	echo "Please make sure you have a secondary SD card inserted."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Checks to see if backup folder exists on card 2
if [ ! -d $EXTPATH/ ]; then
	echo "Backup folder not found on card-2."
	echo "Please make sure card-2 has backup data stored."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Overrides permissions on backup folder
chmod -R 777 $EXTPATH/backup

# Restores FCEUX data
if [ -d $EXTPATH/fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
	fi
	echo "Restoring FCEUX data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
	fi
	echo "Restoring Gambatte data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
	fi
	echo "Restoring PCSX4all data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
	fi
	echo "Restoring PicoDrive data..."
	rsync -nvrtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -nvrtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Backs up PocketSNES data
if [ -d $EXTPATH/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	rsync -nvrtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	rsync -nvrtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
fi

echo ""
echo "Debug restore complete."
echo "Report saved to /media/sdcard/backup/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
