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

echo "Valid OpenDingux card detected in slot 2."

# Displays a confirmation dialog
dialog --clear --title "Confirm Import?" --backtitle "SaveSync $APPVERSION" --yesno "Are you sure you want to import saves? This will overwrite any existing saves on this current device." 7 49

confirmexport=$?
clear

if [ $confirmexport = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Import Cancelled" --msgbox "Save import cancelled. No files were changed. Press START to exit." 7 29
	exit
fi

echo "===Importing Saves==="

# Overrides permissions on backup folder
# chmod -R 777 $EXTPATH

PARTPATH=$(findmnt -n --output=target /dev/mmcblk1p2 | head -1)
EXTPATH="$PARTPATH/local/home"

# Imports FCEUX data
if [ -d $EXTPATH/.fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		mkdir $INTPATH/.fceux/sav
		mkdir $INTPATH/.fceux/fcs
	fi
	echo "Importing FCEUX data..."
	rsync -rtW $EXTPATH/.fceux/sav/ $INTPATH/.fceux/sav
	rsync -rtW $EXTPATH/.fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Imports Gambatte data
if [ -d $EXTPATH/.gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		mkdir $INTPATH/.gambatte/saves
	fi
	echo "Importing Gambatte data..."
	rsync -rtW $EXTPATH/.gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Imports OhBoy data
if [ -d $EXTPATH/.ohboy/ ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.ohboy
		mkdir $INTPATH/.ohboy/saves
	fi
	echo "Importing OhBoy data..."
	rsync -rtW $EXTPATH/.ohboy/saves/ $INTPATH/.ohboy/saves
fi

# Imports ReGBA data
if [ -d $EXTPATH/.gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Importing ReGBA data..."
	rsync -rtW --exclude '*.cfg' $EXTPATH/.gpsp/ $INTPATH/.gpsp
fi

# Imports PCSX4all data
if [ -d $EXTPATH/.pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		mkdir $INTPATH/.pcsx4all/memcards
		mkdir $INTPATH/.pcsx4all/sstates
	fi
	echo "Importing PCSX4all data..."
	rsync -rtW $EXTPATH/.pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -rtW $EXTPATH/.pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Imports Picodrive data
if [ -d $EXTPATH/.picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		mkdir $INTPATH/.picodrive/mds
		mkdir $INTPATH/.picodrive/srm
	fi
	echo "Importing PicoDrive data..."
	rsync -rtW $EXTPATH/.picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -rtW $EXTPATH/.picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Imports SMS Plus data
if [ -d $EXTPATH/.smsplus/ ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.smsplus
		mkdir $INTPATH/.smsplus/sram
		mkdir $INTPATH/.smsplus/state
	fi
	echo "Importing SMS Plus data..."
	rsync -rtW $EXTPATH/.smsplus/sram/ $INTPATH/.smsplus/sram
	rsync -rtW $EXTPATH/.smsplus/state/ $INTPATH/.smsplus/state
fi

if [ -d $EXTPATH/.sms_sdl/ ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.sms_sdl
		mkdir $INTPATH/.sms_sdl/sram
		mkdir $INTPATH/.sms_sdl/state
	fi
	echo "Importing SMS SDL data..."
	rsync -rtW $EXTPATH/.sms_sdl/sram/ $INTPATH/.sms_sdl/sram
	rsync -rtW $EXTPATH/.sms_sdl/state/ $INTPATH/.sms_sdl/state
fi

# Importing PocketSNES data
if [ -d $EXTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Importing SNES96 data..."
	rsync -rtW --exclude '*.opt' $EXTPATH/.snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/.pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Importing PocketSNES data..."
	rsync -rtW --exclude '*.opt' $EXTPATH/.pocketsnes/ $INTPATH/.pocketsnes
fi

# Imports Snes9x data
if [ -d $EXTPATH/.snes9x/ ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes9x
		mkdir $INTPATH/.snes9x/spc
		mkdir $INTPATH/.snes9x/sram
	fi
	echo "Importing Snes9x data..."
	rsync -rtW $EXTPATH/.snes9x/spc/ $INTPATH/.snes9x/spc
	rsync -rtW $EXTPATH/.snes9x/sram/ $INTPATH/.snes9x/sram
fi

# Imports SwanEmu data
if [ -d $EXTPATH/.swanemu/ ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.swanemu
		mkdir $INTPATH/.swanemu/eeprom
		mkdir $INTPATH/.swanemu/sstates
	fi
	echo "Importing SwanEmu data..."
	rsync -rtW $EXTPATH/.swanemu/eeprom/ $INTPATH/.swanemu/eeprom
	rsync -rtW $EXTPATH/.swanemu/sstates/ $INTPATH/.swanemu/sstates
fi

# Imports Temper data
if [ -d $EXTPATH/.temper/ ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.temper
		mkdir $INTPATH/.temper/bram
		mkdir $INTPATH/.temper/save_states
	fi
	echo "Importing Temper data..."
	rsync -rtW $EXTPATH/.temper/bram/ $INTPATH/.temper/bram
	rsync -rtW $EXTPATH/.temper/save_states/ $INTPATH/.temper/save_states
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Import Complete" --msgbox "Save import complete.\nPress START to exit." 6 29
exit
