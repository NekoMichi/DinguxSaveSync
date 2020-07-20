#!/bin/sh
# title=Save Restore
# desc=Restore save data from external SD card
# author=NekoMichi

# Displays a confirmation dialog
dialog --clear --title "Confirm Restore?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to restore saves from backup? Any existing saves on this system will be overwritten." 10 49

confirmrestore=$?
clear

if [ $confirmrestore = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Cancelled" --msgbox "Save restore cancelled. No files were changed. Press START to exit." 10 29
	exit
fi

# INTPATH="/media/data/local/home/"
# EXTPATH="/media/sdcard/"

echo "===Restore Saves==="

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
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/fceux/sav/ $INTPATH/.fceux/sav
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/backup/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
	fi
	echo "Restoring Gambatte data..."
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/backup/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/backup/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
	fi
	echo "Restoring PCSX4all data..."
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/backup/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
	fi
	echo "Restoring PicoDrive data..."
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -rt --exclude '*.cfg' $EXTPATH/backup/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Backs up PocketSNES data
if [ -d $EXTPATH/backup/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	rsync -rt --exclude '*.opt' $EXTPATH/backup/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/backup/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Backing up PocketSNES data..."
	rsync -rt --exclude '*.opt' $EXTPATH/backup/pocketsnes/ $INTPATH/.pocketsnes
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Complete" --msgbox "Save restore complete. Press START to exit." 10 29
exit
