#!/bin/sh
# title=Debug Save Restore
# desc=Debug restore save data from external SD card
# author=NekoMichi

echo "===Restore Saves (Test)==="

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

# Overrides permissions on folders
chmod -R 777 $EXTPATH
chmod -R 777 $INTPATH

# Sets alias
alias tres="rsync --inplace -nrtvh"

# Restores FCEUX data
if [ -d $EXTPATH/fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.fceux/sav $INTPATH/.fceux/fcs
	fi
	echo "Imported FCEUX files:"
	tres $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
	tres $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.gambatte/saves
	fi
	echo "Imported Gambatte files:"
	tres $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores OhBoy data
if [ -d $EXTPATH/ohboy/ ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.ohboy/saves
	fi
	echo "Imported OhBoy files:"
	tres $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Imported ReGBA files:"
	tres --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.pcsx4all/memcards $INTPATH/.pcsx4all/sstates
	fi
	echo "Imported PCSX4all files:"
	tres $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	tres $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.picodrive/mds $INTPATH/.picodrive/srm
	fi
	echo "Imported PicoDrive files:"
	tres $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
	tres $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Restores SMS Plus data
if [ -d $EXTPATH/smsplus/ ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.smsplus/sram $INTPATH/.smsplus/state
	fi
	echo "Imported SMS Plus files:"
	tres $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
	tres $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
fi

if [ -d $EXTPATH/sms_sdl/ ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sms_sdl/sram $INTPATH/.sms_sdl/state
	fi
	echo "Imported SMS SDL files:"
	tres $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
	tres $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
fi

# Restores PocketSNES data
if [ -d $EXTPATH/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Imported SNES96 files:"
	tres --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Imported PocketSNES files:"
	tres --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
fi

# Restores Snes9x data
if [ -d $EXTPATH/snes9x/ ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.snes9x/spc $INTPATH/.snes9x/sram
	fi
	echo "Imported Snes9x files:"
	tres $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
	tres $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
fi

# Restores SwanEmu data
if [ -d $EXTPATH/swanemu/ ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.swanemu/eeprom $INTPATH/.swanemu/sstates
	fi
	echo "Imported SwanEmu files:"
	tres $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
	tres $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
fi

# Restores Temper data
if [ -d $EXTPATH/temper/ ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.temper/bram $INTPATH/.temper/save_states
	fi
	echo "Imported Temper files:"
	tres $EXTPATH/temper/bram/ $INTPATH/.temper/bram
	tres $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
fi

# Restores Devilution/Diablo data
if [ -d $EXTPATH/.local/share/diasurgical/devilution/ ]; then
	if [ ! -d $INTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Devilution folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/diasurgical/devilution/
	fi
	echo "Restoring Devilution data..."
	tres $EXTPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
	tres $EXTPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
fi

# Restores Scummvm data
if [ -d $EXTPATH/.local/share/scummvm/saves/ ]; then
	if [! -d $INTPATH/.local/share/scummvm/saves/ ]; then
		echo "Scummvm backup folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/scummvm/saves/
	fi
	echo "Restoring Scummvm data..."
	tres $EXTPATH/.local/share/scummvm/saves/ $INTPATH/.local/share/scummvm/saves/
	tres $EXTPATH/.scummvmrc $INTPATH/
fi

# Restores Ur-Quan Masters (Starcon2 port) data
if [ -d $EXTPATH/.uqm/ ]; then
	if [ ! -d $INTPATH/.uqm/ ]; then
		echo "Ur-Quan Masters backup folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.uqm/
	fi
	echo "Restoring Ur-Quan Masters data..."
	tres $EXTPATH/.uqm/* $INTPATH/.uqm/
fi

# Restores Atari800 data
if [ -d $EXTPATH/.atari/ ]; then
	if [ ! -d $INTPATH/.atari/ ]; then
		echo "Atari800 backup folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.atari/
	fi
	echo "Restoring Atari800 data..."
	tres $EXTPATH/.atari/* $INTPATH/.atari/
	tres $EXTPATH/.atari800.cfg $INTPATH/
fi

# Restores OpenDune data
if [ -d $EXTPATH/.opendune/save/ ]; then
	if [ ! -d $INTPATH/.opendune/save/ ]; then
		echo "OpenDune folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.opendune/save/
	fi
	echo "Restoring OpenDune data..."
	tres $EXTPATH/.opendune/save/* $INTPATH/.opendune/save/
fi

# Restores OpenLara data
if [ -d $EXTPATH/.openlara/ ]; then
	if [ ! -d $INTPATH/.openlara/ ]; then
		echo "OpenLara backup folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.openlara/
	fi
	echo "Restoring OpenLara data..."
	tres $EXTPATH/.openlara/savegame.dat $INTPATH/.openlara/savegame.dat
fi

# Restores GCW Connect data
if [ -d $EXTPATH/.local/share/gcwconnect/networks/ ]; then
	if [ ! -d $INTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "GCW Connect backup folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/gcwconnect/networks/
	fi
	echo "Restoring GCW Connect data..."
	tres $EXTPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
fi

# Restore Super Mario 64 Port data
if [ -d $EXTPATH/.sm64-port/ ]; then
	if [ ! -d $INTPATH/.sm64-port/ ]; then
		echo "Super Mario 64 folder doesn't exist, creating folder."
		mkdir -p $INTPATH/.sm64-port/
	fi
	echo "Restoring Super Mario 64 data..."
	tres $EXTPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
fi

echo ""
echo "Debug restore complete."
echo "Report saved to ~/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
