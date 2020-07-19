#!/bin/sh
# title=Save Backup
# desc=Backup save data to external SD card
# author=NekoMichi

INTPATH="/media/data/local/home/"
EXTPATH="/media/sdcard/"

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
chmod -R 777 $EXTPATH/backup

# Backs up GMenu2x data
# if [ ! -d $EXTPATH/backup/gmenu2x/ ]; then
#	echo "Gmenu2x backup folder doesn't exist, creating folder."
#	mkdir $EXTPATH/backup/gmenu2x
# fi
# echo "Backing up Gmenu2x data..."
# rsync --update -rt $INTPATH/.gmenu2x/ $EXTPATH/backup/gmenu2x

# Backs up screenshots
if [ -d $INTPATH/screenshots/ ]; then
	if [ ! -d $EXTPATH/backup/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/screenshots
	fi
	echo "Backing up screenshots"
	rsync --update -rt $INTPATH/screenshots/ $EXTPATH/backup/screenshots
fi

# Backs up scripts
# if [ -d $INTPATH/.scriptrunner/ ]; then
#	if [ ! -d $EXTPATH/backup/scriptrunner/ ]; then
#		echo "Scripts backup folder doesn't exist, creating folder."
#		mkdir $EXTPATH/backup/scriptrunner
#	fi
#	echo "Backing up scripts"
#	rsync --update -rt $INTPATH/.scriptrunner/ $EXTPATH/backup/scriptrunner
# fi

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ ! -d $EXTPATH/backup/fceux/ ]; then
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/fceux
	fi
	echo "Backing up FCEUX data..."
	rsync --update -rt $INTPATH/.fceux/ $EXTPATH/backup/fceux
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ ! -d $EXTPATH/backup/gambatte/ ]; then
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/gambatte
	fi
	echo "Backing up Gambatte data..."
	rsync --update -rt $INTPATH/.gambatte/ $EXTPATH/backup/gambatte
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ ! -d $EXTPATH/backup/gpsp/ ]; then
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/gpsp
	fi
	echo "Backing up ReGBA data..."
	rsync --update -rt $INTPATH/.gpsp/ $EXTPATH/backup/gpsp
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ ! -d $EXTPATH/backup/pcsx4all/ ]; then
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/pcsx4all
	fi
	echo "Backing up PCSX4all data..."
	rsync --update -rt $INTPATH/.pcsx4all/ $EXTPATH/backup/pcsx4all
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ ! -d $EXTPATH/backup/picodrive/ ]; then
		echo "Picodrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/picodrive
	fi
	echo "Backing up PicoDrive data..."
	rsync --update -rt $INTPATH/.picodrive/ $EXTPATH/backup/picodrive
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $EXTPATH/backup/snes96_snapshots/ ]; then
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/snes96_snapshots
	fi
	echo "Backing up SNES96 data..."
	rsync --update -rt $INTPATH/.snes96_snapshots/ $EXTPATH/backup/snes96_snapshots
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ ! -d $EXTPATH/backup/pocketsnes/ ]; then
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/backup/pocketsnes
	fi
	echo "Backing up PocketSNES data..."
	rsync --update -rt $INTPATH/.pocketsnes/ $EXTPATH/backup/pocketsnes
fi

dialog --clear --backtitle "SaveSync v1.2" --title "Backup Complete" --msgbox "Save backup complete. Press START to exit." 10 30
exit
