#!/bin/sh
# title=Save Import
# desc=Import save data from external SD card
# author=NekoMichi

echo "===Card Check==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if the card in slot 2 has a system partition
if [ ! -b /dev/mmcblk1p2 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Invalid SD Card" --msgbox "The card in slot-2 is not a valid OpenDingux formatted card.\n\nPress START to exit." 9 31
	exit
fi

PARTPATH=$(findmnt -n --output=target /dev/mmcblk1p2 | head -1)
EXTPATH="$PARTPATH/local/home"

# Checks to see if the card in slot 2 has a system partition
if [ ! -d $EXTPATH ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Invalid SD Card" --msgbox "The card in slot-2 is not a valid OpenDingux formatted card.\n\nPress START to exit." 9 31
	exit
fi

# Debug message
# dialog --clear --backtitle "SaveSync $APPVERSION" --title "Debug Message" --msgbox "PARTPATH\n$PARTPATH\n\nEXTPATH\n$EXTPATH" 9 35

# Displays a confirmation dialog
dialog --clear --title "Confirm Import?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to import saves? This will overwrite any existing saves on this current device." 7 49

confirmimport=$?
clear

if [ $confirmimport = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Import Cancelled" --msgbox "Save import cancelled. No files were changed. Press START to exit." 7 29
	exit
fi

echo "===Importing Saves==="

# Overrides permissions on folders
chmod -R 777 $EXTPATH
chmod -R 777 $INTPATH

# Sets alias
alias imp="rsync --inplace -rtvhc"

# Imports FCEUX data
if [ -d $EXTPATH/.fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.fceux/sav $INTPATH/.fceux/fcs
	fi
	echo "Importing FCEUX data..."
	imp $EXTPATH/.fceux/sav/ $INTPATH/.fceux/sav
	imp $EXTPATH/.fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Imports Gambatte data
if [ -d $EXTPATH/.gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.gambatte/saves
	fi
	echo "Importing Gambatte data..."
	imp $EXTPATH/.gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Imports OhBoy data
if [ -d $EXTPATH/.ohboy/ ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.ohboy/saves
	fi
	echo "Importing OhBoy data..."
	imp $EXTPATH/.ohboy/saves/ $INTPATH/.ohboy/saves
fi

# Imports ReGBA data
if [ -d $EXTPATH/.gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Importing ReGBA data..."
	imp --exclude '*.cfg' $EXTPATH/.gpsp/ $INTPATH/.gpsp
fi

# Imports PCSX4all data
if [ -d $EXTPATH/.pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.pcsx4all/memcards $INTPATH/.pcsx4all/sstates
	fi
	echo "Importing PCSX4all data..."
	imp $EXTPATH/.pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	imp $EXTPATH/.pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Imports Picodrive data
if [ -d $EXTPATH/.picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.picodrive/mds $INTPATH/.picodrive/srm
	fi
	echo "Importing PicoDrive data..."
	imp $EXTPATH/.picodrive/mds/ $INTPATH/.picodrive/mds
	imp $EXTPATH/.picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Imports SMS Plus data
if [ -d $EXTPATH/.smsplus/ ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.smsplus/sram $INTPATH/.smsplus/state
	fi
	echo "Importing SMS Plus data..."
	imp $EXTPATH/.smsplus/sram/ $INTPATH/.smsplus/sram
	imp $EXTPATH/.smsplus/state/ $INTPATH/.smsplus/state
fi

if [ -d $EXTPATH/.sms_sdl/ ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sms_sdl/sram $INTPATH/.sms_sdl/state
	fi
	echo "Importing SMS SDL data..."
	imp $EXTPATH/.sms_sdl/sram/ $INTPATH/.sms_sdl/sram
	imp $EXTPATH/.sms_sdl/state/ $INTPATH/.sms_sdl/state
fi

# Importing PocketSNES data
if [ -d $EXTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Importing SNES96 data..."
	imp --exclude '*.opt' $EXTPATH/.snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/.pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Importing PocketSNES data..."
	imp --exclude '*.opt' $EXTPATH/.pocketsnes/ $INTPATH/.pocketsnes
fi

# Imports Snes9x data
if [ -d $EXTPATH/.snes9x/ ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.snes9x/spc $INTPATH/.snes9x/sram
	fi
	echo "Importing Snes9x data..."
	imp $EXTPATH/.snes9x/spc/ $INTPATH/.snes9x/spc
	imp $EXTPATH/.snes9x/sram/ $INTPATH/.snes9x/sram
fi

# Imports SwanEmu data
if [ -d $EXTPATH/.swanemu/ ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.swanemu/eeprom $INTPATH/.swanemu/sstates
	fi
	echo "Importing SwanEmu data..."
	imp $EXTPATH/.swanemu/eeprom/ $INTPATH/.swanemu/eeprom
	imp $EXTPATH/.swanemu/sstates/ $INTPATH/.swanemu/sstates
fi

# Imports Temper data
if [ -d $EXTPATH/.temper/ ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.temper/bram $INTPATH/.temper/save_states
	fi
	echo "Importing Temper data..."
	imp $EXTPATH/.temper/bram/ $INTPATH/.temper/bram
	imp $EXTPATH/.temper/save_states/ $INTPATH/.temper/save_states
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Import Complete" --msgbox "Save import complete.\nPress START to exit." 6 29
exit
