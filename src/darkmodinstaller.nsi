/*
================================
= The Darkmod installer script
= v20180722
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
The following nsis plugins are needed for this script
- AccessControl, http://nsis.sourceforge.net/AccessControl_plug-in
- zipdll, https://nsis.sourceforge.io/ZipDLL_plug-in
- Inetc, https://nsis.sourceforge.io/Inetc_plug-in
===================
*/

;Variables
!define AppName "The Dark Mod"
!define AppCreator "Broken Glass Studios"
!define AppWebsite "http://www.thedarkmod.com"
!define Appdir "c:\games\darkmod"   ; "c:\games\darkmod" or "$PROGRAMFILES\darkmod"
!define Updateronlinelocation "http://darkmod.taaaki.za.net/release/tdm_update_win.zip"

!define InstallerName "${AppName} Installer"
!define InstallerVersion "v20181125"
!define InstallerAuthor "Freek 'Freyk' Borgerink"
!define InstallerFilename "TDM_installer.exe"
!define UninstallerName "${AppName} Uninstaller"
!define UninstallerVersion ${InstallerVersion}
!define UninstallerFilename "TDM_uninstaller.exe"



;--------------------------------
;Include Modern UI

!include "MUI2.nsh"

;detection 32 or 64 bit.
!include LogicLib.nsh
!include x64.nsh

;--------------------------------
;General

; Filename and Location of the installer
OutFile "${InstallerFilename}"
Name "${AppName}" 
Caption "${InstallerName}"

; Default installation folder
InstallDir "${Appdir}"

;Request application privileges for Windows. 
;"user" (normal permissions) or "admin" (elevated permissions)
RequestExecutionLevel admin

;CRC check the installer.
CRCCheck On

;--------------------------------
;Interface Settings

BrandingText "${InstallerName} ${InstallerVersion}"

!define MUI_ICON "tdmsystemfiles\darkmod.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "graphics\darkmodinstaller-header.bmp"

;show installation logs during (un)installation (show/hide/none)
ShowInstDetails show

;Installer file-description
VIProductVersion "0.0.0.0"
VIAddVersionKey ProductName "${InstallerName}"
VIAddVersionKey Comments "${InstallerName} is an application that creates the gamefolder and installs the updater for the game, The Dark Mod.  For additional details, visit ${AppWebsite}"
VIAddVersionKey CompanyName "${AppCreator}"
VIAddVersionKey LegalCopyright "${AppCreator}"
VIAddVersionKey FileDescription "${InstallerName} is an application that creates the gamefolder and installs the updater for the game, The Dark Mod.  For additional details, visit ${AppWebsite}"
VIAddVersionKey FileVersion ${InstallerVersion}
VIAddVersionKey ProductVersion ${InstallerVersion}
VIAddVersionKey InternalName "${InstallerName}"
VIAddVersionKey OriginalFilename "${InstallerFilename}"


;--------------------------------
;Pages


;Customized objects and settings for some Pages

;Custom Installer Welcome page
!define MUI_WELCOMEPAGE_TITLE "${AppName}"
!define MUI_WELCOMEPAGE_TEXT "Welcome to the installer for ${AppName}.$\n$\nThis application will create gamefolder and then install the updater for the game. $\n$\nAfter the installation, the updater will run to download the gamefiles.$\n$\nFor more information go to ${AppWebsite}$\n$\n$\n$\n${InstallerName} by Freek 'Freyk' Borgerink."
!insertmacro MUI_PAGE_WELCOME

;Custom Installer Licensepage
!define MUI_PAGE_HEADER_TEXT "License Agreement"
!define MUI_PAGE_HEADER_SUBTEXT "Please review the license agreement before installing ${AppName}."
!define MUI_LICENSEPAGE_TEXT_BOTTOM "You must accept the agreement to install ${AppName}. Click I agree to continue" 
!insertmacro MUI_PAGE_LICENSE "tdmsystemfiles\LICENSE.txt"

;Custom Components Page
!define MUI_PAGE_HEADER_TEXT "Choose Components"
!define MUI_PAGE_HEADER_SUBTEXT "Choose the features of ${AppName} you wish to install."
!insertmacro MUI_PAGE_COMPONENTS

