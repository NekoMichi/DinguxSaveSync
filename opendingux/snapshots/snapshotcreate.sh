#!/bin/sh
# title=Create Snapshot
# desc=Write snapshot to external SD card
# author=NekoMichi

echo "===Creating Snapshot==="

SNAPSHOTPATH="$SDPATH/backupsnapshots"

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if snapshot folder exists on card 2, if not then will create it
if [ ! -d $SNAPSHOTPATH/ ]; then
	echo "Snapshots folder doesn't exist, creating folder."
	mkdir $SNAPSHOTPATH
fi

# Overrides permissions on backup folder
chmod -R 777 $SNAPSHOTPATH

# Sets alias
alias bac="rsync --inplace -rtvh"

# Create timestamp
TIMESTAMP="SNAPSHOT_"$(date +%Y-%m-%d_%H-%M-%S)" SNAP"
EXPORTPATH=$SNAPSHOTPATH/$TIMESTAMP
mkdir "$EXPORTPATH"
chmod -R 777 "$EXPORTPATH"

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	mkdir -p "$EXPORTPATH/fceux/sav" "$EXPORTPATH/fceux/fcs"
	echo "Backing up FCEUX data..."
	bac $INTPATH/.fceux/sav/ "$EXPORTPATH/fceux/sav"
	bac $INTPATH/.fceux/fcs/ "$EXPORTPATH/fceux/fcs"
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	mkdir -p "$EXPORTPATH/gambatte/saves"
	echo "Backing up Gambatte data..."
	bac $INTPATH/.gambatte/saves/ "$EXPORTPATH/gambatte/saves"
fi

# Backs up OhBoy data
if [ -d $INTPATH/.ohboy/ ]; then
	mkdir -p "$EXPORTPATH/ohboy/saves"
	echo "Backing up OhBoy data..."
	bac $INTPATH/.ohboy/saves/ "$EXPORTPATH/ohboy/saves"
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	mkdir "$EXPORTPATH/gpsp"
	echo "Backing up ReGBA data..."
	bac $INTPATH/.gpsp/ "$EXPORTPATH/gpsp"
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	mkdir -p "$EXPORTPATH/pcsx4all/memcards" "$EXPORTPATH/pcsx4all/sstates"
	echo "Backing up PCSX4all data..."
	bac $INTPATH/.pcsx4all/memcards/ "$EXPORTPATH/pcsx4all/memcards"
	bac $INTPATH/.pcsx4all/sstates/ "$EXPORTPATH/pcsx4all/sstates"
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	mkdir -p "$EXPORTPATH/picodrive/mds" "$EXPORTPATH/picodrive/srm"
	echo "Backing up PicoDrive data..."
	bac $INTPATH/.picodrive/mds/ "$EXPORTPATH/picodrive/mds"
	bac $INTPATH/.picodrive/srm/ "$EXPORTPATH/picodrive/srm"
fi

# Backs up SMS Plus data
if [ -d $INTPATH/.smsplus/ ]; then
	mkdir -p "$EXPORTPATH/smsplus/sram" "$EXPORTPATH/smsplus/state"
	echo "Backing up SMS Plus data..."
	bac $INTPATH/.smsplus/sram/ "$EXPORTPATH/smsplus/sram"
	bac $INTPATH/.smsplus/state/ "$EXPORTPATH/smsplus/state"
fi

if [ -d $INTPATH/.sms_sdl/ ]; then
	mkdir -p "$EXPORTPATH/sms_sdl/sram" "$EXPORTPATH/sms_sdl/state"
	echo "Backing up SMS SDL data..."
	bac $INTPATH/.sms_sdl/sram/ "$EXPORTPATH/sms_sdl/sram"
	bac $INTPATH/.sms_sdl/state/ "$EXPORTPATH/sms_sdl/state"
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	mkdir "$EXPORTPATH/snes96_snapshots"
	echo "Backing up SNES96 data..."
	bac $INTPATH/.snes96_snapshots/ "$EXPORTPATH/snes96_snapshots"
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	mkdir "$EXPORTPATH/pocketsnes"
	echo "Backing up PocketSNES data..."
	bac $INTPATH/.pocketsnes/ "$EXPORTPATH/pocketsnes"
fi

