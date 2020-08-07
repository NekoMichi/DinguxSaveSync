# DinguxSaveSync
A small utility to backup, restore, and sync save data on OpenDingux devices with the secondary SD card.

![Main menu](/screenshots/screenshot-menu-2.0.png)

**How to install**

Download the latest version of savesync.opk and copy it to either the apps folder on the primary micro SD card, or create a new folder called "apps" on the secondary micro SD card and copy the .opk file there. A new "SaveSync" app should now appear under the applications section.

**Prerequisites**

SaveSync will transfer save data between the internal storage and the secondary SD card, make sure there is one inserted before running the app. **This utility will not work on devices with a faulty slot-2 reader.** SaveSync also needs all associated devices to have the **correct time and date** set, as it compares timestamps when deciding whether or not to overwrite files.

**Features**

From the main menu, there are five options:
- Backup - Copies save data from the internal storage to a folder called "backup" on the external storage. If there is no backup folder present, the app will automatically create one. Saves exported to the external storage can then be transferred to other devices or even used in other emulators. The app will overwrite any existing saves in the backup folder even if it has a newer modified date than the internal save.
- Restore - Transfers backed up save data from the external storage to the internal storage. This is useful if saves were exported for external editing or use on other devices and will allow the device to then use the edited or updated save data. The app will overwrite any existing saves in the internal folder even if it has a newer modified date than the external save.
- Sync - The app will attempt to merge the contents of both the internal storage and the backup folder, if certain files are newer on the internal storage then it will overwrite the version in the backup folder and vice-versa. Useful if you want to unify save data between multiple devices.
- Snapshots - Create multiple backups of different time points and restore from any of them.
- Advanced options - Allows various features to be debugged.

![Backup screen](/screenshots/screenshot-backup-1.5.png)

**Data backed up**

SaveSync will only access data from specific apps and emulators, they are:
- Screenshots (backup only)
- FCEUX (NES emulator)
- Gambatte (GameBoy emulator)
- ReGBA (GameBoy Advance Emulator)
- PCSX4all (PlayStation 1 emulator)
- PicoDrive (Sega Master System/Genesis/Game Gear emulator)
- PocketSNES (Super NES emulator)

**Snapshots**

![Snapshots menu](/screenshots/screenshot-snapshots-2.0.png)

The snapshots feature allows multiple backup archives to be created at different time points, so the user can restore from a previous point. Snapshots are saved to /media/sdcard/backupsnapshots/

Do not create any new folders here or rename any existing snapshot folders, as it may prevent the snapshots from being useable.

**Advanced options**

The advanced options menu provides a number of features primarily used for testing/debugging:
- Debug backup - Simulates a backup operation that lists files that would have been copied from the home folder to the backup folder in the event of an actual backup, then saves the log to /media/sdcard/log/. No actual files will be transferred.
- Debug restore - Simulates a restore operation that lists the files that would have transferred from the backup folder to the home folder in the event of an actual restore, then saves the log to /media/sdcard/backup/log/. No actual files will be transferred.
- Debug sync - Simulates a sync operation that lists the files that would have been transferred if an actual sync were to be run, then saves the log to /media/sdcard/backup/log/. No actual files will be transferred.
- Export - Allows saves on the host device to be written directly to the system card of another device. In order to do this, take the system card from slot-1 of the receiving device and insert it into slot-2 of the source device.
- Import - Allows saves on the system card of another device to be directly written to the host device. In order to do this, take the system card from slot-1 of the source device and insert it into slot-2 of the host device.
- Direct sync - If the card in slot-2 is the system card from another OpenDingux device, this option will attempt to sync saves with it directly.

For example, if you want to clone saves from your device onto a second device, eject the card in slot-1 of the second device, insert it into slot-2 of the host device, and then run Advanced > Export.

**Known issues/quirks**
- The first time this app is run, it may take longer than usual as it needs to generate the initial backup folder structure and files. Subsequent runs will be much faster as it only accesses files that have changed since the last backup.
- After running backup/restore/sync for the first time, some emulators might take a little longer than usual to start up. This only happens once and is due to a limitation with OpenDingux itself.
- SaveSync will only check timestamps when deciding whether or not to overwrite save data. This means if you backup your saves and then start a fresh save on one of the games and replace the backed up file with the fresh save, it will replace the save on the internal partition on the next sync because its last-modified timestamp is more recent.
