#!/bin/sh
# title=Debug Save Sync
# desc=Debug syncing save data with external SD card
# author=NekoMichi

echo "===Sync Saves (Test)==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
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
		rsync --update -nvrtW $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		rsync --update -nvrtW $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
		echo "Imported FCEUX files:"
		rsync --update -nvrtW $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		rsync --update -nvrtW $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/fceux
		mkdir $EXTPATH/fceux/sav
		mkdir $EXTPATH/fceux/fcs
		echo "Exported FCEUX files:"
		rsync --update -nvrtW $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		rsync --update -nvrtW $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
	fi
else
	if [ -d $EXTPATH/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		mkdir $INTPATH/.fceux/sav
		mkdir $INTPATH/.fceux/fcs
		echo "Imported FCEUX files:"
		rsync --update -nvrtW $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		rsync --update -nvrtW $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Exported Gambatte files:"
		rsync --update -nvrtW $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
		echo "Imported Gambatte files:"
		rsync --update -nvrtW $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gambatte
		mkdir $EXTPATH/gambatte/saves
		echo "Exported Gambatte files:"
		rsync --update -nvrtW $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
	fi
else
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		mkdir $INTPATH/.gambatte/saves
		echo "Imported Gambatte files:"
		rsync --update -nvrtW $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
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
		rsync --update -nvrtW $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		rsync --update -nvrtW $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
		echo "Imported PCSX4all files:"
		rsync --update -nvrtW $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		rsync --update -nvrtW $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pcsx4all
		mkdir $EXTPATH/pcsx4all/memcards
		mkdir $EXTPATH/pcsx4all/sstates
		echo "Exported PCSX4all files:"
		rsync --update -nvrtW $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		rsync --update -nvrtW $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
	fi
else
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		mkdir $INTPATH/.pcsx4all/memcards
		mkdir $INTPATH/.pcsx4all/sstates
		echo "Imported PCSX4all files:"
		rsync --update -nvrtW $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		rsync --update -nvrtW $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "Exported Picodrive files:"
		rsync --update -nvrtW $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		rsync --update -nvrtW $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
		echo "Imported Picodrive files:"
		rsync --update -nvrtW $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		rsync --update -nvrtW $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/picodrive
		mkdir $EXTPATH/picodrive/mds
		mkdir $EXTPATH/picodrive/srm
		echo "Exported Picodrive files:"
		rsync --update -nvrtW $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		rsync --update -nvrtW $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
	fi
else
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		mkdir $INTPATH/.picodrive/mds
		mkdir $INTPATH/.picodrive/srm
		echo "Imported Picodrive files:"
		rsync --update -nvrtW $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		rsync --update -nvrtW $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
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
