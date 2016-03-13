
The darkmodinstaller (windows) is created by
Freek "Freyk" Borgerink
https://sites.google.com/site/freykssite01/

Created for The Dark Mod (http://www.thedarkmod.com)
Created with Nsis 3.04

== use at your own risk. ==


-- Installation the installer build environment --

1. Extract the zip file   
2. Install nsis from the nssis-tools folder
3. Extract Shelllink.dll from "nssis-tools\Shelllink.zip\Plugins\Shelllink.dll" to "C:\Program Files\NSIS\Plugins\x86-ansi\" and "C:\Program Files\NSIS\Plugins\x86-unicode"
4.END

-- Compiling the script --

1. Go to the source folder. 
2. Compile the installer:

Method 1:
right-click darkmodinstaller.nsi" > compile nsis script.

Method 2:
start cmd,
go to the source folder
and run: C:\Program Files\NSIS\makensis.exe /X"SetCompressor /FINAL lzma" darkmodinstaller.nsi

3.END


-- Changelog --

1.0.4 (20160313)
- Changed shortcut for updater.
- Added more info to welcometext
 
1.0.3 (20160110)
- Script - Changed the format of the installerscript, to make it more userfriendy.
- Script - Changed (Commented out) codelines to create a placeholder for tdm.exe  
- Installer -  shortcut in Software Change/remove
- Installer - Added Component Descriptions
- Installer - Changed several textlabels.
- Installer - Changed the updater as a required component to install
- Uninstaller - Added a components menu. In the furture people can exclude the fms/savegames for deletion 
- Uninstaller - Added more text and graphic content in unstaller 

v1.02 (20150301)
- Changed the game title from "darkmod" to "The Dark Mod"
- Repaired the option to run the updater from the installer.
- Installer uses the icon of the updater
- Added updated updater
- Deleted the placeholder for tdm.exe
- added nsis to nsis-tools folder
  
v1.01  
- changed default installation path
- added an option to run shortcuts with admin permission  

v1.0 
Created the installer
