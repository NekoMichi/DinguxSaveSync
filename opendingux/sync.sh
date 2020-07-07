#!/bin/sh
# title=Save Sync
# desc=Syncs save data with external SD card
# author=NekoMichi

echo "===Sync Saves==="
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
# if [ ! -d /media/sdcard/backup/gmenu2x/ ]; then
#	echo "Gmenu2x backup folder doesn't exist, creating folder"
#	mkdir /media/sdcard/backup/gmenu2x
# fi
# echo "Backing up Gmenu2x data"
# rsync --update -rtt /media/data/local/home/.gmenu2x/ /media/sdcard/backup/gmenu2x

# Backs up screenshots
if [ -d /media/data/local/home/screenshots/ ]; then
	if [ ! -d /media/sdcard/backup/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/screenshots
	fi
	echo "Backing up screenshots"
	rsync --update -rtt /media/data/local/home/screenshots/ /media/sdcard/backup/screenshots
fi

# Backs up scripts
# if [ -d /media/data/local/home/.scriptrunner/ ]; then
#	if [ ! -d /media/sdcard/backup/scriptrunner/ ]; then
#		echo "Scripts backup folder doesn't exist, creating folder"
#		mkdir /media/sdcard/backup/scriptrunner
#	fi
#	echo "Backing up scripts"
#	rsync --update -rtt /media/data/local/home/.scriptrunner/ /media/sdcard/backup/scriptrunner
# fi

# Syncs FCEUX data
if [ -d /media/data/local/home/.fceux/ ]; then
	if [ -d /media/sdcard/backup/fceux/ ]; then
		echo "Syncing FCEUX data"
		rsync --update -rt /media/data/local/home/.fceux/ /media/sdcard/backup/fceux
		rsync --update -rt /media/sdcard/backup/fceux/ /media/data/local/home/.fceux
	else
		echo "FCEUX backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/fceux
		echo "Syncing FCEUX data"
		rsync --update -rt /media/data/local/home/.fceux/ /media/sdcard/backup/fceux
	fi
else
	if [ -d /media/sdcard/backup/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.fceux
		echo "Syncing FCEUX data"
		rsync --update -rt /media/sdcard/backup/fceux/ /media/data/local/home/.fceux
	fi
fi

# Syncs Gambatte data
if [ -d /media/data/local/home/.gambatte/ ]; then
	if [ -d /media/sdcard/backup/gambatte/ ]; then
		echo "Syncing Gambatte data"
		rsync --update -rt /media/data/local/home/.gambatte/ /media/sdcard/backup/gambatte
		rsync --update -rt /media/sdcard/backup/gambatte/ /media/data/local/home/.gambatte
	else
		echo "Gambatte backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/gambatte
		echo "Syncing Gambatte data"
		rsync --update -rt /media/data/local/home/.gambatte/ /media/sdcard/backup/gambatte
	fi
else
	if [ -d /media/sdcard/backup/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.gambatte
		echo "Syncing Gambatte data"
		rsync --update -rt /media/sdcard/backup/gambatte/ /media/data/local/home/.gambatte
	fi
fi

# Syncs ReGBA data
if [ -d /media/data/local/home/.gpsp/ ]; then
	if [ -d /media/sdcard/backup/gpsp/ ]; then
		echo "Syncing ReGBA data"
		rsync --update -rt /media/data/local/home/.gpsp/ /media/sdcard/backup/gpsp
		rsync --update -rt /media/sdcard/backup/gpsp/ /media/data/local/home/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/gpsp
		echo "Syncing ReGBA data"
		rsync --update -rt /media/data/local/home/.gpsp/ /media/sdcard/backup/gpsp
	fi
else
	if [ -d /media/sdcard/backup/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.gpsp
		echo "Syncing ReGBA data"
		rsync --update -rt /media/sdcard/backup/gpsp/ /media/data/local/home/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d /media/data/local/home/.pcsx4all/ ]; then
	if [ -d /media/sdcard/backup/pcsx4all/ ]; then
		echo "Syncing PCSX4all data"
		rsync --update -rt /media/data/local/home/.pcsx4all/ /media/sdcard/backup/pcsx4all
		rsync --update -rt /media/sdcard/backup/pcsx4all/ /media/data/local/home/.pcsx4all
	else
		echo "PCSX4all backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/pcsx4all
		echo "Syncing PCSX4all data"
		rsync --update -rt /media/data/local/home/.pcsx4all/ /media/sdcard/backup/pcsx4all
	fi
else
	if [ -d /media/sdcard/backup/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.pcsx4all
		echo "Syncing PCSX4all data"
		rsync --update -rt /media/sdcard/backup/pcsx4all/ /media/data/local/home/.pcsx4all
	fi
fi

# Syncs Picodrive data
if [ -d /media/data/local/home/.picodrive/ ]; then
	if [ -d /media/sdcard/backup/picodrive/ ]; then
		echo "Syncing PicoDrive data"
		rsync --update -rt /media/data/local/home/.picodrive/ /media/sdcard/backup/picodrive
		rsync --update -rt /media/sdcard/backup/picodrive/ /media/data/local/home/.picodrive
	else
		echo "PicoDrive backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/picodrive
		echo "Syncing PicoDrive data"
		rsync --update -rt /media/data/local/home/.picodrive/ /media/sdcard/backup/picodrive
	fi
else
	if [ -d /media/sdcard/backup/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.picodrive
		echo "Syncing PicoDrive data"
		rsync --update -rt /media/sdcard/backup/picodrive/ /media/data/local/home/.picodrive
	fi
fi

# Syncs SNES96 data
if [ -d /media/data/local/home/.snes96_snapshots/ ]; then
	if [ -d /media/sdcard/backup/snes96_snapshots/ ]; then
		echo "Syncing SNES96 data"
		rsync --update -rt /media/data/local/home/.snes96_snapshots/ /media/sdcard/backup/snes96_snapshots
		rsync --update -rt /media/sdcard/backup/snes96_snapshots/ /media/data/local/home/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/snes96_snapshots
		echo "Syncing SNES96 data"
		rsync --update -rt /media/data/local/home/.snes96_snapshots/ /media/sdcard/backup/snes96_snapshots
	fi
else
	if [ -d /media/sdcard/backup/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.snes96_snapshots
		echo "Syncing SNES96 data"
		rsync --update -rt /media/sdcard/backup/snes96_snapshots/ /media/data/local/home/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d /media/data/local/home/.pocketsnes/ ]; then
	if [ -d /media/sdcard/backup/pocketsnes/ ]; then
		echo "Syncing PocketSNES data"
		rsync --update -rt /media/data/local/home/.pocketsnes/ /media/sdcard/backup/pocketsnes
		rsync --update -rt /media/sdcard/backup/pocketsnes/ /media/data/local/home/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder"
		mkdir /media/sdcard/backup/pocketsnes
		echo "Syncing PocketSNES data"
		rsync --update -rt /media/data/local/home/.pocketsnes/ /media/sdcard/backup/pocketsnes
	fi
else
	if [ -d /media/sdcard/backup/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder"
		mkdir /media/data/local/home/.pocketsnes
		echo "Syncing PocketSNES data"
		rsync --update -rt /media/sdcard/backup/pocketsnes/ /media/data/local/home/.pocketsnes
	fi
fi

dialog --clear --backtitle "SaveSync v1.0" --title "Sync Complete" --msgbox "Save sync complete. Press START to exit." 10 30
exit
