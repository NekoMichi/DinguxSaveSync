#!/bin/sh
# title=Create Snapshot
# desc=Write snapshot to external SD card
# author=NekoMichi

echo "===Creating Snapshot==="

SNAPSHOTPATH="/media/sdcard/backupsnapshots"

# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if snapshot folder exists on card 2, if not then will create it
if [ ! -d $SNAPSHOTPATH/ ]; then
	echo "Snapshots folder doesn't exist, creating folder."
	mkdir $SNAPSHOTPATH
fi

# Overrides permissions on backup folder
chmod -R 777 $SNAPSHOTPATH

# Create timestamp
TIMESTAMP="SNAPSHOT_"$(date +%Y-%m-%d_%H-%M-%S)" SNAP"
EXPORTPATH=$SNAPSHOTPATH/$TIMESTAMP
mkdir "$EXPORTPATH"
chmod -R 777 "$EXPORTPATH"

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	mkdir "$EXPORTPATH/fceux"
	echo "Backing up FCEUX data..."
	rsync -rtW $INTPATH/.fceux/sav/ "$EXPORTPATH/fceux/sav"
	rsync -rtW $INTPATH/.fceux/fcs/ "$EXPORTPATH/fceux/fcs"
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	mkdir "$EXPORTPATH/gambatte"
	echo "Backing up Gambatte data..."
	rsync -rtW $INTPATH/.gambatte/saves/ "$EXPORTPATH/gambatte/saves"
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	mkdir "$EXPORTPATH/gpsp"
	echo "Backing up ReGBA data..."
	rsync -rtW $INTPATH/.gpsp/ "$EXPORTPATH/gpsp"
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	mkdir "$EXPORTPATH/pcsx4all"
	echo "Backing up PCSX4all data..."
	rsync -rtW $INTPATH/.pcsx4all/memcards/ "$EXPORTPATH/pcsx4all/memcards"
	rsync -rtW $INTPATH/.pcsx4all/sstates/ "$EXPORTPATH/pcsx4all/sstates"
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	mkdir "$EXPORTPATH/picodrive"
	echo "Backing up PicoDrive data..."
	rsync -rtW $INTPATH/.picodrive/mds/ "$EXPORTPATH/picodrive/mds"
	rsync -rtW $INTPATH/.picodrive/srm/ "$EXPORTPATH/picodrive/srm"
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	mkdir "$EXPORTPATH/snes96_snapshots"
	echo "Backing up SNES96 data..."
	rsync -rtW $INTPATH/.snes96_snapshots/ "$EXPORTPATH/snes96_snapshots"
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	mkdir "$EXPORTPATH/pocketsnes"
	echo "Backing up PocketSNES data..."
	rsync -rtW $INTPATH/.pocketsnes/ "$EXPORTPATH/pocketsnes"
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Snapshot Complete" --msgbox "Snapshot saved to \n\n$SNAPSHOTPATH/\n$TIMESTAMP\n\nPress START to exit." 10 43
exit
