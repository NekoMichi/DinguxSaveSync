#!/bin/sh
# title=Save Sync
# desc=Syncs save data with external SD card
# author=NekoMichi

echo "===Syncing Saves==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
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
if [ -d /media/data/local/home/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Backing up screenshots..."
	rsync -rtW --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/fceux/ ]; then
		echo "Syncing FCEUX data..."
		rsync --update -rtW $INTPATH/.fceux/ $EXTPATH/fceux
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/fceux/ $INTPATH/.fceux
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/fceux
		echo "Syncing FCEUX data..."
		rsync --update -rtW $INTPATH/.fceux/ $EXTPATH/fceux
	fi
else
	if [ -d $EXTPATH/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		echo "Syncing FCEUX data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/fceux/ $INTPATH/.fceux
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Syncing Gambatte data..."
		rsync --update -rtW $INTPATH/.gambatte/ $EXTPATH/gambatte
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/gambatte/ $INTPATH/.gambatte
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gambatte
		echo "Syncing Gambatte data..."
		rsync --update -rtW $INTPATH/.gambatte/ $EXTPATH/gambatte
	fi
else
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		echo "Syncing Gambatte data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/gambatte/ $INTPATH/.gambatte
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "Syncing ReGBA data..."
		rsync --update -rtW $INTPATH/.gpsp/ $EXTPATH/gpsp
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtW $INTPATH/.gpsp/ $EXTPATH/gpsp
	fi
else
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $INTPATH/.pcsx4all/ $EXTPATH/pcsx4all
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/pcsx4all/ $INTPATH/.pcsx4all
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pcsx4all
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $INTPATH/.pcsx4all/ $EXTPATH/pcsx4all
	fi
else
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		echo "Syncing PCSX4all data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/pcsx4all/ $INTPATH/.pcsx4all
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $INTPATH/.picodrive/ $EXTPATH/picodrive
		rsync --update -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/ $INTPATH/.picodrive
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/picodrive
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $INTPATH/.picodrive/ $EXTPATH/picodrive
	fi
else
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		echo "Syncing PicoDrive data..."
		rsync --update -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/ $INTPATH/.picodrive
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "Syncing SNES96 data..."
		rsync --update -rtW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
		rsync --update -rtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
	fi
else
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "Syncing PocketSNES data..."
		rsync --update -rtW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
		rsync --update -rtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
	fi
else
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Sync Complete" --msgbox "Save sync complete.\nPress START to exit." 6 29
exit
