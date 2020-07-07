#!/bin/sh
# title=Save Backup
# desc=Backup save data to external SD card
# author=NekoMichi

echo "===Backup Saves==="
# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard/ ]; then
	echo "Could not detect secondary micro SD card."
	echo "Please make sure you have a secondary SD card inserted."
	echo ""
	read -p "Press START to exit"
	exit
fi

# Checks to see if backup folder exists on card 2, if not then will create it
if [ ! -d /media/sdcard/backup/ ]; then
	echo "Backup folder doesn't exist, creating folder"
	mkdir /media/sdcard/backup
fi

# Backs up GMenu2x data
if [ ! -d /media/sdcard/backup/gmenu2x/ ]; then
	echo "Gmenu2x backup folder doesn't exist, creating folder"
	mkdir /media/sdcard/backup/gmenu2x
fi
echo "Backing up Gmenu2x data"
rsync --update -rt /media/data/local/home/.gmenu2x/ /media/sdcard/backup/gmenu2x

# Backs up screenshots
if [ -d /media/data/local/home/screenshots/ ]; then
	if [ ! -d /media/sdcard/backup/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/screenshots
	fi
	echo "Backing up screenshots"
	rsync --update -rt /media/data/local/home/screenshots/ /media/sdcard/backup/screenshots
fi

# Backs up scripts
if [ -d /media/data/local/home/.scriptrunner/ ]; then
	if [ ! -d /media/sdcard/backup/scriptrunner/ ]; then
		echo "Scripts backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/scriptrunner
	fi
	echo "Backing up scripts"
	rsync --update -rt /media/data/local/home/.scriptrunner/ /media/sdcard/backup/scriptrunner
fi

# Backs up FCEUX data
if [ -d /media/data/local/home/.fceux/ ]; then
	if [ ! -d /media/sdcard/backup/fceux/ ]; then
		echo "FCEUX backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/fceux
	fi
	echo "Backing up FCEUX data"
	rsync --update -rt /media/data/local/home/.fceux/ /media/sdcard/backup/fceux
fi

# Backs up Gambatte data
if [ -d /media/data/local/home/.gambatte/ ]; then
	if [ ! -d /media/sdcard/backup/gambatte/ ]; then
		echo "Gambatte backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/gambatte
	fi
	echo "Backing up Gambatte data"
	rsync --update -rt /media/data/local/home/.gambatte/ /media/sdcard/backup/gambatte
fi

# Backs up ReGBA data
if [ -d /media/data/local/home/.gpsp/ ]; then
	if [ ! -d /media/sdcard/backup/gpsp/ ]; then
		echo "ReGBA backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/gpsp
	fi
	echo "Backing up ReGBA data"
	rsync --update -rt /media/data/local/home/.gpsp/ /media/sdcard/backup/gpsp
fi

# Backs up PCSX4all data
if [ -d /media/data/local/home/.pcsx4all/ ]; then
	if [ ! -d /media/sdcard/backup/pcsx4all/ ]; then
		echo "PCSX4all backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/pcsx4all
	fi
	echo "Backing up PCSX4all data"
	rsync --update -rt /media/data/local/home/.pcsx4all/ /media/sdcard/backup/pcsx4all
fi

# Backs up Picodrive data
if [ -d /media/data/local/home/.picodrive/ ]; then
	if [ ! -d /media/sdcard/backup/picodrive/ ]; then
		echo "Picodrive backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/picodrive
	fi
	echo "Backing up PicoDrive data"
	rsync --update -rt /media/data/local/home/.picodrive/ /media/sdcard/backup/picodrive
fi

# Backs up PocketSNES data
if [ -d /media/data/local/home/.snes96_snapshots/ ]; then
	if [ ! -d /media/sdcard/backup/snes96_snapshots/ ]; then
		echo "SNES96 backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/snes96_snapshots
	fi
	echo "Backing up SNES96 data"
	rsync --update -rt /media/data/local/home/.snes96_snapshots/ /media/sdcard/backup/snes96_snapshots
fi

if [ -d /media/data/local/home/.pocketsnes/ ]; then
	if [ ! -d /media/sdcard/backup/pocketsnes/ ]; then
		echo "PocketSNES backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/pocketsnes
	fi
	echo "Backing up PocketSNES data"
	rsync --update -rt /media/data/local/home/.pocketsnes/ /media/sdcard/backup/pocketsnes
fi

dialog --clear --backtitle "SaveSync v1.0" --title "Backup Complete" --msgbox "Save backup complete. Press START to exit." 10 30
exit
