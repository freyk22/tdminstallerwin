
The darkmodinstaller (windows) is created by
Freek "Freyk" Borgerink
https://freyk.wordpress.com

Created for the dark mod (http://www.thedarkmod.com)


-- Versions --
Changes / bugfixes

v20160731
- Gammar fixes and additional text from teh_saccade.
  textlabel changes at pages: 
  VIAddVersionKey, MUI_WELCOMEPAGE_TEXT, MUI_LICENSEPAGE, Componentspage, 
  Location page, MUI_FINISHPAGE, un_welcomepage, unconfirmpage, unINSTFILESPAGE 
  and MUI_FUNCTION_DESCRIPTION

v20160728
- Brandingname issue found and reported ("The Dark Mod" or "The Darkmod").
- Changed Welcomescreen title for installer and uninstaller to ${AppName}. (request by Bikerdude)
- added variable ${AppName} to caption (un)installer & filename shortcuts.
- Added Grammerfixes by BikerDude to directorypage_HEADER_SUBTEXT, FINISHPAGE_TEXT, 
  uninstaller_WELCOMEPAGE_TEXT, UNCONFIRMPAGE_TEXT_TOP, 
  uninstaller_FINISHPAGE_TEXT and component description-SectionUpdater. 

v20160718
- Added targetdir-argument to shortcuts for updater.
- removed the runafterinstall-checkbox on finischpage. The updater will be automaticly started when the user hits the finisch button.

v20160717a
- Added setting "SetAutoClose false" to show uninstall details.
- Added headers to uninstall page.
- added quotes to targetdir-argument of the updater in fncUpdaterRun. So the updater dont crash when the path has spaces. 


v20160717
- Changed Textlabels on all installer pages. (because tdm-installer doesnt install itself)
- Changed Content of Welcome screen.
- Added variable names to some textlabels.
- Changed that the logscreen in the instfiles page will be hidden.
- Tried to hide the runafterinstall-checkbox on finischpage
- Changed content welcomescreen uninstaller.
- Changed labels from all uninstaller pages
- Removed uninstaller components page
- Changed some comments in code.



v20160713
- added tdmupdate version 0.65

v20160712
- Changed executionlevel to "admin" (to run the installer with elevated permissions), discussed with bikerdude


v20160709
- Changed executionlevel to "user". To write create a tdm-folder in program files, run installer as admin.
- Removed shelllink from project
- removed argument "targetdir" from execshell tdm updater, because if the installer started with elevated permissions, it crashes the updater.
- Changed VIAddVersionKey versionnumbers


v20160706
- removed versionnumbers of the game.
- Changed names of components
- added File description for installer
- Added Plugin "Accesscontrol" for Changeing userpermissions on folder.
- commented out Shellink lines, because there is no need anymore.
- commented out section "Startmenu Shortcuts (systemadmin rights)", because there is no need anymore.
- Added full acces permissions to tdm folder, using AccessControl
- added arguments to execshell
- Code cleanup.


1.0.4 (20160313)
- Changed the startmenu shortcut for the updater.
- Added more info to welcometext
- Added an option to install desktop shortcuts
- Added code to remove the desktop shortcut files
- Changed BrandingText
- Changed some textlabels for welcometext,Directory,Finischpage
- Commentedout InstallerVersion in brandingtext, requested by Grayman 
 
* 1.0.3 (20160110 weekend)
- Script - Changed the format of the installerscript, to make it more userfriendy.
- Script - Changed (Commented out) codelines to create a placeholder for tdm.exe  
- Installer -  shortcut in Software Change/remove
- Installer - Added Component Descriptions
- Installer - Changed several textlabels.
- Installer - Changed the updater as a required component to install
- Uninstaller - Added a components menu. In the furture people can exclude the fms/savegames for deletion 
- Uninstaller - Added more text and graphic content in unstaller 

* v1.02 (20150301)
- Changed the game title from "darkmod" to "The Dark Mod"
- Repaired the option to run the updater from the installer.
- Installer uses the icon of the updater
- Added updated updater
- Deleted the placeholder for tdm.exe
- added nsis to nsis-tools folder
  
* v1.01  
- changed default installation path
- added an option to run shortcuts with admin permission  

* v1.0 
Created the installer
