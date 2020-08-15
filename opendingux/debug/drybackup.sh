#!/bin/sh
# title=Debug Save Backup
# desc=Debug backup save data to external SD card
# author=NekoMichi

echo "===Backup Saves (Test)==="

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

# Sets alias
alias tbac="rsync --inplace -nrtvh"

# Backs up screenshots
if [ -d $INTPATH/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Exported screenshots:"
	tbac --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ ! -d $EXTPATH/fceux/ ]; then
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/fceux/sav $EXTPATH/fceux/fcs
	fi
	echo "Exported FCEUX files:"
	tbac $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
	tbac $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ ! -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/gambatte/saves
	fi
	echo "Exported Gambatte files:"
	tbac $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
fi

# Backs up OhBoy data
if [ -d $INTPATH/.ohboy/ ]; then
	if [ ! -d $EXTPATH/ohboy/ ]; then
		echo "OhBoy backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/ohboy/saves
	fi
	echo "Exported OhBoy files:"
	tbac $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ ! -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
	fi
	echo "Exported ReGBA files:"
	tbac $INTPATH/.gpsp/ $EXTPATH/gpsp
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ ! -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/pcsx4all/memcards $EXTPATH/pcsx4all/sstates
	fi
	echo "Exported PCSX4all files:"
	tbac $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
	tbac $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ ! -d $EXTPATH/picodrive/ ]; then
		echo "Picodrive backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/picodrive/mds $EXTPATH/picodrive/srm
	fi
	echo "Exported Picodrive files:"
	tbac $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
	tbac $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
fi

# Backs up SMS Plus data
if [ -d $INTPATH/.smsplus/ ]; then
	if [ ! -d $EXTPATH/smsplus/ ]; then
		echo "SMS Plus backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/smsplus/sram $EXTPATH/smsplus/state
	fi
	echo "Exported SMS Plus files:"
	tbac $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
	tbac $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
fi

if [ -d $INTPATH/.sms_sdl/ ]; then
	if [ ! -d $EXTPATH/sms_sdl/ ]; then
		echo "SMS SDL backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/sms_sdl/sram $EXTPATH/sms_sdl/state
	fi
	echo "Exported SMS SDL files:"
	tbac $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
	tbac $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ ! -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
	fi
	echo "Exported SNES96 files:"
	tbac $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ ! -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
	fi
	echo "Exported PocketSNES files:"
	tbac $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
fi

# Backs up Snes9x data
if [ -d $INTPATH/.snes9x/ ]; then
	if [ ! -d $EXTPATH/snes9x/ ]; then
		echo "Snes9x backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/snes9x/spc $EXTPATH/snes9x/sram
	fi
	echo "Exported Snes9x files:"
	tbac $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
	tbac $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
fi

# Backs up SwanEmu data
if [ -d $INTPATH/.swanemu/ ]; then
	if [ ! -d $EXTPATH/swanemu/ ]; then
		echo "SwanEmu backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/swanemu/eeprom $EXTPATH/swanemu/sstates
	fi
	echo "Exported SwanEmu files:"
	tbac $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
	tbac $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
fi

# Backs up Temper data
if [ -d $INTPATH/.temper/ ]; then
	if [ ! -d $EXTPATH/temper/ ]; then
		echo "Temper backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/temper/bram $EXTPATH/temper/save_states
	fi
	echo "Exported Temper files:"
	tbac $INTPATH/.temper/bram/ $EXTPATH/temper/bram
	tbac $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
fi

echo ""
echo "Debug backup complete."
echo "Report saved to ~/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
