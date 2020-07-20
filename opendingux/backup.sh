#!/bin/sh
# title=Save Backup
# desc=Backup save data to external SD card
# author=NekoMichi

# INTPATH="/media/data/local/home/"
# EXTPATH="/media/sdcard/"

echo "===Backup Saves==="
# Checks to see if there is a card inserted in slot 2
if [ ! -d $EXTPATH ]; then
	echo "Could not detect secondary micro SD card."
	echo "Please make sure you have a secondary SD card inserted."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Checks to see if backup folder exists on card 2, if not then will create it
if [ ! -d $EXTPATH/backup/ ]; then
	echo "Backup folder doesn't exist, creating folder."
	mkdir $EXTPATH/backup
fi

# Overrides permissions on backup folder
chmod -R 777 $EXTPATH/backup

# Backs up screenshots
if [ -d $INTPATH/screenshots/ ]; then
	if [ ! -d $EXTPATH/backup/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/screenshots
	fi
	echo "Backing up screenshots"
	rsync -rt --ignore-existing $INTPATH/screenshots/ $EXTPATH/backup/screenshots
fi

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ ! -d $EXTPATH/backup/fceux/ ]; then
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/fceux
	fi
	echo "Backing up FCEUX data..."
	rsync -rt $INTPATH/.fceux/sav/ $EXTPATH/backup/fceux/sav
	rsync -rt $INTPATH/.fceux/fcs/ $EXTPATH/backup/fceux/fcs
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ ! -d $EXTPATH/backup/gambatte/ ]; then
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/gambatte
	fi
	echo "Backing up Gambatte data..."
	rsync -rt $INTPATH/.gambatte/saves/ $EXTPATH/backup/gambatte/saves
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ ! -d $EXTPATH/backup/gpsp/ ]; then
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/gpsp
	fi
	echo "Backing up ReGBA data..."
	rsync -rt $INTPATH/.gpsp/ $EXTPATH/backup/gpsp
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ ! -d $EXTPATH/backup/pcsx4all/ ]; then
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/pcsx4all
	fi
	echo "Backing up PCSX4all data..."
	rsync -rt $INTPATH/.pcsx4all/memcards/ $EXTPATH/backup/pcsx4all/memcards
	rsync -rt $INTPATH/.pcsx4all/sstates/ $EXTPATH/backup/pcsx4all/sstates
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ ! -d $EXTPATH/backup/picodrive/ ]; then
		echo "Picodrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/picodrive
	fi
	echo "Backing up PicoDrive data..."
	rsync -rt $INTPATH/.picodrive/mds/ $EXTPATH/backup/picodrive/mds
	rsync -rt $INTPATH/.picodrive/srm/ $EXTPATH/backup/picodrive/srm
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $EXTPATH/backup/snes96_snapshots/ ]; then
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/snes96_snapshots
	fi
	echo "Backing up SNES96 data..."
	rsync -rt $INTPATH/.snes96_snapshots/ $EXTPATH/backup/snes96_snapshots
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ ! -d $EXTPATH/backup/pocketsnes/ ]; then
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/pocketsnes
	fi
	echo "Backing up PocketSNES data..."
	rsync -rt $INTPATH/.pocketsnes/ $EXTPATH/backup/pocketsnes
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Backup Complete" --msgbox "Save backup complete. Press START to exit." 10 29
exit
