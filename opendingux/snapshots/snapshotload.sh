#!/bin/sh
# title=Snapshot Load
# desc=Restore save data from a snapshot
# author=NekoMichi

SNAPSHOTPATH="$SDPATH/backupsnapshots"

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
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

# Overrides permissions on folders
chmod -R 777 "$RESTOREPATH"
chmod -R 777 $INTPATH

# Restores FCEUX data
if [ -d "$RESTOREPATH/fceux/" ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		mkdir $INTPATH/.fceux/sav
		mkdir $INTPATH/.fceux/fcs
	fi
	echo "Restoring FCEUX data..."
	rsync -rtvhW "$RESTOREPATH/fceux/sav/" $INTPATH/.fceux/sav
	rsync -rtvhW "$RESTOREPATH/fceux/fcs/" $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d "$RESTOREPATH/gambatte/" ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		mkdir $INTPATH/.gambatte/saves
	fi
	echo "Restoring Gambatte data..."
	rsync -rtvhW "$RESTOREPATH/gambatte/saves/" $INTPATH/.gambatte/saves
fi

# Restores OhBoy data
if [ -d "$RESTOREPATH/ohboy/" ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.ohboy
		mkdir $INTPATH/.ohboy/saves
	fi
	echo "Restoring OhBoy data..."
	rsync -rtvhW "$RESTOREPATH/ohboy/saves/" $INTPATH/.ohboy/saves
fi

# Restores ReGBA data
if [ -d "$RESTOREPATH/gpsp/" ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	rsync -rtvhW --exclude '*.cfg' "$RESTOREPATH/gpsp/" $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d "$RESTOREPATH/pcsx4all/" ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		mkdir $INTPATH/.pcsx4all/memcards
		mkdir $INTPATH/.pcsx4all/sstates
	fi
	echo "Restoring PCSX4all data..."
	rsync -rtvhW "$RESTOREPATH/pcsx4all/memcards/" $INTPATH/.pcsx4all/memcards
	rsync -rtvhW "$RESTOREPATH/pcsx4all/sstates/" $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d "$RESTOREPATH/picodrive/" ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		mkdir $INTPATH/.picodrive/mds
		mkdir $INTPATH/.picodrive/srm
	fi
	echo "Restoring PicoDrive data..."
	rsync -rtvhW "$RESTOREPATH/picodrive/mds/" $INTPATH/.picodrive/mds
	rsync -rtvhW "$RESTOREPATH/picodrive/srm/" $INTPATH/.picodrive/srm
fi

# Restores SMS Plus data
if [ -d "$RESTOREPATH/smsplus/" ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.smsplus
		mkdir $INTPATH/.smsplus/sram
		mkdir $INTPATH/.smsplus/state
	fi
	echo "Restoring SMS Plus data..."
	rsync -rtvhW "$RESTOREPATH/smsplus/sram/" $INTPATH/.smsplus/sram
	rsync -rtvhW "$RESTOREPATH/smsplus/state/" $INTPATH/.smsplus/state
fi

if [ -d "$RESTOREPATH/sms_sdl/" ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.sms_sdl
		mkdir $INTPATH/.sms_sdl/sram
		mkdir $INTPATH/.sms_sdl/state
	fi
	echo "Restoring SMS SDL data..."
	rsync -rtvhW "$RESTOREPATH/sms_sdl/sram/" $INTPATH/.sms_sdl/sram
	rsync -rtvhW "$RESTOREPATH/sms_sdl/state/" $INTPATH/.sms_sdl/state
fi

# Backs up PocketSNES data
if [ -d "$RESTOREPATH/snes96_snapshots/" ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	rsync -rtvhW --exclude '*.opt' "$RESTOREPATH/snes96_snapshots/" $INTPATH/.snes96_snapshots
fi

if [ -d "$RESTOREPATH/pocketsnes/" ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	rsync -rtvhW --exclude '*.opt' "$RESTOREPATH/pocketsnes/" $INTPATH/.pocketsnes
fi

# Restores Snes9x data
if [ -d "$RESTOREPATH/snes9x/" ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes9x
		mkdir $INTPATH/.snes9x/spc
		mkdir $INTPATH/.snes9x/sram
	fi
	echo "Restoring Snes9x data..."
	rsync -rtvhW "$RESTOREPATH/snes9x/spc/" $INTPATH/.snes9x/spc
	rsync -rtvhW "$RESTOREPATH/snes9x/sram/" $INTPATH/.snes9x/sram
fi

# Restores SwanEmu data
if [ -d "$RESTOREPATH/swanemu/" ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.swanemu
		mkdir $INTPATH/.swanemu/eeprom
		mkdir $INTPATH/.swanemu/sstates
	fi
	echo "Restoring SwanEmu data..."
	rsync -rtvhW "$RESTOREPATH/swanemu/eeprom/" $INTPATH/.swanemu/eeprom
	rsync -rtvhW "$RESTOREPATH/swanemu/sstates/" $INTPATH/.swanemu/sstates
fi

# Restores Temper data
if [ -d "$RESTOREPATH/temper/" ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.temper
		mkdir $INTPATH/.temper/bram
		mkdir $INTPATH/.temper/save_states
	fi
	echo "Restoring Temper data..."
	rsync -rtvhW "$RESTOREPATH/temper/bram/" $INTPATH/.temper/bram
	rsync -rtvhW "$RESTOREPATH/temper/save_states/" $INTPATH/.temper/save_states
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Complete" --msgbox "Restored from snapshot:\n$SELECTEDSNAPSHOT\n\nPress START to exit." 8 43
exit
