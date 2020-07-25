#!/bin/sh
# title=Save Backup
# desc=Backup save data to external SD card
# author=NekoMichi

echo "===Backing Up Saves==="

# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if backup folder exists on card 2, if not then will create it
if [ ! -d $EXTPATH/ ]; then
	echo "Backup folder doesn't exist, creating folder."
	mkdir $EXTPATH
fi

# Overrides permissions on backup folder
chmod -R 777 $EXTPATH

# Backs up screenshots
if [ -d $INTPATH/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Backing up screenshots..."
	rsync -rtW --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ ! -d $EXTPATH/fceux/ ]; then
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/fceux
	fi
	echo "Backing up FCEUX data..."
	rsync -rtW $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
	rsync -rtW $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ ! -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gambatte
	fi
	echo "Backing up Gambatte data..."
	rsync -rtW $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ ! -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
	fi
	echo "Backing up ReGBA data..."
	rsync -rtW $INTPATH/.gpsp/ $EXTPATH/gpsp
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ ! -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pcsx4all
	fi
	echo "Backing up PCSX4all data..."
	rsync -rtW $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
	rsync -rtW $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ ! -d $EXTPATH/picodrive/ ]; then
		echo "Picodrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/picodrive
	fi
	echo "Backing up PicoDrive data..."
	rsync -rtW $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
	rsync -rtW $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
	fi
	echo "Backing up SNES96 data..."
	rsync -rtW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ ! -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
	fi
	echo "Backing up PocketSNES data..."
	rsync -rtW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Backup Complete" --msgbox "Save backup complete.\nPress START to exit." 6 29
exit
