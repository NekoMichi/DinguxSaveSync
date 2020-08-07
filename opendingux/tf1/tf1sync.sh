#!/bin/sh
# title=TF1 Save Sync
# desc=Syncs save data with a TF1 card
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
dialog --clear --title "Confirm Sync?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to sync saves? This will overwrite any duplicate saves with the newer version." 7 49

confirmexport=$?
clear

if [ $confirmexport = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Export Cancelled" --msgbox "Save export cancelled. No files were changed. Press START to exit." 7 29
	exit
fi

echo "===Syncing Saves==="

# Overrides permissions on backup folder
# chmod -R 777 $EXTPATH

PARTPATH=$(findmnt -n --output=target /dev/mmcblk1p2 | head -1)
EXTPATH="$PARTPATH/local/home"

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/.fceux/ ]; then
		echo "Syncing FCEUX data..."
		rsync --update -rtW $INTPATH/.fceux/sav/ $EXTPATH/.fceux/sav
		rsync --update -rtW $INTPATH/.fceux/fcs/ $EXTPATH/.fceux/fcs
		rsync --update -rtW $EXTPATH/.fceux/sav/ $INTPATH/.fceux/sav
		rsync --update -rtW $EXTPATH/.fceux/fcs/ $INTPATH/.fceux/fcs
	else
		echo "FCEUX folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.fceux
		mkdir $EXTPATH/.fceux/sav
		mkdir $EXTPATH/.fceux/fcs
		echo "Syncing FCEUX data..."
		rsync --update -rtW $INTPATH/.fceux/sav/ $EXTPATH/.fceux/sav
		rsync --update -rtW $INTPATH/.fceux/fcs/ $EXTPATH/.fceux/fcs
	fi
else
	if [ -d $EXTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		mkdir $INTPATH/.fceux/sav
		mkdir $INTPATH/.fceux/fcs
		echo "Syncing FCEUX data..."
		rsync --update -rtW $EXTPATH/.fceux/sav/ $INTPATH/.fceux/sav
		rsync --update -rtW $EXTPATH/.fceux/fcs/ $INTPATH/.fceux/fcs
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/.gambatte/ ]; then
		echo "Syncing Gambatte data..."
		rsync --update -rtW $INTPATH/.gambatte/saves/ $EXTPATH/.gambatte/saves
		rsync --update -rtW $EXTPATH/.gambatte/saves/ $INTPATH/.gambatte/saves
	else
		echo "Gambatte folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.gambatte
		mkdir $EXTPATH/.gambatte/saves
		echo "Syncing Gambatte data..."
		rsync --update -rtW $INTPATH/.gambatte/saves/ $EXTPATH/.gambatte/saves
	fi
else
	if [ -d $EXTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		mkdir $INTPATH/.gambatte/saves
		echo "Syncing Gambatte data..."
		rsync --update -rtW $EXTPATH/.gambatte/saves/ $INTPATH/.gambatte/saves
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/.gpsp/ ]; then
		echo "Syncing ReGBA data..."
		rsync --update -rtW --exclude '*.cfg' $INTPATH/.gpsp/ $EXTPATH/.gpsp
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/.gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtW --exclude '*.cfg' $INTPATH/.gpsp/ $EXTPATH/.gpsp
	fi
else
	if [ -d $EXTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/.gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/.pcsx4all/ ]; then
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $INTPATH/.pcsx4all/memcards/ $EXTPATH/.pcsx4all/memcards
		rsync --update -rtW $INTPATH/.pcsx4all/sstates/ $EXTPATH/.pcsx4all/sstates
		rsync --update -rtW $EXTPATH/.pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		rsync --update -rtW $EXTPATH/.pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	else
		echo "PCSX4all folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.pcsx4all
		mkdir $EXTPATH/.pcsx4all/memcards
		mkdir $EXTPATH/.pcsx4all/sstates
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $INTPATH/.pcsx4all/memcards/ $EXTPATH/.pcsx4all/memcards
		rsync --update -rtW $INTPATH/.pcsx4all/sstates/ $EXTPATH/.pcsx4all/sstates
	fi
else
	if [ -d $EXTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		mkdir $INTPATH/.pcsx4all/memcards
		mkdir $INTPATH/.pcsx4all/sstates
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $EXTPATH/.pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		rsync --update -rtW $EXTPATH/.pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/.picodrive/ ]; then
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $INTPATH/.picodrive/mds/ $EXTPATH/.picodrive/mds
		rsync --update -rtW $INTPATH/.picodrive/srm/ $EXTPATH/.picodrive/srm
		rsync --update -rtW $EXTPATH/.picodrive/mds/ $INTPATH/.picodrive/mds
		rsync --update -rtW $EXTPATH/.picodrive/srm/ $INTPATH/.picodrive/srm
	else
		echo "PicoDrive folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.picodrive
		mkdir $EXTPATH/.picodrive/mds
		mkdir $EXTPATH/.picodrive/srm
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $INTPATH/.picodrive/mds/ $EXTPATH/.picodrive/mds
		rsync --update -rtW $INTPATH/.picodrive/srm/ $EXTPATH/.picodrive/srm
	fi
else
	if [ -d $EXTPATH/.picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		mkdir $INTPATH/.picodrive/mds
		mkdir $INTPATH/.picodrive/srm
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $EXTPATH/.picodrive/mds/ $INTPATH/.picodrive/mds
		rsync --update -rtW $EXTPATH/.picodrive/srm/ $INTPATH/.picodrive/srm
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/.snes96_snapshots/ ]; then
		echo "Syncing SNES96 data..."
		rsync --update -rtW --exclude '*.opt' $INTPATH/.snes96_snapshots/ $EXTPATH/.snes96_snapshots
		rsync --update -rtW --exclude '*.opt' $EXTPATH/.snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtW --exclude '*.opt' $INTPATH/.snes96_snapshots/ $EXTPATH/.snes96_snapshots
	fi
else
	if [ -d $EXTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtW --exclude '*.opt' $EXTPATH/.snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/.pocketsnes/ ]; then
		echo "Syncing PocketSNES data..."
		rsync --update -rtW --exclude '*.opt' $INTPATH/.pocketsnes/ $EXTPATH/.pocketsnes
		rsync --update -rtW --exclude '*.opt' $EXTPATH/.pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES folder doesn't exist on destination device, creating folder."
		mkdir $EXTPATH/.pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtW --exclude '*.opt' $INTPATH/.pocketsnes/ $EXTPATH/.pocketsnes
	fi
else
	if [ -d $EXTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtW --exclude '*.opt' $EXTPATH/.pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Sync Complete" --msgbox "Save sync complete.\nPress START to exit." 6 29
exit
