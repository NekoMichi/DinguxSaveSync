#!/bin/sh
# title=Save Sync
# desc=Syncs save data with external SD card
# author=NekoMichi

echo "===Syncing Saves==="

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if backup folder exists on card 2, if not then will create it
if [ ! -d $EXTPATH/ ]; then
	echo "Backup folder doesn't exist, creating folder."
	mkdir $EXTPATH
fi

# Overrides permissions on folders
chmod -R 777 $EXTPATH
chmod -R 777 $INTPATH

# Sets alias
alias syn="rsync --update --inplace -rtvh"

# Backs up screenshots
if [ -d /media/data/local/home/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Backing up screenshots..."
	rsync -rtvh --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/fceux/ ]; then
		echo "Syncing FCEUX data..."
		syn $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		syn $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
		syn $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		syn $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/fceux/sav $EXTPATH/fceux/fcs
		echo "Syncing FCEUX data..."
		syn $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		syn $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
	fi
else
	if [ -d $EXTPATH/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.fceux/sav $INTPATH/.fceux/fcs
		echo "Syncing FCEUX data..."
		syn $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		syn $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Syncing Gambatte data..."
		syn $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
		syn $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/gambatte/saves
		echo "Syncing Gambatte data..."
		syn $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
	fi
else
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.gambatte/saves
		echo "Syncing Gambatte data..."
		syn $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	fi
fi

# Syncs OhBoy data
if [ -d $INTPATH/.ohboy/ ]; then
	if [ -d $EXTPATH/ohboy/ ]; then
		echo "Syncing OhBoy data..."
		syn $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
		syn $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
	else
		echo "OhBoy backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/ohboy/saves
		echo "Syncing OhBoy data..."
		syn $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
	fi
else
	if [ -d $EXTPATH/ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.ohboy/saves
		echo "Syncing OhBoy data..."
		syn $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "Syncing ReGBA data..."
		syn $INTPATH/.gpsp/ $EXTPATH/gpsp
		syn --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
		echo "Syncing ReGBA data..."
		syn $INTPATH/.gpsp/ $EXTPATH/gpsp
	fi
else
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Syncing ReGBA data..."
		syn --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "Syncing PCSX4all data..."
		syn $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		syn $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
		syn $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		syn $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/pcsx4all/memcards $EXTPATH/pcsx4all/sstates
		echo "Syncing PCSX4all data..."
		syn $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		syn $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
	fi
else
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.pcsx4all/memcards $INTPATH/.pcsx4all/sstates
		echo "Syncing PCSX4all data..."
		syn $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		syn $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "Syncing PicoDrive data..."
		syn $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		syn $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
		syn $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		syn $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/picodrive/mds $EXTPATH/picodrive/srm
		echo "Syncing PicoDrive data..."
		syn $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		syn $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
	fi
else
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.picodrive/mds $INTPATH/.picodrive/srm
		echo "Syncing PicoDrive data..."
		syn $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		syn $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	fi
fi

# Syncs SMS Plus data
if [ -d $INTPATH/.smsplus/ ]; then
	if [ -d $EXTPATH/smsplus/ ]; then
		echo "Syncing SMS Plus data..."
		syn $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
		syn $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
		syn $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
		syn $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
	else
		echo "SMS Plus backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/smsplus/sram $EXTPATH/smsplus/state
		echo "Syncing SMS Plus data..."
		syn $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
		syn $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
	fi
else
	if [ -d $EXTPATH/smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.smsplus/sram $INTPATH/.smsplus/state
		echo "Syncing SMS Plus data..."
		syn $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
		syn $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
	fi
fi

if [ -d $INTPATH/.sms_sdl/ ]; then
	if [ -d $EXTPATH/sms_sdl/ ]; then
		echo "Syncing SMS SDL data..."
		syn $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
		syn $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
		syn $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
		syn $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
	else
		echo "SMS SDL backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/sms_sdl/sram $EXTPATH/sms_sdl/state
		echo "Syncing SMS SDL data..."
		syn $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
		syn $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
	fi
else
	if [ -d $EXTPATH/sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sms_sdl/sram $INTPATH/.sms_sdl/state
		echo "Syncing SMS SDL data..."
		syn $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
		syn $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "Syncing SNES96 data..."
		syn $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
		syn --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
		echo "Syncing SNES96 data..."
		syn $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
	fi
else
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Syncing SNES96 data..."
		syn --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "Syncing PocketSNES data..."
		syn $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
		syn --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
		echo "Syncing PocketSNES data..."
		syn $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
	fi
else
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Syncing PocketSNES data..."
		syn --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

# Syncs Snes9x data
if [ -d $INTPATH/.snes9x/ ]; then
	if [ -d $EXTPATH/snes9x/ ]; then
		echo "Syncing Snes9x data..."
		syn $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
		syn $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
		syn $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
		syn $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
	else
		echo "Snes9x backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/snes9x/spc $EXTPATH/snes9x/sram
		echo "Syncing Snes9x data..."
		syn $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
		syn $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
	fi
else
	if [ -d $EXTPATH/snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.snes9x/spc $INTPATH/.snes9x/sram
		echo "Syncing Snes9x data..."
		syn $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
		syn $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
	fi
fi

# Syncs SwanEmu data
if [ -d $INTPATH/.swanemu/ ]; then
	if [ -d $EXTPATH/swanemu/ ]; then
		echo "Syncing SwanEmu data..."
		syn $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
		syn $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
		syn $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
		syn $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
	else
		echo "SwanEmu backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/swanemu/eeprom $EXTPATH/swanemu/sstates
		echo "Syncing SwanEmu data..."
		syn $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
		syn $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
	fi
else
	if [ -d $EXTPATH/swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.swanemu/eeprom $INTPATH/.swanemu/sstates
		echo "Syncing SwanEmu data..."
		syn $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
		syn $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
	fi
fi

# Syncs Temper data
if [ -d $INTPATH/.temper/ ]; then
	if [ -d $EXTPATH/temper/ ]; then
		echo "Syncing Temper data..."
		syn $INTPATH/.temper/bram/ $EXTPATH/temper/bram
		syn $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
		syn $EXTPATH/temper/bram/ $INTPATH/.temper/bram
		syn $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
	else
		echo "Temper backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/temper/bram $EXTPATH/temper/save_states
		echo "Syncing SneTempers9x data..."
		syn $INTPATH/.temper/bram/ $EXTPATH/temper/bram
		syn $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
	fi
else
	if [ -d $EXTPATH/temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.temper/bram $INTPATH/.temper/save_states
		echo "Syncing Temper data..."
		syn $EXTPATH/temper/bram/ $INTPATH/.temper/bram
		syn $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
	fi
fi

# Syncs Devilution/Diablo data
if [ -d $INTPATH/.local/share/diasurgical/devilution/ ]; then
	if [ -d $EXTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Syncing Devilution data..."
		syn $INTPATH/.local/share/diasurgical/devilution/*.sv $EXTPATH/.local/share/diasurgical/devilution/
		syn $INTPATH/.local/share/diasurgical/devilution/*.ini $EXTPATH/.local/share/diasurgical/devilution/
		syn $EXTPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
		syn $EXTPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
	else
		echo "Devilution backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.local/share/diasurgical/devilution/
		echo "Syncing Devilution data..."
		syn $INTPATH/.local/share/diasurgical/devilution/*.sv $EXTPATH/.local/share/diasurgical/devilution/
		syn $INTPATH/.local/share/diasurgical/devilution/*.ini $EXTPATH/.local/share/diasurgical/devilution/
	fi
else
	if [ -d $EXTPATH/.local/share/diasurgical/devilution/ ]; then
		echo "Devilution folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/diasurgical/devilution/
		echo "Syncing Devilution data..."
		syn $EXTPATH/.local/share/diasurgical/devilution/*.sv $INTPATH/.local/share/diasurgical/devilution/
		syn $EXTPATH/.local/share/diasurgical/devilution/*.ini $INTPATH/.local/share/diasurgical/devilution/
	fi
fi

# Syncs Scummvm data
if [ -d $INTPATH/.local/share/scummvm/saves/ ]; then
	if [ -d $EXTPATH/.local/share/scummvm/saves/ ]; then
		echo "Syncing Scummvm data..."
		syn $INTPATH/.local/share/scummvm/saves/* $EXTPATH/.local/share/scummvm/saves/
		syn $INTPATH/.scummvmrc $EXTPATH/
		syn $EXTPATH/.local/share/scummvm/saves/* $INTPATH/.local/share/scummvm/saves/
		syn $EXTPATH/.scummvmrc $INTPATH/
	else
		echo "Scummvm backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.local/share/scummvm/saves/
		echo "Syncing Scummvm data..."
		syn $INTPATH/.local/share/scummvm/saves/* $EXTPATH/.local/share/scummvm/saves/
		syn $INTPATH/.scummvmrc $EXTPATH/
	fi
else
	if [ -d $EXTPATH/.local/share/scummvm/saves/ ]; then
		echo "Scummvm folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/scummvm/saves/
		echo "Syncing Scummvm data..."
		syn $EXTPATH/.local/share/scummvm/saves/* $INTPATH/.local/share/scummvm/saves/
		syn $EXTPATH/.scummvmrc $INTPATH/
	fi
fi

# Syncs Ur-Quan Masters (Starcon2 port) data
if [ -d $INTPATH/.uqm/ ]; then
	if [ -d $EXTPATH/.uqm/ ]; then
		echo "Syncing Ur-Quan Masters data..."
		syn $INTPATH/.uqm/* $EXTPATH/.uqm/
		syn $EXTPATH/.uqm/* $INTPATH/.uqm/
	else
		echo "Ur-Quan Masters backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.uqm/
		echo "Syncing Ur-Quan Masters data..."
		syn $INTPATH/.uqm/* $EXTPATH/.uqm/
	fi
else
	if [ -d $EXTPATH/.uqm/ ]; then
		echo "Ur-Quan Masters folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.uqm/
		echo "Syncing Ur-Quan Masters data..."
		syn $EXTPATH/.uqm/* $INTPATH/.uqm/
	fi
fi

# Syncs Atari800 data
if [ -d $INTPATH/.atari/ ]; then
	if [ -d $EXTPATH/.atari/ ]; then
		echo "Syncing Atari800 data..."
		syn $INTPATH/.atari/* $EXTPATH/.atari/
		syn $INTPATH/.atari800.cfg $EXTPATH/
		syn $EXTPATH/.atari/* $INTPATH/.atari/
		syn $EXTPATH/.atari800.cfg $INTPATH/
	else
		echo "Atari800 backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.atari/
		echo "Syncing Atari800 data..."
		syn $INTPATH/.atari/* $EXTPATH/.atari/
		syn $INTPATH/.atari800.cfg $EXTPATH/
	fi
else
	if [ -d $EXTPATH/.atari/ ]; then
		echo "Atari800 folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.atari/
		echo "Syncing Atari800 data..."
		syn $EXTPATH/.atari/* $INTPATH/.atari/
		syn $EXTPATH/.atari800.cfg $INTPATH/
	fi
fi

# Syncs OpenDune data
if [ -d $INTPATH/.opendune/save/ ]; then
	if [ -d $EXTPATH/.opendune/save/ ]; then
		echo "Syncing OpenDune data..."
		syn $INTPATH/.opendune/save/* $EXTPATH/.opendune/save/
		syn $EXTPATH/.opendune/save/* $INTPATH/.opendune/save/
	else
		echo "OpenDune backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.opendune/save/
		echo "Syncing OpenDune data..."
		syn $INTPATH/.opendune/save/* $EXTPATH/.opendune/save/
	fi
else
	if [ -d $EXTPATH/.opendune/save/ ]; then
		echo "OpenDune folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.opendune/save/
		echo "Syncing OpenDune data..."
		syn $EXTPATH/.opendune/save/* $INTPATH/.opendune/save/
	fi
fi

# Syncs OpenLara data
if [ -d $INTPATH/.openlara/ ]; then
	if [ -d $EXTPATH/.openlara/ ]; then
		echo "Syncing OpenLara data..."
		syn $INTPATH/.openlara/savegame.dat $EXTPATH/.openlara/
		syn $EXTPATH/.openlara/savegame.dat $INTPATH/.openlara/
	else
		echo "OpenLara backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.openlara/
		echo "Syncing OpenLara data..."
		syn $INTPATH/.openlara/savegame.dat $EXTPATH/.openlara/
	fi
else
	if [ -d $EXTPATH/.openlara/ ]; then
		echo "OpenLara folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.openlara/
		echo "Syncing OpenLara data..."
		syn $EXTPATH/.openlara/savegame.dat $INTPATH/.openlara/
	fi
fi

# Syncs GCW Connect data
if [ -d $INTPATH/.local/share/gcwconnect/networks/ ]; then
	if [ -d $EXTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "Syncing GCW Connect data..."
		syn $INTPATH/.local/share/gcwconnect/networks/* $EXTPATH/.local/share/gcwconnect/networks/
		syn $EXTPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
	else
		echo "GCW Connect backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.local/share/gcwconnect/networks/
		echo "Syncing GCW Connect data..."
		syn $INTPATH/.local/share/gcwconnect/networks/* $EXTPATH/.local/share/gcwconnect/networks/
	fi
else
	if [ -d $EXTPATH/.local/share/gcwconnect/networks/ ]; then
		echo "GCW Connect folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.local/share/gcwconnect/networks/
		echo "Syncing GCW Connect data..."
		syn $EXTPATH/.local/share/gcwconnect/networks/* $INTPATH/.local/share/gcwconnect/networks/
	fi
fi

# Syncs Super Mario 64 Port data
if [ -d $INTPATH/.sm64-port/ ]; then
	if [ -d $EXTPATH/.sm64-port/ ]; then
		echo "Syncing Super Mario 64 Port data..."
		syn $INTPATH/.sm64-port/sm64_save_file.bin $EXTPATH/.sm64-port/
		syn $EXTPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
	else
		echo "Super Mario 64 Port backup folder doesn't exist, creating folder."
		mkdir -p $EXTPATH/.sm64-port/
		echo "Syncing Super Mario 64 Port data..."
		syn $INTPATH/.sm64-port/sm64_save_file.bin $EXTPATH/.sm64-port/
	fi
else
	if [ -d $EXTPATH/.sm64-port/ ]; then
		echo "Super Mario 64 Port folder doesn't exist in home directory, creating folder."
		mkdir -p $INTPATH/.sm64-port/
		echo "Syncing Super Mario 64 Port data..."
		syn $EXTPATH/.sm64-port/sm64_save_file.bin $INTPATH/.sm64-port/
	fi
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Sync Complete" --msgbox "Save sync complete.\nPress START to exit." 6 29
exit
