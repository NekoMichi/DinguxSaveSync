#!/bin/sh
# title=Debug Save Restore
# desc=Debug restore save data from external SD card
# author=NekoMichi

echo "===Restore Saves (Test)==="

# Checks to see if there is a card inserted in slot 2
if [ ! -d $EXTPATH ]; then
	echo "Could not detect secondary micro SD card."
	echo "Please make sure you have a secondary SD card inserted."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Checks to see if backup folder exists on card 2
if [ ! -d $EXTPATH/backup/ ]; then
	echo "Backup folder not found on card-2."
	echo "Please make sure card-2 has backup data stored."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Overrides permissions on backup folder
chmod -R 777 $EXTPATH/backup

# Restores FCEUX data
if [ -d $EXTPATH/backup/fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
	fi
	echo "Restoring FCEUX data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/backup/fceux/sav/ $INTPATH/.fceux/sav
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/backup/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/backup/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
	fi
	echo "Restoring Gambatte data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/backup/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/backup/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/backup/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/backup/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
	fi
	echo "Restoring PCSX4all data..."
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/backup/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/backup/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/backup/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
	fi
	echo "Restoring PicoDrive data..."
	rsync -nvrtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/backup/picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -nvrtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/backup/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Backs up PocketSNES data
if [ -d $EXTPATH/backup/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	rsync -nvrtW --exclude '*.opt' $EXTPATH/backup/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/backup/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	rsync -nvrtW --exclude '*.opt' $EXTPATH/backup/pocketsnes/ $INTPATH/.pocketsnes
fi

echo ""
echo "Debug restore complete."
echo "Report saved to /media/sdcard/backup/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
