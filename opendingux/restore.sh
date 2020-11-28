#!/bin/sh
# title=Save Restore
# desc=Restore save data from external SD card
# author=NekoMichi

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if backup folder exists on card 2
if [ ! -d $EXTPATH/ ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No Backup Found" --msgbox "No backup data found on the SD card.\n\nPress START to exit." 8 29
	exit
fi

# Displays a confirmation dialog
dialog --clear --title "Confirm Restore?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to restore saves from backup? Any existing saves on this system will be overwritten." 7 49

confirmrestore=$?
clear

if [ $confirmrestore = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Cancelled" --msgbox "Save restore cancelled. No files were changed. Press START to exit." 7 29
	exit
fi

echo "===Restoring Saves==="

# Overrides permissions on folders
chmod -R 777 $EXTPATH
chmod -R 777 $INTPATH

# Sets alias
alias res="rsync --inplace -rtvh"

# Restores FCEUX data
if [ -d $EXTPATH/fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.fceux/sav $INTPATH/.fceux/fcs
	fi
	echo "Restoring FCEUX data..."
	res $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
	res $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.gambatte/saves
	fi
	echo "Restoring Gambatte data..."
	res $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores OhBoy data
if [ -d $EXTPATH/ohboy/ ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.ohboy/saves
	fi
	echo "Restoring OhBoy data..."
	res $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Restoring ReGBA data..."
	res --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.pcsx4all/memcards $INTPATH/.pcsx4all/sstates
	fi
	echo "Restoring PCSX4all data..."
	res $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	res $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.picodrive/mds $INTPATH/.picodrive/srm
	fi
	echo "Restoring PicoDrive data..."
	res $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
	res $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Restores SMS Plus data
if [ -d $EXTPATH/smsplus/ ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.smsplus/sram $INTPATH/.smsplus/state
	fi
	echo "Restoring SMS Plus data..."
	res $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
	res $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
fi

if [ -d $EXTPATH/sms_sdl/ ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sms_sdl/sram $INTPATH/.sms_sdl/state
	fi
	echo "Restoring SMS SDL data..."
	res $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
	res $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
fi

# Restores PocketSNES data
if [ -d $EXTPATH/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Restoring SNES96 data..."
	res --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Restoring PocketSNES data..."
	res --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
fi

# Restores Snes9x data
if [ -d $EXTPATH/snes9x/ ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.snes9x/spc $INTPATH/.snes9x/sram
	fi
	echo "Restoring Snes9x data..."
	res $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
	res $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
fi

# Restores SwanEmu data
if [ -d $EXTPATH/swanemu/ ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.swanemu/eeprom $INTPATH/.swanemu/sstates
	fi
	echo "Restoring SwanEmu data..."
	res $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
	res $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
fi

# Restores Temper data
if [ -d $EXTPATH/temper/ ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.temper/bram $INTPATH/.temper/save_states
	fi
	echo "Restoring Temper data..."
	res $EXTPATH/temper/bram/ $INTPATH/.temper/bram
	res $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
fi

# Restores Devilution/Diablo data
if [ -d $EXTPATH/.local/share/diasurgical/devilution/ ]; then
	if [ ! -d $INTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Devilution folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/diasurgical/devilution/
	fi
	echo "Restoring Devilution data..."
	res $EXTPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
	res $EXTPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
fi

# Restores Scummvm data
if [ -d $EXTPATH/.local/share/scummvm/saves/ ]; then
	if [! -d $INTPATH/.local/share/scummvm/saves/ ]; then
		echo "Scummvm folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/scummvm/saves/
	fi
	echo "Restoring Scummvm data..."
	res $EXTPATH/.local/share/scummvm/saves/ $INTPATH/.local/share/scummvm/saves/
	res $EXTPATH/.scummvmrc $INTPATH/
fi

# Restores Ur-Quan Masters (Starcon2 port) data
if [ -d $EXTPATH/.uqm/ ]; then
	if [ ! -d $INTPATH/.uqm/ ]; then
		echo "Ur-Quan Masters folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.uqm/
	fi
	echo "Restoring Ur-Quan Masters data..."
	res $EXTPATH/.uqm/* $INTPATH/.uqm/
fi

# Restores Atari800 data
if [ -d $EXTPATH/.atari/ ]; then
	if [ ! -d $INTPATH/.atari/ ]; then
		echo "Atari800 folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.atari/
	fi
	echo "Restoring Atari800 data..."
	res $EXTPATH/.atari/* $INTPATH/.atari/
	res $EXTPATH/.atari800.cfg $INTPATH/
fi

# Restores OpenDune data
if [ -d $EXTPATH/.opendune/save/ ]; then
	if [ ! -d $INTPATH/.opendune/save/ ]; then
		echo "OpenDune folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.opendune/save/
	fi
	echo "Restoring OpenDune data..."
	res $EXTPATH/.opendune/save/* $INTPATH/.opendune/save/
fi

# Restores OpenLara data
if [ -d $EXTPATH/.openlara/ ]; then
	if [ ! -d $INTPATH/.openlara/ ]; then
		echo "OpenLara folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.openlara/
	fi
	echo "Restoring OpenLara data..."
	res $EXTPATH/.openlara/savegame.dat $INTPATH/.openlara/savegame.dat
fi

# Restores GCW Connect data
if [ -d $EXTPATH/.local/share/gcwconnect/networks/ ]; then
	if [ ! -d $INTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "GCW Connect folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/gcwconnect/networks/
	fi
	echo "Restoring GCW Connect data..."
	res $EXTPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
fi

# Restore Super Mario 64 Port data
if [ -d $EXTPATH/.sm64-port/ ]; then
	if [ ! -d $INTPATH/.sm64-port/ ]; then
		echo "Super Mario 64 folder doesn't exist, creating folder."
		mkdir -p $INTPATH/.sm64-port/
	fi
	echo "Restoring Super Mario 64 data..."
	res $EXTPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
fi

# Synchronize cached writes to persistent storage
# This forces the filesystem to write to disk to avoid any data loss if you quickly turn off the device before the data is written to the sdcard.
sync

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Restore Complete" --msgbox "Save restore complete.\nPress START to exit." 6 29
exit
