#!/bin/sh
# title=Save Sync
# desc=Syncs save data with external SD card
# author=NekoMichi

echo "===Sync Saves==="
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
if [ -d /media/data/local/home/screenshots/ ]; then
	if [ ! -d $EXTPATH/backup/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/screenshots
	fi
	echo "Backing up screenshots"
	rsync -rtW --ignore-existing $INTPATH/screenshots/ $EXTPATH/backup/screenshots
fi

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/backup/fceux/ ]; then
		echo "Syncing FCEUX data..."
		rsync --update -rtW $INTPATH/.fceux/ $EXTPATH/backup/fceux
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/fceux/ $INTPATH/.fceux
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/fceux
		echo "Syncing FCEUX data..."
		rsync --update -rtW $INTPATH/.fceux/ $EXTPATH/backup/fceux
	fi
else
	if [ -d $EXTPATH/backup/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		echo "Syncing FCEUX data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/fceux/ $INTPATH/.fceux
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/backup/gambatte/ ]; then
		echo "Syncing Gambatte data..."
		rsync --update -rtW $INTPATH/.gambatte/ $EXTPATH/backup/gambatte
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/gambatte/ $INTPATH/.gambatte
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/gambatte
		echo "Syncing Gambatte data..."
		rsync --update -rtW $INTPATH/.gambatte/ $EXTPATH/backup/gambatte
	fi
else
	if [ -d $EXTPATH/backup/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		echo "Syncing Gambatte data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/gambatte/ $INTPATH/.gambatte
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/backup/gpsp/ ]; then
		echo "Syncing ReGBA data..."
		rsync --update -rtW $INTPATH/.gpsp/ $EXTPATH/backup/gpsp
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtW $INTPATH/.gpsp/ $EXTPATH/backup/gpsp
	fi
else
	if [ -d $EXTPATH/backup/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/backup/pcsx4all/ ]; then
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $INTPATH/.pcsx4all/ $EXTPATH/backup/pcsx4all
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/pcsx4all/ $INTPATH/.pcsx4all
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/pcsx4all
		echo "Syncing PCSX4all data..."
		rsync --update -rtW $INTPATH/.pcsx4all/ $EXTPATH/backup/pcsx4all
	fi
else
	if [ -d $EXTPATH/backup/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		echo "Syncing PCSX4all data..."
		rsync --update -rtW --exclude '*.cfg' $EXTPATH/backup/pcsx4all/ $INTPATH/.pcsx4all
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/backup/picodrive/ ]; then
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $INTPATH/.picodrive/ $EXTPATH/backup/picodrive
		rsync --update -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/backup/picodrive/ $INTPATH/.picodrive
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/picodrive
		echo "Syncing PicoDrive data..."
		rsync --update -rtW $INTPATH/.picodrive/ $EXTPATH/backup/picodrive
	fi
else
	if [ -d $EXTPATH/backup/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		echo "Syncing PicoDrive data..."
		rsync --update -rtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/backup/picodrive/ $INTPATH/.picodrive
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/backup/snes96_snapshots/ ]; then
		echo "Syncing SNES96 data..."
		rsync --update -rtW $INTPATH/.snes96_snapshots/ $EXTPATH/backup/snes96_snapshots
		rsync --update -rtW --exclude '*.opt' $EXTPATH/backup/snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtW $INTPATH/.snes96_snapshots/ $EXTPATH/backup/snes96_snapshots
	fi
else
	if [ -d $EXTPATH/backup/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtW --exclude '*.opt' $EXTPATH/backup/snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/backup/pocketsnes/ ]; then
		echo "Syncing PocketSNES data..."
		rsync --update -rtW $INTPATH/.pocketsnes/ $EXTPATH/backup/pocketsnes
		rsync --update -rtW --exclude '*.opt' $EXTPATH/backup/pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtW $INTPATH/.pocketsnes/ $EXTPATH/backup/pocketsnes
	fi
else
	if [ -d $EXTPATH/backup/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtW --exclude '*.opt' $EXTPATH/backup/pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Sync Complete" --msgbox "Save sync complete. Press START to exit." 10 29
exit
