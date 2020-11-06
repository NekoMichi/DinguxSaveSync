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

# Overrides permissions on folders
chmod -R 777 $EXTPATH
chmod -R 777 $INTPATH

# Sets alias
alias tsyn="rsync --update --inplace -nrtvh"

# Backs up screenshots
if [ -d $INTPATH/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Exported screenshots:"
	rsync -nrtvh --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/fceux/ ]; then
		echo "Exported FCEUX files:"
		tsyn $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		tsyn $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
		echo "Imported FCEUX files:"
		tsyn $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		tsyn $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/fceux/sav $EXTPATH/fceux/fcs
		echo "Exported FCEUX files:"
		tsyn $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		tsyn $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
	fi
else
	if [ -d $EXTPATH/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.fceux/sav $INTPATH/.fceux/fcs
		echo "Imported FCEUX files:"
		tsyn $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		tsyn $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Exported Gambatte files:"
		tsyn $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
		echo "Imported Gambatte files:"
		tsyn $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/gambatte/saves
		echo "Exported Gambatte files:"
		tsyn $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
	fi
else
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.gambatte/saves
		echo "Imported Gambatte files:"
		tsyn $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	fi
fi

# Syncs OhBoy data
if [ -d $INTPATH/.ohboy/ ]; then
	if [ -d $EXTPATH/ohboy/ ]; then
		echo "Exported OhBoy files:"
		tsyn $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
		echo "Imported OhBoy files:"
		tsyn $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
	else
		echo "OhBoy backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/ohboy/saves
		echo "Exported OhBoy files:"
		tsyn $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
	fi
else
	if [ -d $EXTPATH/ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.ohboy/saves
		echo "Imported OhBoy files:"
		tsyn $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "Exported ReGBA files:"
		tsyn $INTPATH/.gpsp/ $EXTPATH/gpsp
		echo "Imported ReGBA files:"
		tsyn --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
		echo "Exported ReGBA files:"
		tsyn $INTPATH/.gpsp/ $EXTPATH/gpsp
	fi
else
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Imported ReGBA files:"
		tsyn --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "Exported PCSX4all files:"
		tsyn $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		tsyn $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
		echo "Imported PCSX4all files:"
		tsyn $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		tsyn $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/pcsx4all/memcards $EXTPATH/pcsx4all/sstates
		echo "Exported PCSX4all files:"
		tsyn $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		tsyn $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
	fi
else
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.pcsx4all/memcards $INTPATH/.pcsx4all/sstates
		echo "Imported PCSX4all files:"
		tsyn $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		tsyn $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "Exported Picodrive files:"
		tsyn $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		tsyn $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
		echo "Imported Picodrive files:"
		tsyn $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		tsyn $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/picodrive/mds $EXTPATH/picodrive/srm
		echo "Exported Picodrive files:"
		tsyn $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		tsyn $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
	fi
else
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.picodrive/mds $INTPATH/.picodrive/srm
		echo "Imported Picodrive files:"
		tsyn $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		tsyn $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	fi
fi

# Syncs SMS Plus data
if [ -d $INTPATH/.smsplus/ ]; then
	if [ -d $EXTPATH/smsplus/ ]; then
		echo "Exported SMS Plus files:"
		tsyn $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
		tsyn $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
		echo "Imported SMS Plus files:"
		tsyn $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
		tsyn $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
	else
		echo "SMS Plus backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/smsplus/sram $EXTPATH/smsplus/state
		echo "Exported SMS Plus files:"
		tsyn $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
		tsyn $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
	fi
else
	if [ -d $EXTPATH/smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.smsplus/sram $INTPATH/.smsplus/state
		echo "Imported SMS Plus files:"
		tsyn $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
		tsyn $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
	fi
fi

if [ -d $INTPATH/.sms_sdl/ ]; then
	if [ -d $EXTPATH/sms_sdl/ ]; then
		echo "Exported SMS SDL files:"
		tsyn $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
		tsyn $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
		echo "Imported SMS SDL files:"
		tsyn $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
		tsyn $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
	else
		echo "SMS SDL backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/sms_sdl/sram $EXTPATH/sms_sdl/state
		echo "Exported SMS SDL files:"
		tsyn $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
		tsyn $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
	fi
else
	if [ -d $EXTPATH/sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sms_sdl/sram $INTPATH/.sms_sdl/state
		echo "Imported SMS SDL files:"
		tsyn $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
		tsyn $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "Exported SNES96 files:"
		tsyn $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
		echo "Imported SNES96 files:"
		tsyn --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
		echo "Exported SNES96 files:"
		tsyn $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
	fi
else
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Imported SNES96 files:"
		tsyn --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "Exported PocketSNES files:"
		tsyn $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
		echo "Imported PocketSNES files:"
		tsyn --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
		echo "Exported PocketSNES files:"
		tsyn $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
	fi
else
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Imported PocketSNES files:"
		tsyn --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

# Syncs Snes9x data
if [ -d $INTPATH/.snes9x/ ]; then
	if [ -d $EXTPATH/snes9x/ ]; then
		echo "Exported Snes9x files:"
		tsyn $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
		tsyn $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
		echo "Imported Snes9x files:"
		tsyn $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
		tsyn $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
	else
		echo "Snes9x backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/snes9x/spc $EXTPATH/snes9x/sram
		echo "Exported Snes9x files:"
		tsyn $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
		tsyn $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
	fi
else
	if [ -d $EXTPATH/snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.snes9x/spc $INTPATH/.snes9x/sram
		echo "Imported Snes9x files:"
		tsyn $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
		tsyn $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
	fi
fi

# Syncs SwanEmu data
if [ -d $INTPATH/.swanemu/ ]; then
	if [ -d $EXTPATH/swanemu/ ]; then
		echo "Exported SwanEmu files:"
		tsyn $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
		tsyn $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
		echo "Imported SwanEmu files:"
		tsyn $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
		tsyn $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
	else
		echo "SwanEmu backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/swanemu/eeprom $EXTPATH/swanemu/sstates
		echo "Exported SwanEmu files:"
		tsyn $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
		tsyn $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
	fi
else
	if [ -d $EXTPATH/swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.swanemu/eeprom $INTPATH/.swanemu/sstates
		echo "Imported SwanEmu files:"
		tsyn $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
		tsyn $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
	fi
fi

# Syncs Temper data
if [ -d $INTPATH/.temper/ ]; then
	if [ -d $EXTPATH/temper/ ]; then
		echo "Exported Temper files:"
		tsyn $INTPATH/.temper/bram/ $EXTPATH/temper/bram
		tsyn $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
		echo "Imported Temper files:"
		tsyn $EXTPATH/temper/bram/ $INTPATH/.temper/bram
		tsyn $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
	else
		echo "Temper backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/temper/bram $EXTPATH/temper/save_states
		echo "Exported Temper files:"
		tsyn $INTPATH/.temper/bram/ $EXTPATH/temper/bram
		tsyn $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
	fi
else
	if [ -d $EXTPATH/temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.temper/bram $INTPATH/.temper/save_states
		echo "Imported Temper files:"
		tsyn $EXTPATH/temper/bram/ $INTPATH/.temper/bram
		tsyn $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
	fi
fi

# Syncs Devilution/Diablo data
if [ -d $INTPATH/.local/share/diasurgical/devilution/ ]; then
	if [ -d $EXTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Syncing Devilution data..."
		tsyn $INTPATH/.local/share/diasurgical/devilution/*.sv $EXTPATH/.local/share/diasurgical/devilution/
		tsyn $INTPATH/.local/share/diasurgical/devilution/*.ini $EXTPATH/.local/share/diasurgical/devilution/
		tsyn $EXTPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
		tsyn $EXTPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
	else
		echo "Devilution backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.local/share/diasurgical/devilution/
		echo "Syncing Devilution data..."
		tsyn $INTPATH/.local/share/diasurgical/devilution/*.sv $EXTPATH/.local/share/diasurgical/devilution/
		tsyn $INTPATH/.local/share/diasurgical/devilution/*.ini $EXTPATH/.local/share/diasurgical/devilution/
	fi
else
	if [ -d $EXTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Devilution folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/diasurgical/devilution/
		echo "Syncing Devilution data..."
		tsyn $EXTPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
		tsyn $EXTPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
	fi
fi

# Syncs Scummvm data
if [ -d $INTPATH/.local/share/scummvm/saves/ ]; then
	if [ -d $EXTPATH/.local/share/scummvm/saves/ ]; then
		echo "Syncing Scummvm data..."
		tsyn $INTPATH/.local/share/scummvm/saves/* $EXTPATH/.local/share/scummvm/saves/
		tsyn $INTPATH/.scummvmrc $EXTPATH/
		tsyn $EXTPATH/.local/share/scummvm/saves/* $INTPATH/.local/share/scummvm/saves/
		tsyn $EXTPATH/.scummvmrc $INTPATH/
	else
		echo "Scummvm backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.local/share/scummvm/saves/
		echo "Syncing Scummvm data..."
		tsyn $INTPATH/.local/share/scummvm/saves/* $EXTPATH/.local/share/scummvm/saves/
		tsyn $INTPATH/.scummvmrc $EXTPATH/
	fi
else
	if [ -d $EXTPATH/.local/share/scummvm/saves/ ]; then
		echo "Scummvm folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/scummvm/saves/
		echo "Syncing Scummvm data..."
		tsyn $EXTPATH/.local/share/scummvm/saves/* $INTPATH/.local/share/scummvm/saves/
		tsyn $EXTPATH/.scummvmrc $INTPATH/
	fi
fi

# Syncs Ur-Quan Masters (Starcon2 port) data
if [ -d $INTPATH/.uqm/ ]; then
	if [ -d $EXTPATH/.uqm/ ]; then
		echo "Syncing Ur-Quan Masters data..."
		tsyn $INTPATH/.uqm/* $EXTPATH/.uqm/
		tsyn $EXTPATH/.uqm/* $INTPATH/.uqm/
	else
		echo "Ur-Quan Masters backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.uqm/
		echo "Syncing Ur-Quan Masters data..."
		tsyn $INTPATH/.uqm/* $EXTPATH/.uqm/
	fi
else
	if [ -d $EXTPATH/.uqm/ ]; then
		echo "Ur-Quan Masters folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.uqm/
		echo "Syncing Ur-Quan Masters data..."
		tsyn $EXTPATH/.uqm/* $INTPATH/.uqm/
	fi
fi

# Syncs Atari800 data
if [ -d $INTPATH/.atari/ ]; then
	if [ -d $EXTPATH/.atari/ ]; then
		echo "Syncing Atari800 data..."
		tsyn $INTPATH/.atari/* $EXTPATH/.atari/
		tsyn $INTPATH/.atari800.cfg $EXTPATH/
		tsyn $EXTPATH/.atari/* $INTPATH/.atari/
		tsyn $EXTPATH/.atari800.cfg $INTPATH/
	else
		echo "Atari800 backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.atari/
		echo "Syncing Atari800 data..."
		tsyn $INTPATH/.atari/* $EXTPATH/.atari/
		tsyn $INTPATH/.atari800.cfg $EXTPATH/
	fi
else
	if [ -d $EXTPATH/.atari/ ]; then
		echo "Atari800 folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.atari/
		echo "Syncing Atari800 data..."
		tsyn $EXTPATH/.atari/* $INTPATH/.atari/
		tsyn $EXTPATH/.atari800.cfg $INTPATH/
	fi
fi

# Syncs OpenDune data
if [ -d $INTPATH/.opendune/save/ ]; then
	if [ -d $EXTPATH/.opendune/save/ ]; then
		echo "Syncing OpenDune data..."
		tsyn $INTPATH/.opendune/save/* $EXTPATH/.opendune/save/
		tsyn $EXTPATH/.opendune/save/* $INTPATH/.opendune/save/
	else
		echo "OpenDune backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.opendune/save/
		echo "Syncing OpenDune data..."
		tsyn $INTPATH/.opendune/save/* $EXTPATH/.opendune/save/
	fi
else
	if [ -d $EXTPATH/.opendune/save/ ]; then
		echo "OpenDune folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.opendune/save/
		echo "Syncing OpenDune data..."
		tsyn $EXTPATH/.opendune/save/* $INTPATH/.opendune/save/
	fi
fi

# Syncs OpenLara data
if [ -d $INTPATH/.openlara/ ]; then
	if [ -d $EXTPATH/.openlara/ ]; then
		echo "Syncing OpenLara data..."
		tsyn $INTPATH/.openlara/savegame.dat $EXTPATH/.openlara/
		tsyn $EXTPATH/.openlara/savegame.dat $INTPATH/.openlara/
	else
		echo "OpenLara backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.openlara/
		echo "Syncing OpenLara data..."
		tsyn $INTPATH/.openlara/savegame.dat $EXTPATH/.openlara/
	fi
else
	if [ -d $EXTPATH/.openlara/ ]; then
		echo "OpenLara folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.openlara/
		echo "Syncing OpenLara data..."
		tsyn $EXTPATH/.openlara/savegame.dat $INTPATH/.openlara/
	fi
fi

# Syncs GCW Connect data
if [ -d $INTPATH/.local/share/gcwconnect/networks/ ]; then
	if [ -d $EXTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "Syncing GCW Connect data..."
		tsyn $INTPATH/.local/share/gcwconnect/networks/* $EXTPATH/.local/share/gcwconnect/networks/
		tsyn $EXTPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
	else
		echo "GCW Connect backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.local/share/gcwconnect/networks/
		echo "Syncing GCW Connect data..."
		tsyn $INTPATH/.local/share/gcwconnect/networks/* $EXTPATH/.local/share/gcwconnect/networks/
	fi
else
	if [ -d $EXTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "GCW Connect folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/gcwconnect/networks/
		echo "Syncing GCW Connect data..."
		tsyn $EXTPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
	fi
fi

# Syncs Super Mario 64 Port data
if [ -d $INTPATH/.sm64-port/ ]; then
	if [ -d $EXTPATH/.sm64-port/ ]; then
		echo "Syncing Super Mario 64 Port data..."
		tsyn $INTPATH/.sm64-port/sm64_save_file.bin $EXTPATH/.sm64-port/
		tsyn $EXTPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
	else
		echo "Super Mario 64 Port backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.sm64-port/
		echo "Syncing Super Mario 64 Port data..."
		tsyn $INTPATH/.sm64-port/sm64_save_file.bin $EXTPATH/.sm64-port/
	fi
else
	if [ -d $EXTPATH/.sm64-port/ ]; then
		echo "Super Mario 64 Port folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sm64-port/
		echo "Syncing Super Mario 64 Port data..."
		tsyn $EXTPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
	fi
fi

echo ""
echo "Debug sync complete."
echo "Report saved to ~/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
