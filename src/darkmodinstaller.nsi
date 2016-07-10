/*
================================
= The Darkmod installer script
= v20160709
================================
= Author:
= Freek "freyk" Borgerink
================================

Description
This installer is created for the game The Dark Mod. (http://www.thedarkmod.com)
It places on the users system the updater inside the gamefolder, 
And creates shortcuts and a uninstaller.   

=================
Required nsis plugins
The following nsis plugin is needed for this script
- AccessControl, http://nsis.sourceforge.net/AccessControl_plug-in
===================
*/

;Variables

!define InstallerName "The Dark Mod Installer"
!define InstallerVersion "v20160709"
!define InstallerAuthor "Freek 'Freyk' Borgerink"
!define InstallerFilename "TDM_installer.exe"
!define UninstallerName "The Dark Mod Uninstaller"
!define UninstallerVersion ${InstallerVersion}
!define UninstallerFilename "TDM_uninstaller.exe"
!define AppName "The Dark Mod"
!define AppCreator "Broken Glass Studios"
;!define AppVersion "2.04"
!define AppWebsite "http://www.thedarkmod.com"
!define Appdir "c:\games\darkmod"   ; "c:\games\darkmod" or "$PROGRAMFILES\darkmod"


;--------------------------------
;Include Modern UI

!include "MUI2.nsh"

;--------------------------------
;General

; Filename and Location of the installer
OutFile "${InstallerFilename}"
Name "${InstallerName}" 
Caption "${InstallerName}"

; Default installation folder
InstallDir "${Appdir}"

;Request application privileges for Windows. 
;"user" (normal permissions) or "admin" (elevated)
;If you want to install in program files, executionlevel needs to set to admin. 
;Or run installer as administrator.
RequestExecutionLevel user


;CRC check the installer.
CRCCheck On

;--------------------------------
;Interface Settings

BrandingText "${InstallerName} ${InstallerVersion}"
!define MUI_ICON "tdmsystemfiles\darkmod.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "graphics\darkmodinstaller-header.bmp"
;!define MUI_HEADERIMAGE_LEFT

;show installation logs during (un)installation
ShowInstDetails show

;Installer file-description
VIProductVersion "0.0.0.0"
VIAddVersionKey ProductName "${InstallerName}"
VIAddVersionKey Comments "${InstallerName} a application that installs the gamefolder and updater for the game The Dark Mod.  For additional details, visit ${AppWebsite}"
VIAddVersionKey CompanyName "${AppCreator}"
VIAddVersionKey LegalCopyright "${AppCreator}"
VIAddVersionKey FileDescription "${InstallerName} a application that installs the gamefolder and updater for the game The Dark Mod.  For additional details, visit ${AppWebsite}"
VIAddVersionKey FileVersion ${InstallerVersion}
VIAddVersionKey ProductVersion ${InstallerVersion}
VIAddVersionKey InternalName "${InstallerName}"
VIAddVersionKey OriginalFilename "${InstallerFilename}"


;--------------------------------
;Pages



;Customized objects and settings for some Pages

;Custom Installer Welcome page
!define MUI_WELCOMEPAGE_TITLE "${InstallerName}"
!define MUI_WELCOMEPAGE_TEXT "Welcome to the installer for The Dark Mod.$\n$\nThis application installs only the gamefolder and the updater for the game. $\nAfter the installation, the updater needs to run to download the gamefiles.$\n$\nPlease run the updater after the installation.$\n$\nFor more information go to ${AppWebsite}$\n$\n$\n$\n${InstallerName} is created by$\nFreek 'Freyk' Borgerink."  

;Custom Installer directorypage
DirText "This installer will install ${AppName} in the following folder. To install in a different folder, click Browse and select another folder. Click Install to start the installation." \
  "Please specify the path of the game folder:"

;Custom Installer finischpage
!define MUI_FINISHPAGE_TEXT "${InstallerName} has installed the updater on your computer.$\n$\nTo complete the installation of The Dark Mod, the updater needs to run in order to download the requiered game files."
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${AppName} Updater."
!define MUI_FINISHPAGE_RUN 
!define MUI_FINISHPAGE_RUN_CHECKED ;Checked checkbox to launch the updater
!define MUI_FINISHPAGE_RUN_FUNCTION "fncUpdaterRun" ;execute function to run the updater

;Pages for the installer
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "tdmsystemfiles\LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH


; pages for uninstaller
;Custom Uninstaller Welcome Page
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_WELCOMEPAGE_TITLE "${AppName} Uninstaller"
!define MUI_WELCOMEPAGE_TEXT "This uninstaller will remove ${AppName} of your system."
!insertmacro MUI_UNPAGE_WELCOME

;Custom Uninstaller Components Page
!insertmacro MUI_UNPAGE_COMPONENTS
!define MUI_UNPAGE_CONFIRM_TITLE "${AppName} Uninstaller"
!define MUI_UNPAGE_CONFIRM_TEXT "Going to delete ${AppName} gamefolder."

;No Custom Uninstaller Confirm and Instfiles pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

;Custom Uninstaller FINISHPAGE Page
!define MUI_FINISHPAGE_TITLE "${AppName} Uninstaller"
!define MUI_FINISHPAGE_TEXT "${AppName} is succesfully removed.$\n$\nFor more information and news about ${AppName}, $\nvisit ${AppWebsite}"
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages
 
