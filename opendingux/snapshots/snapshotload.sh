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

# Sets alias
alias res="rsync --inplace -rtvh"

# Restores FCEUX data
if [ -d "$RESTOREPATH/fceux/" ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.fceux/sav $INTPATH/.fceux/fcs
	fi
	echo "Restoring FCEUX data..."
	res "$RESTOREPATH/fceux/sav/" $INTPATH/.fceux/sav
	res "$RESTOREPATH/fceux/fcs/" $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d "$RESTOREPATH/gambatte/" ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.gambatte/saves
	fi
	echo "Restoring Gambatte data..."
	res "$RESTOREPATH/gambatte/saves/" $INTPATH/.gambatte/saves
fi

# Restores OhBoy data
if [ -d "$RESTOREPATH/ohboy/" ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.ohboy/saves
	fi
	echo "Restoring OhBoy data..."
	res "$RESTOREPATH/ohboy/saves/" $INTPATH/.ohboy/saves
fi

# Restores ReGBA data
if [ -d "$RESTOREPATH/gpsp/" ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	res --exclude '*.cfg' "$RESTOREPATH/gpsp/" $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d "$RESTOREPATH/pcsx4all/" ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.pcsx4all/memcards $INTPATH/.pcsx4all/sstates
	fi
	echo "Restoring PCSX4all data..."
	res "$RESTOREPATH/pcsx4all/memcards/" $INTPATH/.pcsx4all/memcards
	res "$RESTOREPATH/pcsx4all/sstates/" $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d "$RESTOREPATH/picodrive/" ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.picodrive/mds $INTPATH/.picodrive/srm
	fi
	echo "Restoring PicoDrive data..."
	res "$RESTOREPATH/picodrive/mds/" $INTPATH/.picodrive/mds
	res "$RESTOREPATH/picodrive/srm/" $INTPATH/.picodrive/srm
fi

# Restores SMS Plus data
if [ -d "$RESTOREPATH/smsplus/" ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.smsplus/sram $INTPATH/.smsplus/state
	fi
	echo "Restoring SMS Plus data..."
	res "$RESTOREPATH/smsplus/sram/" $INTPATH/.smsplus/sram
	res "$RESTOREPATH/smsplus/state/" $INTPATH/.smsplus/state
fi

if [ -d "$RESTOREPATH/sms_sdl/" ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sms_sdl/sram $INTPATH/.sms_sdl/state
	fi
	echo "Restoring SMS SDL data..."
	res "$RESTOREPATH/sms_sdl/sram/" $INTPATH/.sms_sdl/sram
	res "$RESTOREPATH/sms_sdl/state/" $INTPATH/.sms_sdl/state
fi

# Backs up PocketSNES data
if [ -d "$RESTOREPATH/snes96_snapshots/" ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	res --exclude '*.opt' "$RESTOREPATH/snes96_snapshots/" $INTPATH/.snes96_snapshots
fi

if [ -d "$RESTOREPATH/pocketsnes/" ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	res --exclude '*.opt' "$RESTOREPATH/pocketsnes/" $INTPATH/.pocketsnes
fi

# Restores Snes9x data
if [ -d "$RESTOREPATH/snes9x/" ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.snes9x/spc $INTPATH/.snes9x/sram
	fi
	echo "Restoring Snes9x data..."
	res "$RESTOREPATH/snes9x/spc/" $INTPATH/.snes9x/spc
	res "$RESTOREPATH/snes9x/sram/" $INTPATH/.snes9x/sram
fi

# Restores SwanEmu data
if [ -d "$RESTOREPATH/swanemu/" ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.swanemu/eeprom $INTPATH/.swanemu/sstates
	fi
	echo "Restoring SwanEmu data..."
	res "$RESTOREPATH/swanemu/eeprom/" $INTPATH/.swanemu/eeprom
	res "$RESTOREPATH/swanemu/sstates/" $INTPATH/.swanemu/sstates
fi

# Restores Temper data
if [ -d "$RESTOREPATH/temper/" ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.temper/bram $INTPATH/.temper/save_states
	fi
	echo "Restoring Temper data..."
	res "$RESTOREPATH/temper/bram/" $INTPATH/.temper/bram
	res "$RESTOREPATH/temper/save_states/" $INTPATH/.temper/save_states
fi

# Restores Devilution/Diablo data
if [ -d $RESTOREPATH/.local/share/diasurgical/devilution/ ]; then
	if [ ! -d $INTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Devilution folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/diasurgical/devilution/
	fi
	echo "Restoring Devilution data..."
	res $RESTOREPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
	res $RESTOREPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
fi

# Restores Scummvm data
if [ -d $RESTOREPATH/.local/share/scummvm/saves/ ]; then
	if [! -d $INTPATH/.local/share/scummvm/saves/ ]; then
		echo "Scummvm folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/scummvm/saves/
	fi
	echo "Restoring Scummvm data..."
	res $RESTOREPATH/.local/share/scummvm/saves/ $INTPATH/.local/share/scummvm/saves/
	res $RESTOREPATH/.scummvmrc $INTPATH/
fi

# Restores Ur-Quan Masters (Starcon2 port) data
if [ -d $RESTOREPATH/.uqm/ ]; then
	if [ ! -d $INTPATH/.uqm/ ]; then
		echo "Ur-Quan Masters folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.uqm/
	fi
	echo "Restoring Ur-Quan Masters data..."
	res $RESTOREPATH/.uqm/* $INTPATH/.uqm/
fi

# Restores Atari800 data
if [ -d $RESTOREPATH/.atari/ ]; then
	if [ ! -d $INTPATH/.atari/ ]; then
		echo "Atari800 folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.atari/
	fi
	echo "Restoring Atari800 data..."
	res $RESTOREPATH/.atari/* $INTPATH/.atari/
	res $RESTOREPATH/.atari800.cfg $INTPATH/
fi

# Restores OpenDune data
if [ -d $RESTOREPATH/.opendune/save/ ]; then
	if [ ! -d $INTPATH/.opendune/save/ ]; then
		echo "OpenDune folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.opendune/save/
	fi
	echo "Restoring OpenDune data..."
	res $RESTOREPATH/.opendune/save/* $INTPATH/.opendune/save/
fi

# Restores OpenLara data
if [ -d $RESTOREPATH/.openlara/ ]; then
	if [ ! -d $INTPATH/.openlara/ ]; then
		echo "OpenLara folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.openlara/
	fi
	echo "Restoring OpenLara data..."
	res $RESTOREPATH/.openlara/savegame.dat $INTPATH/.openlara/savegame.dat
fi

# Restores GCW Connect data
if [ -d $RESTOREPATH/.local/share/gcwconnect/networks/ ]; then
	if [ ! -d $INTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "GCW Connect folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/gcwconnect/networks/
	fi
	echo "Restoring GCW Connect data..."
	res $RESTOREPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
fi

# Restore Super Mario 64 Port data
if [ -d $RESTOREPATH/.sm64-port/ ]; then
	if [ ! -d $INTPATH/.sm64-port/ ]; then
		echo "Super Mario 64 folder doesn't exist, creating folder."
		mkdir -p $INTPATH/.sm64-port/
	fi
	echo "Restoring Super Mario 64 data..."
	res $RESTOREPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Complete" --msgbox "Restored from snapshot:\n$SELECTEDSNAPSHOT\n\nPress START to exit." 8 43
exit
