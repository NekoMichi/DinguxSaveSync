#!/bin/sh
# title=Snapshot Load
# desc=Restore save data from a snapshot
# author=NekoMichi

SNAPSHOTPATH="/media/sdcard/backupsnapshots"

# Checks to see if there is a card inserted in slot 2
if [ ! -d /media/sdcard ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if snapshots folder exists on card 2
if [ ! -d $SNAPSHOTPATH/ ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No Snapshots" --msgbox "No snapshots found in backup folder.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if snapshots folder is empty on card 2
TOTALSNAPSHOTS=$(find $SNAPSHOTPATH/SNAPSHOT*SNAP -maxdepth 0 -type d | wc -l)
if [ $TOTALSNAPSHOTS = "0" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No Snapshots" --msgbox "No snapshots found in backup folder.\n\nPress START to exit." 8 29
	exit
fi

# Generate list of snapshots
cd $SNAPSHOTPATH
MENUITEMS=$(ls -d -- SNAPSHOT*SNAP)

# Display list of snapshots
SELECTEDSNAPSHOT=$(dialog --backtitle "SaveSync $APPVERSION" --title "SaveSync - Snapshots" --menu "Select snapshot to load" 15 49 10 $MENUITEMS 2>&1 >/dev/tty)

if [ -z $SELECTEDSNAPSHOT ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Operation Cancelled" --msgbox "Snapshot restore cancelled.\nNo files were changed.\n\nPress START to exit." 8 35
	exit
fi

# Displays a confirmation dialog
dialog --clear --backtitle "SaveSync $APPVERSION" --title "Confirm Load?" --yesno "Are you sure you want to load the following snapshot? Any existing saves on this system will be overwritten.\n\n$SELECTEDSNAPSHOT" 10 49
CONFIRMLOAD=$?
clear

if [ $CONFIRMLOAD = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Operation Cancelled" --msgbox "Snapshot restore cancelled.\nNo files were changed.\n\nPress START to exit." 8 35
	exit
fi

# Set directory path for selected snapshot
RESTOREPATH=$SNAPSHOTPATH"/"$SELECTEDSNAPSHOT" SNAP"

echo "===Restoring from Snapshot==="

# Overrides permissions on backup folder
chmod -R 777 "$RESTOREPATH"

# Restores FCEUX data
if [ -d "$RESTOREPATH/fceux/" ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
	fi
	echo "Restoring FCEUX data..."
	rsync -rtW --exclude '*.cfg' "$RESTOREPATH/fceux/sav/" $INTPATH/.fceux/sav
	rsync -rtW --exclude '*.cfg' "$RESTOREPATH/fceux/fcs/" $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d "$RESTOREPATH/gambatte/" ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
	fi
	echo "Restoring Gambatte data..."
	rsync -rtW --exclude '*.cfg' "$RESTOREPATH/gambatte/saves/" $INTPATH/.gambatte/saves
fi

# Restores ReGBA data
if [ -d "$RESTOREPATH/gpsp/" ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	rsync -rtW --exclude '*.cfg' "$RESTOREPATH/gpsp/" $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d "$RESTOREPATH/pcsx4all/" ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
	fi
	echo "Restoring PCSX4all data..."
	rsync -rtW --exclude '*.cfg' "$RESTOREPATH/pcsx4all/memcards/" $INTPATH/.pcsx4all/memcards
	rsync -rtW --exclude '*.cfg' "$RESTOREPATH/pcsx4all/sstates/" $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d "$RESTOREPATH/picodrive/" ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
	fi
	echo "Restoring PicoDrive data..."
	rsync -rtW --exclude '*.cfg' --exclude '*.cfg0' "$RESTOREPATH/picodrive/mds/" $INTPATH/.picodrive/mds
	rsync -rtW --exclude '*.cfg' --exclude '*.cfg0' "$RESTOREPATH/picodrive/srm/" $INTPATH/.picodrive/srm
fi

# Backs up PocketSNES data
if [ -d "$RESTOREPATH/snes96_snapshots/" ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	rsync -rtW --exclude '*.opt' "$RESTOREPATH/snes96_snapshots/" $INTPATH/.snes96_snapshots
fi

if [ -d "$RESTOREPATH/pocketsnes/" ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	rsync -rtW --exclude '*.opt' "$RESTOREPATH/pocketsnes/" $INTPATH/.pocketsnes
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Complete" --msgbox "Restored from snapshot:\n$SELECTEDSNAPSHOT\n\nPress START to exit." 8 35
exit