;Custom Installer directorypage
!define MUI_PAGE_HEADER_TEXT "Choose Install Location"
!define MUI_PAGE_HEADER_SUBTEXT "Choose the folder where you would like to install ${AppName}."
DirText "This installer will install ${AppName} into the following folder.$\nTo install in a different folder, click Browse and select a different folder.$\nClick Install to begin the installation." \
  "Please specify the path of the game folder:"
!insertmacro MUI_PAGE_DIRECTORY

;Custom installer installerfiles page
!define MUI_PROGRESSBAR smooth
!define MUI_FINISHPAGE_NOAUTOCLOSE
!insertmacro MUI_PAGE_INSTFILES

;Custom Installer finishpage
!define MUI_FINISHPAGE_TITLE "Completing ${Appname} Setup"
!define MUI_FINISHPAGE_TEXT "${InstallerName} has created the gamefolder and installed the updater on your system.$\n$\nTo complete the installation of ${AppName},$\nthe required game files must now be downloaded.$\n$\nWhen you click on the finish button, the updater will run automatically."
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${AppName} Updater."
!define MUI_FINISHPAGE_RUN_CHECKED ;Checked checkbox to launch the updater
!define MUI_FINISHPAGE_RUN_FUNCTION "fncUpdaterRun" ;execute function to run the updater
;!define MUI_PAGE_CUSTOMFUNCTION_LEAVE fncUpdaterRun
!insertmacro MUI_PAGE_FINISH

; pages for uninstaller
;Custom Uninstaller Welcome Page
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "graphics\darkmodinstaller-panel.bmp"
!define MUI_WELCOMEPAGE_TITLE "${AppName}"
!define MUI_WELCOMEPAGE_TEXT "This uninstaller will remove ${AppName} from your system.$\n$\n$\n$\nUninstaller by Freek 'Freyk' Borgerink."
!insertmacro MUI_UNPAGE_WELCOME

;custom page for confirm uninstallpage
!define MUI_UNCONFIRMPAGE_TEXT_TOP "Are you sure you want to remove ${AppName} from your system?"
!define MUI_UNCONFIRMPAGE_TEXT_LOCATION "Remove from location:"
!insertmacro MUI_UNPAGE_CONFIRM

;custom page for detail uninstallpage
!define MUI_PAGE_HEADER_TEXT "Uninstalling ${AppName}"
!define MUI_PAGE_HEADER_SUBTEXT "Removing ${AppName} from your system"
!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT "Uninstalling ${AppName}"
!define MUI_INSTFILESPAGE_FINISHHEADER_SUBTEXT "Removing ${AppName} from your system"
!insertmacro MUI_UNPAGE_INSTFILES

;Custom Uninstaller FINISHPAGE Page
!define MUI_FINISHPAGE_TITLE "${AppName} Uninstaller"
!define MUI_FINISHPAGE_TEXT "${AppName} has been succesfully removed.$\n$\nFor more information or news about ${AppName}, $\nvisit ${AppWebsite}"
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages
 
!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Function .onInit
	;detect if system is 64 bit and change default instdir
	${If} ${RunningX64}
		StrCpy $InstDir "$PROGRAMFILES64\darkmod"
	${Else}
		StrCpy $InstDir "$PROGRAMFILES\darkmod"
	${EndIf}
FunctionEnd


Function fncUpdaterRun
	
	; Function to launch te updater	
	
	; Execute the updater with arguments
	ExecShell "" "$INSTDIR\tdm_update.exe" '--noselfupdate --targetdir="$INSTDIR"'

FunctionEnd


