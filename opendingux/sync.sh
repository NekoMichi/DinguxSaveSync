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

# Backs up screenshots
if [ -d /media/data/local/home/screenshots/ ]; then
	if [ ! -d $EXTPATH/screenshots/ ]; then
		echo "Screenshots backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/screenshots
	fi
	echo "Backing up screenshots..."
	rsync -rtvhW --ignore-existing $INTPATH/screenshots/ $EXTPATH/screenshots
fi

# Syncs FCEUX data
if [ -d $INTPATH/.fceux/ ]; then
	if [ -d $EXTPATH/fceux/ ]; then
		echo "Syncing FCEUX data..."
		rsync --update -rtvhW $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		rsync --update -rtvhW $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
		rsync --update -rtvhW $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		rsync --update -rtvhW $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	else
		echo "FCEUX backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/fceux
		mkdir $EXTPATH/fceux/sav
		mkdir $EXTPATH/fceux/fcs
		echo "Syncing FCEUX data..."
		rsync --update -rtvhW $INTPATH/.fceux/sav/ $EXTPATH/fceux/sav
		rsync --update -rtvhW $INTPATH/.fceux/fcs/ $EXTPATH/fceux/fcs
	fi
else
	if [ -d $EXTPATH/fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		mkdir $INTPATH/.fceux/sav
		mkdir $INTPATH/.fceux/fcs
		echo "Syncing FCEUX data..."
		rsync --update -rtvhW $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
		rsync --update -rtvhW $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
	fi
fi

# Syncs Gambatte data
if [ -d $INTPATH/.gambatte/ ]; then
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Syncing Gambatte data..."
		rsync --update -rtvhW $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
		rsync --update -rtvhW $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	else
		echo "Gambatte backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gambatte
		mkdir $EXTPATH/gambatte/saves
		echo "Syncing Gambatte data..."
		rsync --update -rtvhW $INTPATH/.gambatte/saves/ $EXTPATH/gambatte/saves
	fi
else
	if [ -d $EXTPATH/gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		mkdir $INTPATH/.gambatte/saves
		echo "Syncing Gambatte data..."
		rsync --update -rtvhW $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
	fi
fi

# Syncs OhBoy data
if [ -d $INTPATH/.ohboy/ ]; then
	if [ -d $EXTPATH/ohboy/ ]; then
		echo "Syncing OhBoy data..."
		rsync --update -rtvhW $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
		rsync --update -rtvhW $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
	else
		echo "OhBoy backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/ohboy
		mkdir $EXTPATH/ohboy/saves
		echo "Syncing OhBoy data..."
		rsync --update -rtvhW $INTPATH/.ohboy/saves/ $EXTPATH/ohboy/saves
	fi
else
	if [ -d $EXTPATH/ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.ohboy
		mkdir $INTPATH/.ohboy/saves
		echo "Syncing OhBoy data..."
		rsync --update -rtvhW $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
	fi
fi

# Syncs ReGBA data
if [ -d $INTPATH/.gpsp/ ]; then
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "Syncing ReGBA data..."
		rsync --update -rtvhW $INTPATH/.gpsp/ $EXTPATH/gpsp
		rsync --update -rtvhW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	else
		echo "ReGBA backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtvhW $INTPATH/.gpsp/ $EXTPATH/gpsp
	fi
else
	if [ -d $EXTPATH/gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
		echo "Syncing ReGBA data..."
		rsync --update -rtvhW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
	fi
fi

# Syncs PCSX4all data
if [ -d $INTPATH/.pcsx4all/ ]; then
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "Syncing PCSX4all data..."
		rsync --update -rtvhW $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		rsync --update -rtvhW $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
		rsync --update -rtvhW $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		rsync --update -rtvhW $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	else
		echo "PCSX4all backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pcsx4all
		mkdir $EXTPATH/pcsx4all/memcards
		mkdir $EXTPATH/pcsx4all/sstates
		echo "Syncing PCSX4all data..."
		rsync --update -rtvhW $INTPATH/.pcsx4all/memcards/ $EXTPATH/pcsx4all/memcards
		rsync --update -rtvhW $INTPATH/.pcsx4all/sstates/ $EXTPATH/pcsx4all/sstates
	fi
else
	if [ -d $EXTPATH/pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		mkdir $INTPATH/.pcsx4all/memcards
		mkdir $INTPATH/.pcsx4all/sstates
		echo "Syncing PCSX4all data..."
		rsync --update -rtvhW $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
		rsync --update -rtvhW $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
	fi
fi

# Syncs Picodrive data
if [ -d $INTPATH/.picodrive/ ]; then
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "Syncing PicoDrive data..."
		rsync --update -rtvhW $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		rsync --update -rtvhW $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
		rsync --update -rtvhW $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		rsync --update -rtvhW $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	else
		echo "PicoDrive backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/picodrive
		mkdir $EXTPATH/picodrive/mds
		mkdir $EXTPATH/picodrive/srm
		echo "Syncing PicoDrive data..."
		rsync --update -rtvhW $INTPATH/.picodrive/mds/ $EXTPATH/picodrive/mds
		rsync --update -rtvhW $INTPATH/.picodrive/srm/ $EXTPATH/picodrive/srm
	fi
else
	if [ -d $EXTPATH/picodrive/ ]; then
		echo "PicoDrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		mkdir $INTPATH/.picodrive/mds
		mkdir $INTPATH/.picodrive/srm
		echo "Syncing PicoDrive data..."
		rsync --update -rtvhW $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
		rsync --update -rtvhW $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
	fi
fi

# Syncs SMS Plus data
if [ -d $INTPATH/.smsplus/ ]; then
	if [ -d $EXTPATH/smsplus/ ]; then
		echo "Syncing SMS Plus data..."
		rsync --update -rtvhW $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
		rsync --update -rtvhW $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
		rsync --update -rtvhW $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
		rsync --update -rtvhW $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
	else
		echo "SMS Plus backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/smsplus
		mkdir $EXTPATH/smsplus/sram
		mkdir $EXTPATH/smsplus/state
		echo "Syncing SMS Plus data..."
		rsync --update -rtvhW $INTPATH/.smsplus/sram/ $EXTPATH/smsplus/sram
		rsync --update -rtvhW $INTPATH/.smsplus/state/ $EXTPATH/smsplus/state
	fi
else
	if [ -d $EXTPATH/smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.smsplus
		mkdir $INTPATH/.smsplus/sram
		mkdir $INTPATH/.smsplus/state
		echo "Syncing SMS Plus data..."
		rsync --update -rtvhW $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
		rsync --update -rtvhW $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
	fi
fi

if [ -d $INTPATH/.sms_sdl/ ]; then
	if [ -d $EXTPATH/sms_sdl/ ]; then
		echo "Syncing SMS SDL data..."
		rsync --update -rtvhW $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
		rsync --update -rtvhW $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
		rsync --update -rtvhW $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
		rsync --update -rtvhW $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
	else
		echo "SMS SDL backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/sms_sdl
		mkdir $EXTPATH/sms_sdl/sram
		mkdir $EXTPATH/sms_sdl/state
		echo "Syncing SMS SDL data..."
		rsync --update -rtvhW $INTPATH/.sms_sdl/sram/ $EXTPATH/sms_sdl/sram
		rsync --update -rtvhW $INTPATH/.sms_sdl/state/ $EXTPATH/sms_sdl/state
	fi
else
	if [ -d $EXTPATH/sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.sms_sdl
		mkdir $INTPATH/.sms_sdl/sram
		mkdir $INTPATH/.sms_sdl/state
		echo "Syncing SMS SDL data..."
		rsync --update -rtvhW $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
		rsync --update -rtvhW $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
	fi
fi

# Syncs SNES96 data
if [ -d $INTPATH/.snes96_snapshots/ ]; then
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "Syncing SNES96 data..."
		rsync --update -rtvhW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
		rsync --update -rtvhW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	else
		echo "SNES96 backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtvhW $INTPATH/.snes96_snapshots/ $EXTPATH/snes96_snapshots
	fi
else
	if [ -d $EXTPATH/snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
		echo "Syncing SNES96 data..."
		rsync --update -rtvhW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
	fi
fi

# Syncs PocketSNES data
if [ -d $INTPATH/.pocketsnes/ ]; then
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "Syncing PocketSNES data..."
		rsync --update -rtvhW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
		rsync --update -rtvhW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	else
		echo "PocketSNES backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtvhW $INTPATH/.pocketsnes/ $EXTPATH/pocketsnes
	fi
else
	if [ -d $EXTPATH/pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
		echo "Syncing PocketSNES data..."
		rsync --update -rtvhW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
	fi
fi

# Syncs Snes9x data
if [ -d $INTPATH/.snes9x/ ]; then
	if [ -d $EXTPATH/snes9x/ ]; then
		echo "Syncing Snes9x data..."
		rsync --update -rtvhW $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
		rsync --update -rtvhW $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
		rsync --update -rtvhW $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
		rsync --update -rtvhW $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
	else
		echo "Snes9x backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/snes9x
		mkdir $EXTPATH/snes9x/spc
		mkdir $EXTPATH/snes9x/sram
		echo "Syncing Snes9x data..."
		rsync --update -rtvhW $INTPATH/.snes9x/spc/ $EXTPATH/snes9x/spc
		rsync --update -rtvhW $INTPATH/.snes9x/sram/ $EXTPATH/snes9x/sram
	fi
else
	if [ -d $EXTPATH/snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes9x
		mkdir $INTPATH/.snes9x/spc
		mkdir $INTPATH/.snes9x/sram
		echo "Syncing Snes9x data..."
		rsync --update -rtvhW $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
		rsync --update -rtvhW $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
	fi
fi

# Syncs SwanEmu data
if [ -d $INTPATH/.swanemu/ ]; then
	if [ -d $EXTPATH/swanemu/ ]; then
		echo "Syncing SwanEmu data..."
		rsync --update -rtvhW $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
		rsync --update -rtvhW $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
		rsync --update -rtvhW $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
		rsync --update -rtvhW $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
	else
		echo "SwanEmu backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/swanemu
		mkdir $EXTPATH/swanemu/eeprom
		mkdir $EXTPATH/swanemu/sstates
		echo "Syncing SwanEmu data..."
		rsync --update -rtvhW $INTPATH/.swanemu/eeprom/ $EXTPATH/swanemu/eeprom
		rsync --update -rtvhW $INTPATH/.swanemu/sstates/ $EXTPATH/swanemu/sstates
	fi
else
	if [ -d $EXTPATH/swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.swanemu
		mkdir $INTPATH/.swanemu/eeprom
		mkdir $INTPATH/.swanemu/sstates
		echo "Syncing SwanEmu data..."
		rsync --update -rtvhW $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
		rsync --update -rtvhW $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
	fi
fi

# Syncs Temper data
if [ -d $INTPATH/.temper/ ]; then
	if [ -d $EXTPATH/temper/ ]; then
		echo "Syncing Temper data..."
		rsync --update -rtvhW $INTPATH/.temper/bram/ $EXTPATH/temper/bram
		rsync --update -rtvhW $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
		rsync --update -rtvhW $EXTPATH/temper/bram/ $INTPATH/.temper/bram
		rsync --update -rtvhW $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
	else
		echo "Temper backup folder doesn't exist, creating folder."
		mkdir $EXTPATH/temper
		mkdir $EXTPATH/temper/bram
		mkdir $EXTPATH/temper/save_states
		echo "Syncing SneTempers9x data..."
		rsync --update -rtvhW $INTPATH/.temper/bram/ $EXTPATH/temper/bram
		rsync --update -rtvhW $INTPATH/.temper/save_states/ $EXTPATH/temper/save_states
	fi
else
	if [ -d $EXTPATH/temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.temper
		mkdir $INTPATH/.temper/bram
		mkdir $INTPATH/.temper/save_states
		echo "Syncing Temper data..."
		rsync --update -rtvhW $EXTPATH/temper/bram/ $INTPATH/.temper/bram
		rsync --update -rtvhW $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
	fi
fi

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Sync Complete" --msgbox "Save sync complete.\nPress START to exit." 6 29
exit
