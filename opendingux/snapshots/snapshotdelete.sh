#!/bin/sh
# title=Snapshot Delete
# desc=Delete an existing snapshot
# author=NekoMichi

SNAPSHOTPATH="$SDPATH/backupsnapshots"

# Checks to see if there is a card inserted in slot 2
if [ ! -b /dev/mmcblk1 ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No SD Card Found" --msgbox "No SD card inserted in slot-2.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if snapshots folder exists on card 2
if [ ! -d $SNAPSHOTPATH/ ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No Snapshots" --msgbox "No snapshots found in backup folder.\n\nPress START to exit." 8 29
	exit
fi

# Checks to see if snapshots folder is empty on card 2
TOTALSNAPSHOTS=$(find $SNAPSHOTPATH/SNAPSHOT*SNAP -maxdepth 0 -type d | wc -l)
if [ $TOTALSNAPSHOTS = "0" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "No Snapshots" --msgbox "No snapshots found in backup folder.\n\nPress START to exit." 8 29
	exit
fi

# Generate list of snapshots
cd $SNAPSHOTPATH
MENUITEMS=$(ls -d -- SNAPSHOT*SNAP)

# Display list of snapshots
SELECTEDSNAPSHOT=$(dialog --backtitle "SaveSync $APPVERSION" --title "SaveSync - Snapshots" --menu "Select snapshot to delete" 15 49 10 $MENUITEMS 2>&1 >/dev/tty)

if [ -z $SELECTEDSNAPSHOT ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Operation Cancelled" --msgbox "Snapshot deletion cancelled.\nNo files were changed.\n\nPress START to exit." 8 35
	exit
fi

# Displays a confirmation dialog
dialog --clear --backtitle "SaveSync $APPVERSION" --title "Confirm Load?" --yesno "Are you sure you want to delete the following snapshot? This cannot be undone.\n\n$SELECTEDSNAPSHOT" 9 49
CONFIRMLOAD=$?
clear

if [ $CONFIRMLOAD = "1" ]; then
	dialog --clear --backtitle "SaveSync $APPVERSION" --title "Operation Cancelled" --msgbox "Snapshot deletion cancelled.\nNo files were changed.\n\nPress START to exit." 8 35
	exit
fi

# Set directory path for selected snapshot
DELETEPATH=$SNAPSHOTPATH"/"$SELECTEDSNAPSHOT" SNAP"
chmod -R 777 "$DELETEPATH"
rm -r "$DELETEPATH"

dialog --clear --backtitle "SaveSync $APPVERSION" --title "Snapshot Deleted" --msgbox "Deleted snapshot:\n$SELECTEDSNAPSHOT\n\nPress START to exit." 8 43
exit
