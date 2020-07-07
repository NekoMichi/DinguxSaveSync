# DinguxSaveSync
A small utility to backup, restore, and sync save data on OpenDingux devices with the secondary SD card.

![screenshot01](/screenshots/screenshot01.png)

**How to install**

Download the latest version of savesync.opk and copy it to either the apps folder on the primary micro SD card, or create a new folder called "apps" on the secondary micro SD card and copy the .opk file there. A new "SaveSync" app should now appear under the applications section.

**Prerequisites**

SaveSync will transfer save data between the internal storage and the secondary SD card, make sure there is one inserted before running the app. **This utility will not work on devices with a faulty slot-2 reader.**

**Features**

From the main menu, there are three options:
- Backup - Copies save data from the internal storage to a folder called "backup" on the external storage. If there is no backup folder present, the app will automatically create one. Saves exported to the external storage can then be transferred to other devices or even used in other emulators. The app will only overwrite files in the backup folder if a newer version is found on the internal storage, if the version in the backup folder has been changed and is newer than the one in the internal storage, it will be skipped.
- Restore - Transfers backed up save data from the external storage to the internal storage. This is useful if saves were exported for external editing or use on other devices and will allow the device to then use the edited or updated save data. The app will only overwrite files in the internal storage if a newer version is found in the backup folder, if the version in the internal storage has been changed and is newer than the one in the backup folder, it will be skipped.
- Sync - The app will attempt to merge the contents of both the internal storage and the backup folder, if certain files are newer on the internal storage then it will overwrite the version in the backup folder and vice-versa. Useful if you want to unify save data between multiple devices.

**Data backed up**

SaveSync wil only access data from specific apps and emulators, they are:
- GMenu2x settings (backup only, will not be overwritten during syncing)
- Screenshots (backup only, will not be overwritten during syncing)
- Custom ScriptRunner scripts (backup only, will not be overwritten during syncing)
- FCEUX (NES emulator)
- Gambatte (GameBoy emulator)
- ReGBA (GameBoy Advance Emulator)
- PCSX4all (PlayStation 1 emulator)
- PicoDrive (Sega Master System/Genesis/Game Gear emulator)
- PocketSNES (Super NES emulator)

**Known issues/quirks**
- The first time this app is run, it may take longer than usual as it needs to generate the initial backup folder structure and files. Subsequent runs will be much faster as it only accesses files that have changed since the last backup.
- After running backup/restore/sync for the first time, some emulators might take a little longer than usual to start up. This only happens once.
