#!/bin/sh
# title=Save Restore
# desc=Restore save data from external SD card
# author=NekoMichi

echo "===Restore Saves==="
# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard/ ]; then
	echo "Could not detect secondary micro SD card."
	echo "Please make sure you have a secondary SD card inserted."
	echo ""
	read -p "Press START to exit"
	exit
fi

# Checks to see if backup folder exists on card 2
if [ ! -d /media/sdcard/backup/ ]; then
	echo "Backup folder not found on card-2."
	echo "Please make sure card-2 has backup data stored."
	echo ""
	read -p "Press START to exit"
	exit
fi

# Restores FCEUX data
if [ -d /media/sdcard/backup/fceux/ ]; then
	if [ ! -d /media/data/local/home/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.fceux
	fi
	echo "Restoring FCEUX data"
	rsync --update -rt /media/sdcard/backup/fceux/ /media/data/local/home/.fceux
fi

# Restores Gambatte data
if [ -d /media/sdcard/backup/gambatte/ ]; then
	if [ ! -d /media/data/local/home/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.gambatte
	fi
	echo "Restoring Gambatte data"
	rsync --update -rt /media/sdcard/backup/gambatte/ /media/data/local/home/.gambatte
fi

# Restores ReGBA data
if [ -d /media/sdcard/backup/gpsp/ ]; then
	if [ ! -d /media/data/local/home/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.gpsp
	fi
	echo "Restoring ReGBA data"
	rsync --update -rt /media/sdcard/backup/gpsp/ /media/data/local/home/.gpsp
fi

# Restores PCSX4all data
if [ -d /media/sdcard/backup/pcsx4all/ ]; then
	if [ ! -d /media/data/local/home/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.pcsx4all
	fi
	echo "Restoring PCSX4all data"
	rsync --update -rt /media/sdcard/backup/pcsx4all/ /media/data/local/home/.pcsx4all
fi

# Restores Picodrive data
if [ -d /media/sdcard/backup/picodrive/ ]; then
	if [ ! -d /media/data/local/home/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.picodrive
	fi
	echo "Restoring PicoDrive data"
	rsync --update -rt /media/sdcard/backup/picodrive/ /media/data/local/home/.picodrive
fi

# Backs up PocketSNES data
if [ -d /media/sdcard/backup/snes96_snapshots/ ]; then
	if [ ! -d /media/data/local/home/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.snes96_snapshots
	fi
	echo "Restoring SNES96 data"
	rsync --update -rt /media/sdcard/backup/snes96_snapshots/ /media/data/local/home/.snes96_snapshots
fi

if [ -d /media/sdcard/backup/pocketsnes/ ]; then
	if [ ! -d /media/data/local/home/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.pocketsnes
	fi
	echo "Backing up PocketSNES data"
	rsync --update -rt /media/sdcard/backup/pocketsnes/ /media/data/local/home/.pocketsnes
fi

dialog --clear --backtitle "SaveSync v1.0" --title "Restore Complete" --msgbox "Save restore complete. Press START to exit." 10 30
exit