!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

;Section "The Dark mod (Updater and Gamefolder)" SectionUpdater
Section "Gamefolder and updater" SectionUpdater
	
	;this section is requiered
	SectionIn RO

	; Set output path is the installation directory.
	SetOutPath $INSTDIR

	; Get the TDM files from here and copy to $INSTDIR
	File /r "tdmsystemfiles\"

	; Give all users Fullacces to the TDM folder,
	; So tdm and updater can write files to it.
	AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
	AccessControl::EnableFileInheritance $INSTDIR		

	; Registry settings	
	; Object for the windows software update/remove section
	!define REG_U "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkmod"
	WriteRegStr HKCU "${REG_U}" "DisplayName" "${AppName}"
	;WriteRegStr HKCU "${REG_U}" "DisplayVersion" "1.0"
	WriteRegStr HKCU "${REG_U}" "UninstallString" '"$INSTDIR\${UninstallerFilename}"'
	WriteRegStr HKCU "${REG_U}" "Publisher" "${AppCreator}"
	WriteRegStr HKCU "${REG_U}" "URLInfoAbout" "${AppWebsite}"
	WriteRegStr HKCU "${REG_U}" "DisplayIcon" "$INSTDIR\TDM_icon.ico"  
	
	
	; Create uninstaller
	WriteUninstaller "$INSTDIR\${UninstallerFilename}"


SectionEnd


Section "Startmenu Shortcuts" SectionShortcuts

	; create start menu shortcuts for tdm
	CreateDirectory "$SMPROGRAMS\${AppName}" 
	CreateShortCut "$SMPROGRAMS\${AppName}\Uninstall.lnk" "$INSTDIR\${UninstallerFilename}" "" "$INSTDIR\darkmod.ico" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\License.lnk" "$INSTDIR\LICENSE.txt" "" "$INSTDIR\LICENSE.txt" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\AUTHORS.lnk" "$INSTDIR\AUTHORS.txt" "" "$INSTDIR\AUTHORS.txt" 0	
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName} Updater.lnk" "$INSTDIR\tdm_update.exe" "" "$INSTDIR\darkmod.ico" 0 SW_SHOWNORMAL "" ""
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName}.lnk" "$INSTDIR\TheDarkMod.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""
  
SectionEnd



Section /o "Desktop Shortcuts" SectionShortcutsDesktop

	; create Desktop shortcuts for tdm
	CreateShortCut "$DESKTOP\${AppName} Updater.lnk" "$INSTDIR\tdm_update.exe" "" "$INSTDIR\darkmod.ico" 0 SW_SHOWNORMAL "" ""
	CreateShortCut "$DESKTOP\${AppName}.lnk" "$INSTDIR\TheDarkMod.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""

SectionEnd


;Function to launch te updater
Function fncUpdaterRun
	
	; Execute the updater with arguments
	;ExecShell "" "$INSTDIR\tdm_update.exe" "--noselfupdate --targetdir=$INSTDIR"
	;Exec '"$INSTDIR\tdm_update.exe" --noselfupdate --targetdir=$INSTDIR"'
	ExecShell "" "$INSTDIR\tdm_update.exe" "--noselfupdate"
	

FunctionEnd


;--------------------------------
;Uninstaller Section
Section "un.The Dark Mod" SectionTDM
	SectionIn RO

	; Remove registry keys  
	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkmod"

	; Remove files and uninstaller
	RMDir /r $INSTDIR
	
	; Remove shortcuts, if any
	RMDir /r "$SMPROGRAMS\The Dark Mod"
	Delete "$DESKTOP\${AppName}\${AppName} Updater.lnk" 
	Delete "$DESKTOP\${AppName}.lnk"
	Delete "$DESKTOP\${AppName} Updater.lnk"
	  
SectionEnd


;Component Description
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionUpdater} "The Gamefolder and the updater. The Darkmod Updater is needed for downloading/updating the required gamefiles."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcuts} "Startmenu shortcuts"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsDesktop} "Desktop shortcuts"
;!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsAdmin} "Startmenu shortcuts with admin privileges"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionTDM} "The Darkmod"
!insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;END of script file



/*
;--------------------------------
Changes / bugfixes 

v20160709
- Changed executionlevel to "user". To write create a tdm-folder in program files, run installer as admin.
- Removed shelllink from project
- removed argument "targetdir" from execshell tdm updater, because if the installer started with elevated permissions, it crashes the updater.
- Changed VIAddVersionKey versionnumbers


v20160706
- removed versionnumbers of the game.
- Changed names of components
- added File description for installer
- Added Plugin "Accesscontrol" for Changeing userpermissions on TDM folder.
- commented out Shellink lines, because there is no need for it anymore.
- commented out section "Startmenu Shortcuts (systemadmin rights)", because there is no need anymore.
- Added full-control permissions to users to tdm folder, using AccessControl
- Changed RequestExecutionLevel to "admin"
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
1.0.3
- Added more text and graphic content in unstaller 
- Changed the format of the installerscript, to make it more userfriendy.
- Added shortcut in Software Change/remove
- Added Component Descriptions
- Changed several textlabels.
- Changed the updater as a required component to install
- Changed (Commented out) codelines to create a placeholder for tdm.exe  
1.0.2
- Changed location of game folder
- Added privileges option
1.0.1
- Created the installer
================================
*/