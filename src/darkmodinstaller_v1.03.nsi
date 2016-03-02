/*
================================
= The Darkmod installer script =
= v1.03						   =
================================
= Author: 					   =
= Freek "freyk" Borgerink      =
================================


Description
This installer is created for the game The Dark Mod. (http://www.thedarkmod.com)
This installer places on the users system a gamefolder, create shortcuts and a uninstaller.   

=================
Required nsis plugins
The following nsis plugin is needed for this script
 - ShellLink, http://nsis.sourceforge.net/ShellLink_plug-in

===================

Changes / bugfixes 
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
!define InstallerVersion "v1.03"
!define InstallerAuthor "Freek 'Freyk' Borgerink"
!define InstallerFilename "tdm_installer.exe"
!define UninstallerName "The Dark Mod Uninstaller"
!define UninstallerVersion ${InstallerVersion}
!define UninstallerFilename "tdm_uninstaller.exe"
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

BrandingText "${InstallerName} - ${InstallerVersion} - by ${InstallerAuthor}"
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
!define MUI_WELCOMEPAGE_TEXT "Welcome to the installer for The Dark Mod, version ${AppVersion}$\n$\nThis installer installs the updater for $\ndownloading/updating the game files.$\nIt also place a uninstaller and can create shortcuts to the game.$\n$\nFor More information go to ${AppWebsite}$\n$\nInstaller created by Freek 'Freyk' Borgerink."  
;Custom finischpage
!define MUI_FINISHPAGE_TEXT "${InstallerName} has installed the updater on your computer.$\n$\nTo complete the installation of The Dark Mod,$\nthe updater must download the requiered game files.$\nThis installer will run automaticly the updater"
!define MUI_FINISHPAGE_RUN_TEXT "Launch the updater"
!define MUI_FINISHPAGE_RUN 
!define MUI_FINISHPAGE_RUN_CHECKED ;Checked checkbox to launch the updater
!define MUI_FINISHPAGE_RUN_FUNCTION "fncLaunchUpdater" ;execute function to run the updater
;if function is selected, set variabeles for the shortcuts to run as administrator
!define SHELLLINKTEST1 "$SMPROGRAMS\Darkmod\The Darkmod Updater.lnk"
!define SHELLLINKTEST2 "$SMPROGRAMS\Darkmod\The Darkmod.lnk"
!define SHELLLINKTEST3 "$SMPROGRAMS\Darkmod\Uninstall.lnk"                        

;Pages for the installer
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "tdmsystemfiles\LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; pages for uninstaller
BrandingText "${UninstallerName} - ${UninstallerVersion} - by ${InstallerAuthor}"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_WELCOMEPAGE_TITLE "${AppName} Uninstaller"
!define MUI_WELCOMEPAGE_TEXT "This uninstaller will remove ${AppName} of your system."
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_COMPONENTS
!define MUI_UNPAGE_CONFIRM_TITLE "${AppName} Uninstaller"
!define MUI_UNPAGE_CONFIRM_TEXT "ook hoi"
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!define MUI_FINISHPAGE_TITLE "${AppName} Uninstaller"
!define MUI_FINISHPAGE_TEXT "${AppName} is succesfully removed. $\n$\n For more information and news about darkmod, $\nvisit ${AppWebsite}"
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

	;copy tdmupdate to act as a placeholder for file Thedarmod.exe
	;CopyFiles "$INSTDIR\tdm_update.exe" "$INSTDIR\TheDarkMod.exe"
	
	;Registry settings
	
	;Write the installation path into the registry
	;WriteRegStr HKLM SOFTWARE\The_Dark_Mod "Install_Dir" "$INSTDIR"
	
	;Object for the windows software update/remove section
	!define REG_U "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkmod"
	WriteRegStr HKCU "${REG_U}" "DisplayName" "${AppName}"
	WriteRegStr HKCU "${REG_U}" "DisplayVersion" "${AppVersion}"
	WriteRegStr HKCU "${REG_U}" "UninstallString" '"$INSTDIR\${UninstallerFilename}"'
	WriteRegStr HKCU "${REG_U}" "Publisher" "${AppCreator}"
	WriteRegStr HKCU "${REG_U}" "URLInfoAbout" "${AppWebsite}"
	WriteRegStr HKCU "${REG_U}" "DisplayIcon" "$INSTDIR\TDM_icon.ico"  
	
	
	; Create uninstaller
	WriteUninstaller "$INSTDIR\${UninstallerFilename}"

SectionEnd

Section "Startmenu Shortcuts" SectionShortcuts

	; create shortcut menu for tdm
	CreateDirectory "$SMPROGRAMS\${AppName}" 
	CreateShortCut "$SMPROGRAMS\${AppName}\Uninstall.lnk" "$INSTDIR\${UninstallerFilename}" "" "$INSTDIR\darkmod.ico" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\License.lnk" "$INSTDIR\LICENSE.txt" "" "$INSTDIR\LICENSE.txt" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\AUTHORS.lnk" "$INSTDIR\AUTHORS.txt" "" "$INSTDIR\AUTHORS.txt" 0	
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName} Updater.lnk" "$INSTDIR\${InstallerFilename}" "" "$INSTDIR\darkmod.ico" 0 SW_SHOWNORMAL "" ""
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName}.lnk" "$INSTDIR\TheDarkMod.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""
  
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
	;Delete $INSTDIR\*.*
	
	; Remove shortcuts, if any
	RMDir /r "$SMPROGRAMS\The Dark Mod"
  
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
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsAdmin} "Startmenu shortcuts with admin privileges"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionTDM} "The Darkmod"
!insertmacro MUI_FUNCTION_DESCRIPTION_END



;--------------------------------
;END of script file