;Section "The Dark mod (Updater and Gamefolder)" SectionUpdater
Section "Gamefolder and updater" SectionUpdater
	
	;this section is requiered
	SectionIn RO

	; Set output path is the installation directory.
	SetOutPath $INSTDIR

	; Give all users Fullacces to the TDM gamefolder,
	; So tdm and updater can write files to it.
	;AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
	AccessControl::GrantOnFile  "$INSTDIR" "(S-1-5-32-545)" "FullAccess"
	AccessControl::EnableFileInheritance $INSTDIR		
	
	; Get the TDM files from here and copy to $INSTDIR
	File /r "tdmsystemfiles\"
	
	; Registry settings	
	; Object for the windows software update/remove section
	!define REG_U "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkMod"
	WriteRegStr HKCU "${REG_U}" "DisplayName" "${AppName}"
	WriteRegStr HKCU "${REG_U}" "DisplayVersion" "1.0"
	WriteRegStr HKCU "${REG_U}" "UninstallString" '"$INSTDIR\${UninstallerFilename}"'
	WriteRegStr HKCU "${REG_U}" "Publisher" "${AppCreator}"
	WriteRegStr HKCU "${REG_U}" "URLInfoAbout" "${AppWebsite}"
	WriteRegStr HKCU "${REG_U}" "DisplayIcon" "$INSTDIR\TDM_icon.ico"  
		
	; Create uninstaller
	WriteUninstaller "$INSTDIR\${UninstallerFilename}"

	; Setting up TDM Updater
    ; Detect that if the updater exists in the folder of the installer
    DetailPrint "Updaterfilecheck - Searching for updater"
	IfFileExists $EXEDIR\tdm_update.exe updater_found updater_not_found
	;If updater is found
    updater_found:
		DetailPrint "Updaterfilecheck - found external updater"
        CopyFiles $EXEDIR\tdm_update.exe $INSTDIR\tdm_update.exe
        goto end_of_UpdaterCheck ;
	;If updater is not found
    updater_not_found:
		DetailPrint "Updaterfilecheck - cannot find external updater"
		#Download updater
		
		#Look in file for location.
		#Var Updateronlinelocation
		#FileOpen $4 "..\updaterlocation.txt" r
		#FileRead $4 $Updateronlinelocation
		#FileClose $4
		
		DetailPrint "Updaterfilecheck - Downloading,.."
		NSISdl::download "${Updateronlinelocation}" "$INSTDIR\tdm_update_win.zip"
		Pop $R0 ;Get the return value
		${If} $R0 != "success"
			DetailPrint "Updaterfilecheck - Error: Download failed: $R0"
			DetailPrint "Updaterfilecheck - using internal tdmupdater"
			Rename $INSTDIR\tdm_update-069.xee $INSTDIR\tdm_update.exe
			goto end_of_UpdaterCheck ;			
		${EndIf}
		${If} $R0 = "success"
			DetailPrint "Updaterfilecheck - Updater downloaded"
			DetailPrint "Updaterfilecheck - Extracting updater to folder $INSTDIR"
			ZipDLL::extractall "$INSTDIR\tdm_update_win.zip" "$INSTDIR"
			DetailPrint "Updaterfilecheck - removing old zip"
			Delete "$INSTDIR\tdm_update_win.zip"
			Delete "$INSTDIR\tdm_update-069.xee"
			goto end_of_UpdaterCheck ;
		${EndIf}
		
    end_of_UpdaterCheck:
		DetailPrint "Updaterfilecheck - done"

SectionEnd


Section "Startmenu Shortcuts" SectionShortcuts

	; create start menu shortcuts for tdm
	CreateDirectory "$SMPROGRAMS\${AppName}" 
	CreateShortCut "$SMPROGRAMS\${AppName}\Uninstall ${AppName}.lnk" "$INSTDIR\${UninstallerFilename}" "" "$INSTDIR\darkmod.ico" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\License.lnk" "$INSTDIR\LICENSE.txt" "" "$INSTDIR\LICENSE.txt" 0
	CreateShortCut "$SMPROGRAMS\${AppName}\AUTHORS.lnk" "$INSTDIR\AUTHORS.txt" "" "$INSTDIR\AUTHORS.txt" 0	
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName} Updater.lnk" "$INSTDIR\tdm_update.exe" '--targetdir="$INSTDIR"' "$INSTDIR\darkmod.ico" 0 SW_SHOWNORMAL "" ""
	CreateShortCut "$SMPROGRAMS\${AppName}\${AppName}.lnk" "$INSTDIR\TheDarkMod.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""
	${If} ${RunningX64}
		CreateShortCut "$SMPROGRAMS\${AppName}\${AppName}-64bit.lnk" "$INSTDIR\TheDarkModx64.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""
	${EndIf}
  
