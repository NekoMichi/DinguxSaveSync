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

# Checks to see if backup folder exists on card 2
if [ ! -d $EXTPATH/ ]; then
	echo "Backup folder not found on card-2."
	echo "Please make sure card-2 has backup data stored."
	echo ""
	read -p "Press START to exit."
	exit
fi

# Overrides permissions on folders
chmod -R 777 $EXTPATH
chmod -R 777 $INTPATH

# Restores FCEUX data
if [ -d $EXTPATH/fceux/ ]; then
	if [ ! -d $INTPATH/.fceux/ ]; then
		echo "FCEUX folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.fceux
		mkdir $INTPATH/.fceux/sav
		mkdir $INTPATH/.fceux/fcs
	fi
	echo "Imported FCEUX files:"
	rsync -nvrtW $EXTPATH/fceux/sav/ $INTPATH/.fceux/sav
	rsync -nvrtW $EXTPATH/fceux/fcs/ $INTPATH/.fceux/fcs
fi

# Restores Gambatte data
if [ -d $EXTPATH/gambatte/ ]; then
	if [ ! -d $INTPATH/.gambatte/ ]; then
		echo "Gambatte folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gambatte
		mkdir $INTPATH/.gambatte/saves
	fi
	echo "Imported Gambatte files:"
	rsync -nvrtW $EXTPATH/gambatte/saves/ $INTPATH/.gambatte/saves
fi

# Restores OhBoy data
if [ -d $EXTPATH/ohboy/ ]; then
	if [ ! -d $INTPATH/.ohboy/ ]; then
		echo "OhBoy folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.ohboy
		mkdir $INTPATH/.ohboy/saves
	fi
	echo "Imported OhBoy files:"
	rsync -nvrtW $EXTPATH/ohboy/saves/ $INTPATH/.ohboy/saves
fi

# Restores ReGBA data
if [ -d $EXTPATH/gpsp/ ]; then
	if [ ! -d $INTPATH/.gpsp/ ]; then
		echo "ReGBA folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.gpsp
	fi
	echo "Imported ReGBA files:"
	rsync -nvrtW --exclude '*.cfg' $EXTPATH/gpsp/ $INTPATH/.gpsp
fi

# Restores PCSX4all data
if [ -d $EXTPATH/pcsx4all/ ]; then
	if [ ! -d $INTPATH/.pcsx4all/ ]; then
		echo "PCSX4all folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pcsx4all
		mkdir $INTPATH/.pcsx4all/memcards
		mkdir $INTPATH/.pcsx4all/sstates
	fi
	echo "Imported PCSX4all files:"
	rsync -nvrtW $EXTPATH/pcsx4all/memcards/ $INTPATH/.pcsx4all/memcards
	rsync -nvrtW $EXTPATH/pcsx4all/sstates/ $INTPATH/.pcsx4all/sstates
fi

# Restores Picodrive data
if [ -d $EXTPATH/picodrive/ ]; then
	if [ ! -d $INTPATH/.picodrive/ ]; then
		echo "Picodrive folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.picodrive
		mkdir $INTPATH/.picodrive/mds
		mkdir $INTPATH/.picodrive/srm
	fi
	echo "Imported PicoDrive files:"
	rsync -nvrtW $EXTPATH/picodrive/mds/ $INTPATH/.picodrive/mds
	rsync -nvrtW $EXTPATH/picodrive/srm/ $INTPATH/.picodrive/srm
fi

# Restores SMS Plus data
if [ -d $EXTPATH/smsplus/ ]; then
	if [ ! -d $INTPATH/.smsplus/ ]; then
		echo "SMS Plus folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.smsplus
		mkdir $INTPATH/.smsplus/sram
		mkdir $INTPATH/.smsplus/state
	fi
	echo "Imported SMS Plus files:"
	rsync -nvrtW $EXTPATH/smsplus/sram/ $INTPATH/.smsplus/sram
	rsync -nvrtW $EXTPATH/smsplus/state/ $INTPATH/.smsplus/state
fi

if [ -d $EXTPATH/sms_sdl/ ]; then
	if [ ! -d $INTPATH/.sms_sdl/ ]; then
		echo "SMS SDL folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.sms_sdl
		mkdir $INTPATH/.sms_sdl/sram
		mkdir $INTPATH/.sms_sdl/state
	fi
	echo "Imported SMS SDL files:"
	rsync -nvrtW $EXTPATH/sms_sdl/sram/ $INTPATH/.sms_sdl/sram
	rsync -nvrtW $EXTPATH/sms_sdl/state/ $INTPATH/.sms_sdl/state
fi

# Restores PocketSNES data
if [ -d $EXTPATH/snes96_snapshots/ ]; then
	if [ ! -d $INTPATH/.snes96_snapshots/ ]; then
		echo "SNES96 folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes96_snapshots
	fi
	echo "Imported SNES96 files:"
	rsync -nvrtW --exclude '*.opt' $EXTPATH/snes96_snapshots/ $INTPATH/.snes96_snapshots
fi

if [ -d $EXTPATH/pocketsnes/ ]; then
	if [ ! -d $INTPATH/.pocketsnes/ ]; then
		echo "PocketSNES folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.pocketsnes
	fi
	echo "Imported PocketSNES files:"
	rsync -nvrtW --exclude '*.opt' $EXTPATH/pocketsnes/ $INTPATH/.pocketsnes
fi

# Restores Snes9x data
if [ -d $EXTPATH/snes9x/ ]; then
	if [ ! -d $INTPATH/.snes9x/ ]; then
		echo "Snes9x folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.snes9x
		mkdir $INTPATH/.snes9x/spc
		mkdir $INTPATH/.snes9x/sram
	fi
	echo "Imported Snes9x files:"
	rsync -nvrtW $EXTPATH/snes9x/spc/ $INTPATH/.snes9x/spc
	rsync -nvrtW $EXTPATH/snes9x/sram/ $INTPATH/.snes9x/sram
fi

# Restores SwanEmu data
if [ -d $EXTPATH/swanemu/ ]; then
	if [ ! -d $INTPATH/.swanemu/ ]; then
		echo "SwanEmu folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.swanemu
		mkdir $INTPATH/.swanemu/eeprom
		mkdir $INTPATH/.swanemu/sstates
	fi
	echo "Imported SwanEmu files:"
	rsync -nvrtW $EXTPATH/swanemu/eeprom/ $INTPATH/.swanemu/eeprom
	rsync -nvrtW $EXTPATH/swanemu/sstates/ $INTPATH/.swanemu/sstates
fi

# Restores Temper data
if [ -d $EXTPATH/temper/ ]; then
	if [ ! -d $INTPATH/.temper/ ]; then
		echo "Temper folder doesn't exist in home directory, creating folder."
		mkdir $INTPATH/.temper
		mkdir $INTPATH/.temper/bram
		mkdir $INTPATH/.temper/save_states
	fi
	echo "Imported Temper files:"
	rsync -nvrtW $EXTPATH/temper/bram/ $INTPATH/.temper/bram
	rsync -nvrtW $EXTPATH/temper/save_states/ $INTPATH/.temper/save_states
fi

echo ""
echo "Debug restore complete."
echo "Report saved to /media/sdcard/backup/log/$TIMESTAMP.txt"
read -p "Press START to exit."
exit
