
The darkmodinstaller (windows) is created by
Freek "Freyk" Borgerink

Created for The Dark Mod (http://www.thedarkmod.com)
Created with Nsis 3.04

== use at your own risk. ==


-- Installation the installer build environment --

1. Extract the zip file   
2. Install nsis from the nssis-tools folder
3. install the plugins from the nsis-tools folder.
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

v20210605
- The darkmod created an official installer. But is has many limitations and its difficult to avoid starter problems.
- So this installer is still needed.
- Replaced the TDM updater binary with TDMs official installer binary.
- because the limitations of that installer, added ShellExecAsUser to run tdms installer as a normal user.
- replaced text labels to use installer instead of the updater.
- changed download location
- removed the version download feature, because the tdms installer can do this.
- made some components optional.

1.0.4 (20160313)
- Changed the startmenu shortcut for the updater.
- Added more info to welcometext
- Added an option to install desktop shortcuts
- Added code to remove the desktop shortcut files
- Changed BrandingText
- Changed some textlabels for welcometext,Directory,Finischpage
- Commentedout InstallerVersion in brandingtext, requested by Grayman 
 
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