SectionEnd


;Section /o "Desktop Shortcuts" SectionShortcutsDesktop
Section /o "Desktop Shortcuts" SectionShortcutsDesktop

	; create Desktop shortcuts for tdm
	CreateShortCut "$DESKTOP\${AppName} Updater.lnk" "$INSTDIR\tdm_update.exe" '--targetdir="$INSTDIR"' "$INSTDIR\darkmod.ico" 0 SW_SHOWNORMAL "" ""
	CreateShortCut "$DESKTOP\${AppName}.lnk" "$INSTDIR\TheDarkMod.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""
	; create Desktop shortcuts for tdm 64 bit
	${If} ${RunningX64}
		CreateShortCut "$DESKTOP\${AppName}-64bit.lnk" "$INSTDIR\TheDarkModx64.exe" "" "$INSTDIR\TDM_icon.ico" 0 SW_SHOWNORMAL "" ""
	${EndIf}  

SectionEnd


Section /o "TEST - Install Visual C++ (if needed)" SectionVCSInstall
	
	;This section installs Visual C++ studio files (if needed)
	
	;this section is requiered
	;SectionIn RO
	
	DetailPrint "Detecting if  required visual studio files are installed"
	ReadRegDword $R1 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\VC\Runtimes\x64" "Installed"
	ReadRegDword $R2 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\VC\Runtimes\x86" "Installed"
	${If} $R1 != "1"
		${AndIf} $R2 != "1"
			DetailPrint " visual studio files not installed"
			DetailPrint "Downloading latest Microsoft Visual C++ Redistributable"
			SetOutPath $INSTDIR			
			${If} ${RunningX64}
				DetailPrint "64-bit Windows Detected"
				DetailPrint "Visualstudio 64-bit setup - Downloading"
				inetc::get "https://aka.ms/vs/15/release/vc_redist.x64.exe" "$INSTDIR\vc_redist.x86.exe"
				DetailPrint "Visualstudio 64-bit setup - Running"
				;ExecWait '$INSTDIR\vc_redist.x64.exe /s /v" /qn"'
			${EndIf}  
			${IfNot} ${RunningX64}
				DetailPrint "32-bit Windows Detected"
				DetailPrint "Visualstudio 32-bit setup - Downloading"
				inetc::get "https://aka.ms/vs/15/release/vc_redist.x86.exe" "$INSTDIR\vc_redist.x86.exe"
				DetailPrint "Visualstudio 32-bit setup - Running"
				;ExecWait '$INSTDIR\vc_redist.x86.exe /s /v" /qn"'
			${EndIf}   
		${Else}
		DetailPrint "VisualStudio DLLs are is installed."
	${EndIf}
		
SectionEnd


Section /o "TEST - Add Shortcut in Steam" SectionInstallNonSteamGameShortcuts
	
	;this section is requiered
	;SectionIn RO
	
	;This section asks the user to add tdm in steam.
	DetailPrint "Steam - Opening client and Community page"
	ExecShell "open" "steam://openurl/https://steamcommunity.com/groups/thedarkmod"
	DetailPrint "Steam - Requesting user to adding tdm as nonsteamgame"
	MessageBox MB_OK "Please login in steam$\r$\nand select the the dark mod executable and updater in the list$\r$\nOr select them using the browse button"
	ExecShell "open" "steam://AddNonSteamGame"
	
SectionEnd





;--------------------------------
;Uninstaller Section
;Section "un.The Dark Mod" SectionTDM
Section "un.${AppName}" SectionTDM

	SectionIn RO
	
	;display uninstallpage
	SetAutoClose false ;

	; Remove registry keys  
	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\TheDarkMod"

	; Remove files and uninstaller
	RMDir /r $INSTDIR
	
	; Remove shortcuts, if any
	RMDir /r "$SMPROGRAMS\${AppName}"
	Delete "$DESKTOP\${AppName}\${AppName} Updater.lnk" 
	Delete "$DESKTOP\${AppName}.lnk"
	Delete "$DESKTOP\${AppName} Updater.lnk"
	  