# Backs up Snes9x data
if [ -d $INTPATH/.snes9x/ ]; then
	mkdir -p "$EXPORTPATH/snes9x/spc" "$EXPORTPATH/snes9x/sram"
	echo "Backing up Snes9x data..."
	bac $INTPATH/.snes9x/spc/ "$EXPORTPATH/snes9x/spc"
	bac $INTPATH/.snes9x/sram/ "$EXPORTPATH/snes9x/sram"
fi

# Backs up SwanEmu data
if [ -d $INTPATH/.swanemu/ ]; then
	mkdir -p "$EXPORTPATH/swanemu/eeprom" "$EXPORTPATH/swanemu/sstates"
	echo "Backing up SwanEmu data..."
	bac $INTPATH/.swanemu/eeprom/ "$EXPORTPATH/swanemu/eeprom"
	bac $INTPATH/.swanemu/sstates/ "$EXPORTPATH/swanemu/sstates"
fi

# Backs up Temper data
if [ -d $INTPATH/.temper/ ]; then
	mkdir -p "$EXPORTPATH/temper/bram" "$EXPORTPATH/temper/save_states"
	echo "Backing up Temper data..."
	bac $INTPATH/.temper/bram/ "$EXPORTPATH/temper/bram"
	bac $INTPATH/.temper/save_states/ "$EXPORTPATH/temper/save_states"
fi

# Backs up Devilution/Diablo data
if [ -d $INTPATH/.local/share/diasurgical/devilution/ ]; then
	mkdir -p $EXPORTPATH/.local/share/diasurgical/devilution/
	echo "Backing up Devilution data..."
	bac $INTPATH/.local/share/diasurgical/devilution/*.sv $EXPORTPATH/.local/share/diasurgical/devilution/
	bac $INTPATH/.local/share/diasurgical/devilution/*.ini $EXPORTPATH/.local/share/diasurgical/devilution/
fi

# Backs up Scummvm data
if [ -d $INTPATH/.local/share/scummvm/saves/ ]; then
	mkdir -p $EXPORTPATH/.local/share/scummvm/saves/
	echo "Backing up Scummvm data..."
	bac $INTPATH/.local/share/scummvm/saves/ $EXPORTPATH/.local/share/scummvm/saves/
	bac $INTPATH/.scummvmrc $EXPORTPATH/
fi

# Backs up Ur-Quan Masters (Starcon2 port) data
if [ -d $INTPATH/.uqm/ ]; then
	mkdir -p $EXPORTPATH/.uqm/
	echo "Backing up Ur-Quan Masters data..."
	bac $INTPATH/.uqm/* $EXPORTPATH/.uqm/
fi

# Backs up Atari800 data
if [ -d $INTPATH/.atari/ ]; then
	mkdir -p $EXPORTPATH/.atari/
	echo "Backing up Atari800 data..."
	bac $INTPATH/.atari/* $EXPORTPATH/.atari/
	bac $INTPATH/.atari800.cfg $EXPORTPATH/
fi

# Backs up OpenDune data
if [ -d $INTPATH/.opendune/save/ ]; then
	mkdir -p $EXPORTPATH/.opendune/save/
	echo "Backing up OpenDune data..."
	bac $INTPATH/.opendune/save/* $EXPORTPATH/.opendune/save/
fi

# Backs up OpenLara data
if [ -d $INTPATH/.openlara/ ]; then
	mkdir -p $EXPORTPATH/.openlara/
	echo "Backing up OpenLara data..."
	bac $INTPATH/.openlara/savegame.dat $EXPORTPATH/.openlara/savegame.dat
fi

# Backs up GCW Connect data
if [ -d $INTPATH/.local/share/gcwconnect/networks/ ]; then
	mkdir -p $EXPORTPATH/.local/share/gcwconnect/networks/
	echo "Backing up GCW Connect data..."
	bac $INTPATH/.local/share/gcwconnect/networks/* $EXPORTPATH/.local/share/gcwconnect/networks/
fi

# Backs up Super Mario 64 Port data
if [ -d $INTPATH/.sm64-port/ ]; then
	mkdir -p $EXTPATH/.sm64-port/
	echo "Backing up Super Mario 64 data..."
	bac $INTPATH/.sm64-port/sm64_save_file.bin $EXPORTPATH/.sm64-port/
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Snapshot Complete" --msgbox "Snapshot saved to \n\n$SNAPSHOTPATH/\n$TIMESTAMP\n\nPress START to exit." 10 43
exit
