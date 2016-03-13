/*
================================
= The Darkmod installer script =
= v1.04						   =
================================
= Author: 					   =
= Freek "freyk" Borgerink      =
================================


Description
This installer is created for the game The Dark Mod. (http://www.thedarkmod.com)
It places on the users system the updater inside the gamefolder, 
And creates shortcuts and a uninstaller.   

=================
Required nsis plugins
The following nsis plugin is needed for this script
 - ShellLink, http://nsis.sourceforge.net/ShellLink_plug-in

===================

Changes / bugfixes 
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

;Variables

!define InstallerName "The Dark Mod Installer"
!define InstallerVersion "v1.04"
!define InstallerAuthor "Freek 'Freyk' Borgerink"
!define InstallerFilename "TDM_installer.exe"
!define UninstallerName "The Dark Mod Uninstaller"
!define UninstallerVersion ${InstallerVersion}
!define UninstallerFilename "TDM_uninstaller.exe"
!define AppName "The Dark Mod"
!define AppCreator "Broken Glass Studios"
!define AppVersion "2.04"
!define AppWebsite "http://www.thedarkmod.com"
!define Appdir "c:\games\darkmod"

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

;Request application privileges for Windows. "user" or "admin"
RequestExecutionLevel user

;CRC check the installer.
CRCCheck On

;--------------------------------
;Interface Settings

BrandingText "${InstallerName}"
!define MUI_ICON "tdmsystemfiles\darkmod.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "graphics\darkmodinstaller-header.bmp"
;!define MUI_HEADERIMAGE_LEFT

;show installation logs during (un)installation
;ShowInstDetails show

;--------------------------------
;Pages

;Customized objects and settings for some Pages
;Custom Welcome page
!define MUI_WELCOMEPAGE_TITLE "${InstallerName}"
!define MUI_WELCOMEPAGE_TEXT "Welcome to the installer for The Dark Mod.$\n$\nThis application installs only the updater for $\ndownloading and updating the game files.$\n$\nPlease run the updater after the installation.$\n$\nFor More information go to ${AppWebsite}$\n$\n$\n$\n$\n$\n$\n${InstallerName} (${InstallerVersion}) is created by$\nFreek 'Freyk' Borgerink."  
;Custom directorypage
DirText "This installer will install ${AppName} in the following folder. To install in a different folder, click Browse and select another folder. Click Install to start the installation." \
  "Please specify the path of the game folder:"

;Custom finischpage
!define MUI_FINISHPAGE_TEXT "${InstallerName} has installed the updater on your computer.$\n$\nTo complete the installation of The Dark Mod, the updater needs to run in order to download the requiered game files."
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${AppName} Updater."
!define MUI_FINISHPAGE_RUN 
!define MUI_FINISHPAGE_RUN_CHECKED ;Checked checkbox to launch the updater
!define MUI_FINISHPAGE_RUN_FUNCTION "fncLaunchUpdater" ;execute function to run the updater
;if function is selected, set variabeles for the shortcuts to run as administrator
!define SHELLLINKTEST1 "$SMPROGRAMS\${AppName}\${AppName} Updater.lnk"
!define SHELLLINKTEST2 "$SMPROGRAMS\${AppName}\${AppName}.lnk"
!define SHELLLINKTEST3 "$SMPROGRAMS\${AppName}\Uninstall.lnk"                        

;Pages for the installer
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "tdmsystemfiles\LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; pages for uninstaller
;BrandingText "${UninstallerName} - ${UninstallerVersion} - by ${InstallerAuthor}"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_WELCOMEPAGE_TITLE "${AppName} Uninstaller"
!define MUI_WELCOMEPAGE_TEXT "This uninstaller will remove ${AppName} of your system."
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_COMPONENTS
!define MUI_UNPAGE_CONFIRM_TITLE "${AppName} Uninstaller"
!define MUI_UNPAGE_CONFIRM_TEXT "Going to delete ${AppName} gamefolder."
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!define MUI_FINISHPAGE_TITLE "${AppName} Uninstaller"
!define MUI_FINISHPAGE_TEXT "${AppName} is succesfully removed.$\n$\nFor more information and news about ${AppName}, $\nvisit ${AppWebsite}"
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages
 
!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "The Dark mod Updater" SectionUpdater
	
	;this section is requiered
	SectionIn RO

	; Set output path is the installation directory.
	SetOutPath $INSTDIR

	; Get the TDM files from here and copy to $INSTDIR
	File /r "tdmsystemfiles\"

	;;Write the installation path into the registry
	;WriteRegStr HKLM SOFTWARE\The_Dark_Mod "Install_Dir" "$INSTDIR"
	
	
	;Registry settings
	
	;Object for the windows software update/remove section
	!define REG_U "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkmod"
	WriteRegStr HKCU "${REG_U}" "DisplayName" "${AppName}"
	WriteRegStr HKCU "${REG_U}" "DisplayVersion" "1.0"
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

Section /o "Startmenu Shortcuts (systemadmin rights)" SectionShortcutsAdmin

	; create shortcut menu Darkmod with user admin privileges
	CreateDirectory "$SMPROGRAMS\${AppName}"
	CreateShortCut "$SMPROGRAMS\${AppName}\Uninstall-admin.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\darkmod.ico" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\License-admin.lnk" "$INSTDIR\LICENSE.txt" "" "$INSTDIR\LICENSE.txt" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\AUTHORS-admin.lnk" "$INSTDIR\AUTHORS.txt" "" "$INSTDIR\AUTHORS.txt" 0	
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName} Updater-admin.lnk" "$INSTDIR\tdm_update.exe" "" "$INSTDIR\darkmod.ico" 0 SW_SHOWNORMAL "" ""
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName}-admin.lnk" "$INSTDIR\TheDarkMod.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""	

	; Set Shortcuts to Run As Administrator
	ShellLink::SetRunAsAdministrator "${SHELLLINKTEST1}"	
	ShellLink::SetRunAsAdministrator "${SHELLLINKTEST2}"
	ShellLink::SetRunAsAdministrator "${SHELLLINKTEST3}"
  
SectionEnd


;Function to launch te updater
Function fncLaunchUpdater
	
	;Execute the updater
	ExecShell "" "$INSTDIR\tdm_update.exe"

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


/*
Section "un.Savegames"

	; Remove registry keys  
	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkmod"

	; Remove shortcuts, if any
	RMDir /r "$SMPROGRAMS\The Dark Mod"


SectionEnd
*/

;Component Description
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionUpdater} "The Darkmod Updater, for installing and updating the game files."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcuts} "Startmenu shortcuts"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsDesktop} "Desktop shortcuts"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsAdmin} "Startmenu shortcuts with admin privileges"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionTDM} "The Darkmod"
!insertmacro MUI_FUNCTION_DESCRIPTION_END



;--------------------------------
;END of script file