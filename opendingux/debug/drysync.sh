#!/bin/sh
# title=Debug Save Sync
# desc=Debug syncing save data with external SD card
# author=NekoMichi

echo "===Sync Saves (Test)==="

# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard ]; then
	echo "Could not detect secondary micro SD card."
	echo "Please make sure you have a secondary SD card inserted."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Checks to see if backup folder exists on card 2, if not then will create it
if [ ! -d $EXTPATH ]; then
	echo "Backup folder doesn't exist, creating folder."
	mkdir $EXTPATH
fi

# Overrides permissions on backup folder
chmod -R 777 $EXTPATH

# Backs up screenshots
if [ -d $INTPATH/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Exported screenshots:"
	rsync -nvrtW --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/fceux/ ]; then
		echo "Exported FCEUX files:"
		rsync --update -nvrtW $INTPATH/.fceux/ $EXTPATH/fceux
		echo "Imported FCEUX files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/fceux/ $INTPATH/.fceux
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/fceux
		echo "Exported FCEUX files:"
		rsync --update -nvrtW $INTPATH/.fceux/ $EXTPATH/fceux
	fi
else
	if [ -d $EXTPATH/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		echo "Imported FCEUX files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/fceux/ $INTPATH/.fceux
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Exported Gambatte files:"
		rsync --update -nvrtW $INTPATH/.gambatte/ $EXTPATH/gambatte
		echo "Imported Gambatte files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/gambatte/ $INTPATH/.gambatte
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gambatte
		echo "Exported Gambatte files:"
		rsync --update -nvrtW $INTPATH/.gambatte/ $EXTPATH/gambatte
	fi
else
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		echo "Imported Gambatte files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/gambatte/ $INTPATH/.gambatte
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "Exported ReGBA files:"
		rsync --update -nvrtW $INTPATH/.gpsp/ $EXTPATH/gpsp
		echo "Imported ReGBA files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
		echo "Exported ReGBA files:"
		rsync --update -nvrtW $INTPATH/.gpsp/ $EXTPATH/gpsp
	fi
else
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Imported ReGBA files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "Exported PCSX4all files:"
		rsync --update -nvrtW $INTPATH/.pcsx4all/ $EXTPATH/pcsx4all
		echo "Imported PCSX4all files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/pcsx4all/ $INTPATH/.pcsx4all
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pcsx4all
		echo "Exported PCSX4all files:"
		rsync --update -nvrtW $INTPATH/.pcsx4all/ $EXTPATH/pcsx4all
	fi
else
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		echo "Imported PCSX4all files:"
		rsync --update -nvrtW --exclude '*.cfg' $EXTPATH/pcsx4all/ $INTPATH/.pcsx4all
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "Exported Picodrive files:"
		rsync --update -nvrtW $INTPATH/.picodrive/ $EXTPATH/picodrive
		echo "Imported Picodrive files:"
		rsync --update -nvrtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/ $INTPATH/.picodrive
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/picodrive
		echo "Exported Picodrive files:"
		rsync --update -nvrtW $INTPATH/.picodrive/ $EXTPATH/picodrive
	fi
else
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		echo "Imported Picodrive files:"
		rsync --update -nvrtW --exclude '*.cfg' --exclude '*.cfg0' $EXTPATH/picodrive/ $INTPATH/.picodrive
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "Exported SNES96 files:"
		rsync --update -nvrtW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
		echo "Imported SNES96 files:"
		rsync --update -nvrtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
		echo "Exported SNES96 files:"
		rsync --update -nvrtW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
	fi
else
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Imported SNES96 files:"
		rsync --update -nvrtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "Exported PocketSNES files:"
		rsync --update -nvrtW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
		echo "Imported PocketSNES files:"
		rsync --update -nvrtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
		echo "Exported PocketSNES files:"
		rsync --update -nvrtW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
	fi
else
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Imported PocketSNES files:"
		rsync --update -nvrtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

echo ""
echo "Debug sync complete."
echo "Report saved to /media/sdcard/backup/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
