#!/bin/sh
# title=Save Import
# desc=Import save data from external SD card
# author=NekoMichi

echo "===Card Check==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if the card in slot 2 has a system partition
if [ ! -b /dev/mmcblk1p2 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Invalid SD Card" --msgbox "The card in slot-2 is not a valid OpenDingux formatted card.\n\nPress START to exit." 9 31
	exit
fi

PARTPATH=$(findmnt -n --output=target /dev/mmcblk1p2 | head -1)
EXTPATH="$PARTPATH/local/home"

# Checks to see if the card in slot 2 has a system partition
if [ ! -d $EXTPATH ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Invalid SD Card" --msgbox "The card in slot-2 is not a valid OpenDingux formatted card.\n\nPress START to exit." 9 31
	exit
fi

echo "Valid OpenDingux card detected in slot 2."

# Displays a confirmation dialog
dialog --clear --title "Confirm Import?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to import saves? This will overwrite any existing saves on this current device." 7 49

confirmexport=$?
clear

if [ $confirmexport = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Import Cancelled" --msgbox "Save import cancelled. No files were changed. Press START to exit." 7 29
	exit
fi

echo "===Importing Saves==="

# Overrides permissions on backup folder
# chmod -R 777 $EXTPATH

PARTPATH=$(findmnt -n --output=target /dev/mmcblk1p2 | head -1)
EXTPATH="$PARTPATH/local/home"

# Imports FCEUX data
if [ -d $EXTPATH/.fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
	fi
	echo "Importing FCEUX data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/.fceux/sav/ $INTPATH/.fceux/sav
	rsync -rtW --exclude '*.cfg' $EXTPATH/.fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Imports Gambatte data
if [ -d $EXTPATH/.gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
	fi
	echo "Importing Gambatte data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/.gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Imports ReGBA data
if [ -d $EXTPATH/.gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Importing ReGBA data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/.gpsp/ $INTPATH/.gpsp
fi

# Imports PCSX4all data
if [ -d $EXTPATH/.pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
	fi
	echo "Importing PCSX4all data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/.pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -rtW --exclude '*.cfg' $EXTPATH/.pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Imports Picodrive data
if [ -d $EXTPATH/.picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
	fi
	echo "Importing PicoDrive data..."
	rsync -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/.picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/.picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Importing PocketSNES data
if [ -d $EXTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Importing SNES96 data..."
	rsync -rtW --exclude '*.opt' $EXTPATH/.snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/.pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Importing PocketSNES data..."
	rsync -rtW --exclude '*.opt' $EXTPATH/.pocketsnes/ $INTPATH/.pocketsnes
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Import Complete" --msgbox "Save import complete.\nPress START to exit." 6 29
exit
