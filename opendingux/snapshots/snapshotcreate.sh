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

# Create timestamp
TIMESTAMP="SNAPSHOT_"$(date +%Y-%m-%d_%H-%M-%S)" SNAP"
EXPORTPATH=$SNAPSHOTPATH/$TIMESTAMP
mkdir "$EXPORTPATH"
chmod -R 777 "$EXPORTPATH"

# Backs up FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	mkdir "$EXPORTPATH/fceux"
	mkdir "$EXPORTPATH/fceux/sav"
	mkdir "$EXPORTPATH/fceux/fcs"
	echo "Backing up FCEUX data..."
	rsync -rtvhW $INTPATH/.fceux/sav/ "$EXPORTPATH/fceux/sav"
	rsync -rtvhW $INTPATH/.fceux/fcs/ "$EXPORTPATH/fceux/fcs"
fi

# Backs up Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	mkdir "$EXPORTPATH/gambatte"
	mkdir "$EXPORTPATH/gambatte/saves"
	echo "Backing up Gambatte data..."
	rsync -rtvhW $INTPATH/.gambatte/saves/ "$EXPORTPATH/gambatte/saves"
fi

# Backs up OhBoy data
if [ -d $INTPATH/.ohboy/ ]; then
	mkdir "$EXPORTPATH/ohboy"
	mkdir "$EXPORTPATH/ohboy/saves"
	echo "Backing up OhBoy data..."
	rsync -rtvhW $INTPATH/.ohboy/saves/ "$EXPORTPATH/ohboy/saves"
fi

# Backs up ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	mkdir "$EXPORTPATH/gpsp"
	echo "Backing up ReGBA data..."
	rsync -rtvhW $INTPATH/.gpsp/ "$EXPORTPATH/gpsp"
fi

# Backs up PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	mkdir "$EXPORTPATH/pcsx4all"
	mkdir "$EXPORTPATH/pcsx4all/memcards"
	mkdir "$EXPORTPATH/pcsx4all/sstates"
	echo "Backing up PCSX4all data..."
	rsync -rtvhW $INTPATH/.pcsx4all/memcards/ "$EXPORTPATH/pcsx4all/memcards"
	rsync -rtvhW $INTPATH/.pcsx4all/sstates/ "$EXPORTPATH/pcsx4all/sstates"
fi

# Backs up Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	mkdir "$EXPORTPATH/picodrive"
	mkdir "$EXPORTPATH/picodrive/mds"
	mkdir "$EXPORTPATH/picodrive/srm"
	echo "Backing up PicoDrive data..."
	rsync -rtvhW $INTPATH/.picodrive/mds/ "$EXPORTPATH/picodrive/mds"
	rsync -rtvhW $INTPATH/.picodrive/srm/ "$EXPORTPATH/picodrive/srm"
fi

# Backs up SMS Plus data
if [ -d $INTPATH/.smsplus/ ]; then
	mkdir "$EXPORTPATH/smsplus"
	mkdir "$EXPORTPATH/smsplus/sram"
	mkdir "$EXPORTPATH/smsplus/state"
	echo "Backing up SMS Plus data..."
	rsync -rtvhW $INTPATH/.smsplus/sram/ "$EXPORTPATH/smsplus/sram"
	rsync -rtvhW $INTPATH/.smsplus/state/ "$EXPORTPATH/smsplus/state"
fi

if [ -d $INTPATH/.sms_sdl/ ]; then
	mkdir "$EXPORTPATH/sms_sdl"
	mkdir "$EXPORTPATH/sms_sdl/sram"
	mkdir "$EXPORTPATH/sms_sdl/state"
	echo "Backing up SMS SDL data..."
	rsync -rtvhW $INTPATH/.sms_sdl/sram/ "$EXPORTPATH/sms_sdl/sram"
	rsync -rtvhW $INTPATH/.sms_sdl/state/ "$EXPORTPATH/sms_sdl/state"
fi

# Backs up PocketSNES data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	mkdir "$EXPORTPATH/snes96_snapshots"
	echo "Backing up SNES96 data..."
	rsync -rtvhW $INTPATH/.snes96_snapshots/ "$EXPORTPATH/snes96_snapshots"
fi

if [ -d $INTPATH/.pocketsnes/ ]; then
	mkdir "$EXPORTPATH/pocketsnes"
	echo "Backing up PocketSNES data..."
	rsync -rtvhW $INTPATH/.pocketsnes/ "$EXPORTPATH/pocketsnes"
fi

# Backs up Snes9x data
if [ -d $INTPATH/.snes9x/ ]; then
	mkdir "$EXPORTPATH/snes9x"
	mkdir "$EXPORTPATH/snes9x/spc"
	mkdir "$EXPORTPATH/snes9x/sram"
	echo "Backing up Snes9x data..."
	rsync -rtvhW $INTPATH/.snes9x/spc/ "$EXPORTPATH/snes9x/spc"
	rsync -rtvhW $INTPATH/.snes9x/sram/ "$EXPORTPATH/snes9x/sram"
fi

# Backs up SwanEmu data
if [ -d $INTPATH/.swanemu/ ]; then
	mkdir "$EXPORTPATH/swanemu"
	mkdir "$EXPORTPATH/swanemu/eeprom"
	mkdir "$EXPORTPATH/swanemu/sstates"
	echo "Backing up SwanEmu data..."
	rsync -rtvhW $INTPATH/.swanemu/eeprom/ "$EXPORTPATH/swanemu/eeprom"
	rsync -rtvhW $INTPATH/.swanemu/sstates/ "$EXPORTPATH/swanemu/sstates"
fi

# Backs up Temper data
if [ -d $INTPATH/.temper/ ]; then
	mkdir "$EXPORTPATH/temper"
	mkdir "$EXPORTPATH/temper/bram"
	mkdir "$EXPORTPATH/temper/save_states"
	echo "Backing up Temper data..."
	rsync -rtvhW $INTPATH/.temper/bram/ "$EXPORTPATH/temper/bram"
	rsync -rtvhW $INTPATH/.temper/save_states/ "$EXPORTPATH/temper/save_states"
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Snapshot Complete" --msgbox "Snapshot saved to \n\n$SNAPSHOTPATH/\n$TIMESTAMP\n\nPress START to exit." 10 43
exit
