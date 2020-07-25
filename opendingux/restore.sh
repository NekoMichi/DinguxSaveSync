#!/bin/sh
# title=Save Restore
# desc=Restore save data from external SD card
# author=NekoMichi

# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if backup folder exists on card 2
if [ ! -d $EXTPATH/ ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No Backup Found" --msgbox "No backup data found on the SD card.\n\nPress START to exit." 8 29
	exit
fi

# Displays a confirmation dialog
dialog --clear --title "Confirm Restore?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to restore saves from backup? Any existing saves on this system will be overwritten." 7 49

confirmrestore=$?
clear

if [ $confirmrestore = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Cancelled" --msgbox "Save restore cancelled. No files were changed. Press START to exit." 10 29
	exit
fi

echo "===Restoring Saves==="

# Overrides permissions on backup folder
chmod -R 777 $EXTPATH

# Restores FCEUX data
if [ -d $EXTPATH/fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
	fi
	echo "Restoring FCEUX data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
	rsync -rtW --exclude '*.cfg' $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
	fi
	echo "Restoring Gambatte data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
	fi
	echo "Restoring PCSX4all data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -rtW --exclude '*.cfg' $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
	fi
	echo "Restoring PicoDrive data..."
	rsync -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Backs up PocketSNES data
if [ -d $EXTPATH/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	rsync -rtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	rsync -rtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Complete" --msgbox "Save restore complete.\nPress START to exit." 6 29
exit