SectionEnd


;Component Description
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionUpdater} "The Gamefolder and the TDM updater. The updater is required for downloading/updating the required game files."
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcuts} "Start menu shortcuts"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsDesktop} "Desktop shortcuts"
;!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcutsAdmin} "Startmenu shortcuts with admin privileges"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionVCSInstall} "This installs required visual studio files (if needed)"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionInstallNonSteamGameShortcuts} "This creates shortcut in Steam to the game"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionTDM} "${AppName}"
!insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;END of script file

/*
;--------------------------------
Changes / bugfixes 

1.0.1
- Created the installer

1.0.2
- Changed location of game folder
- Added privileges option

1.0.3
- Added more text and graphic content in unstaller 
- Changed the format of the installerscript, to make it more userfriendy.
- Added shortcut in Software Change/remove
- Added Component Descriptions
- Changed several textlabels.
- Changed the updater as a required component to install
- Changed (Commented out) codelines to create a placeholder for tdm.exe  

1.0.4 (20160313)
- Changed the startmenu shortcut for the updater.
- Added more info to welcometext
- Added an option to install desktop shortcuts
- Added code to remove the desktop shortcut files
- Changed BrandingText
- Changed some textlabels for welcometext,Directory,Finischpage
- Commentedout InstallerVersion in brandingtext, requested by Grayman 

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

v20160709
- Changed executionlevel to "user". To write create a tdm-folder in program files, run installer as admin.
- Removed shelllink from project
- removed argument "targetdir" from execshell tdm updater, because if the installer started with elevated permissions, it crashes the updater.
- Changed VIAddVersionKey versionnumbers

v20160712
- Changed executionlevel to "admin" (to run the installer with elevated permissions), discussed with bikerdude

v20160713
- added tdmupdate version 0.65

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

v20160717a
- Added setting "SetAutoClose false" to show uninstall details.
- Added headers to uninstall page.
- added quotes to targetdir-argument of the updater in fncUpdaterRun. So the updater dont crash when the path has spaces. 

v20160718
- Added targetdir-argument to shortcuts for updater.
- removed the runafterinstall-checkbox on finischpage. The updater will be automaticly started when the user hits the finisch button.

v20160728
- Brandingname issue found and reported ("The Dark Mod" or "The Darkmod").
- Changed Welcomescreen title for installer and uninstaller to ${AppName}. (request by Bikerdude)
- added variable ${AppName} to caption (un)installer & filename shortcuts.
- Added Grammerfixes by BikerDude to directorypage_HEADER_SUBTEXT, FINISHPAGE_TEXT, 
  uninstaller_WELCOMEPAGE_TEXT, UNCONFIRMPAGE_TEXT_TOP, 
  uninstaller_FINISHPAGE_TEXT and component description-SectionUpdater. 
  
v20160731
- Gammar fixes and additional text from teh_saccade.
  textlabel changes at pages: 
  VIAddVersionKey, MUI_WELCOMEPAGE_TEXT, MUI_LICENSEPAGE, Componentspage, 
  Location page, MUI_FINISHPAGE, un_welcomepage, unconfirmpage, unINSTFILESPAGE 
  and MUI_FUNCTION_DESCRIPTION
  
v20180703
- Added x64-bit detection
- Updated Updater from 0.64 to 0.69
- Updated Thedarkmod.exe x86 to 2.06
- Added Thedarkmod.exe x64 for 2.06 (and shortcuts)
- Added plugin inetc to download files on a https site

v20180722
- Added lines to set folder permissions, using AccessControl
- Changed finisch page to load tdm updater, only if the checkbox is checked.
- Added section to add a nonsteamgame shortcut to tdm in steam.

v20180723
- Changed default instdir to program files. (with 64bit system detection)

v20181125
- added an option to use the tdmupdater inside the folder of the installer. 
 (so there is no need to compile the updater if, there is a new version of the updater)
================================
*/