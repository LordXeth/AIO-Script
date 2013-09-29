@echo off
mode con:cols=80 lines=55
setlocal enabledelayedexpansion
set /p bg=<%~dp0tools\Settings\themebg.txt
set /p err=<%~dp0tools\Settings\themeerr.txt
set /p high=<%~dp0tools\Settings\themehigh.txt
set /p dis=<%~dp0tools\Settings\themedis.txt
set /p noupdatecheck=<%~dp0tools\Settings\updates.txt
set /p api=<%~dp0tools\Settings\api.txt
set /p sdklocation=<%~dp0tools\Settings\sdk_location.txt
%~dp0tools\adb.exe remount
%~dp0tools\Apps\chgcolor %bg%
if (%1)==(0) goto skip
echo -------------------------------------------------------------------------->>%~dp0tools\logs\log.log
echo Started RUJELUS22's AIO APK Tool>>%~dp0tools\logs\log.log
echo %date% -- %time%>>%~dp0tools\logs\log.log
echo -------------------------------------------------------------------------->>%~dp0tools\logs\log.log
Script 0 2>>%~dp0tools\logs\log.log
:skip
::DO NOT REMOVE
if %noupdatecheck%==0 goto skipupdatecheck
set /a cc = 1
if exist %~dp0tools\checkversion.txt del /q %~dp0tools\checkversion.txt > NUL
cd %~dp0tools
%~dp0tools\Apps\wget\wget -q http://downloads.teamvenum.com/aio_script/checkversion.txt > NUL
cd %~dp0
set /p check=<%~dp0tools\checkversion.txt
set /p current=<%~dp0tools\Settings\version.txt
if /I !current! LSS !check! (
	echo.
	%~dp0tools\Apps\chgcolor %high%
	echo New Update Found
	echo Choose options then Check and Install an update to install.
	%~dp0tools\Apps\chgcolor %bg%
	echo.
	PAUSE
)
::DO NOT REMOVE
:skipupdatecheck
if exist %~dp0tools\checkversion.txt del /q %~dp0tools\checkversion.txt > NUL
if not exist %~dp0backup\ mkdir %~dp0backup
if not exist %~dp0done\ mkdir %~dp0done
if not exist %~dp0done\optimized\ mkdir %~dp0done\optimized
if not exist %~dp0done\flashable\ mkdir %~dp0done\flashable
if not exist %~dp0droid-screen\ mkdir %~dp0droid-screen
if not exist %~dp0originals\ mkdir %~dp0originals
if not exist %~dp0phone-info\ mkdir %~dp0phone-info
if not exist %~dp0PlaceApksHere\ mkdir %~dp0PlaceApksHere
if not exist %~dp0place-here-for-modding\ mkdir %~dp0place-here-for-modding
if not exist %~dp0place-scale-images\ mkdir %~dp0place-scale-images
if not exist %~dp0place-scale-images\res\ mkdir %~dp0place-scale-images\res
if not exist %~dp0projects\ mkdir %~dp0projects
if not exist %~dp0projects-smali\ mkdir %~dp0projects-smali
if not exist %~dp0pulled\ mkdir %~dp0pulled
if not exist %~dp0dot9\ mkdir %~dp0dot9
cls
echo.
echo                          AIO Android Tool V2.0.0.3.5
echo.
echo.
echo                    ........                       ........                     
echo                ..,$MMMMMMM+,...                ..,$MMMMMM8=,,.               
echo               .MMMMMMMMMMMMMMO:,...         ..=NMMMMMMMMMMMMMN.               
echo               .MMMMMMMMMMMMMMMMMM?:,,,,,,,+ZMMMMMMMMMMMMMMMMMM+.              
echo               .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO+.              
echo                IMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM87 $.             
echo          ...I7  ~MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8I+ M~.           
echo         .M~:MN=  :?MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN$+  :M?~D=.        
echo        .DMMMMMI:    +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMD$+   :MMMMMM+.       
echo        .MMMMMMMZI:,,:ZMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$+:,,IMMMMMMMO~.       
echo        .$MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7~.       
echo         .OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMZ+.       
echo        ..:$MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$+.       
echo       .DM~:=DMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMOI=OM=.      
echo       .+MD~:~IMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMD$?~:MM?.      
echo        .MMZ~,,:=+$MMMMMMMMMMMM  MMMMMMMMMMMM  MMMMMMMMMMMMNZII=:,,MM$+.       
echo        .~MMMMZ:,.,:=?8MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO7?=~,,,MMMMMI.       
echo         .IMMMM$~,...,:~+IZMMMMMMMMMMMMMMMMMMMMMMMMD$$I+~:,....MMMMM$.        
echo          .7MMMM?=,. .MMN$+=+?ZMMMMMD$I??$MMMMMNZ7?+$ZMM?:. .,DMMMM$.        
echo           .$MMMMZ~...7MMMMM+:,:=+++=:    :==++=~:OMMMMMI~. .MMMMM$.         
echo            .OMMMMI:..,MMMMM7.                   .8MMMMO?, .NMMMM$.           
echo             .8MMMM+, .~MMMM$.                   .MMMMNI~ .7MMMM$.            
echo              .DMMMN=, .~MMM8.                   .MMMN7~ :MMMMZ.             
echo               .DMMMO~.  .$M8.                   .MM$I~  .MMMMZ.              
echo                :=MMMI:.  ,=M.                   .D?=   .DMMM7.               
echo                 .?MMM+,    :.                   .::   .+MMM7.                
echo                  .?MMN=,    .                    .    .MMM7.                
echo                   .IMM$~.                            .MMM$.                 
echo                    .$MM?:.                          .ZMM7.                   
echo                     :MMD~.                          .MMZ.                    
echo                      :IM?=,                        .NM7.                     
echo                       :MI+,                        .MD.                      
echo                       .MI+,   .                    .MI.                      
echo                       .7+,   .O,            ..I,   .M.                        
echo                        .     .M~,           .8$~.   .                         
echo                              .MN=,          :MO=.                            
echo                              .MMZ~,        .MM8=.                              
echo                              .MMMO+,     .7MMM8+.                              
echo                              .MMMMM8~,..:MMMMM8+.                              
echo                              .MMMMMMMM8MMMMMMMD=.                              
echo                               .=7MMMMMMMMMMNZ7+.                               
echo                                  .~+7MMNZ7?+~.                                 
echo                                     ,:~=~,.                                    
echo                                       ...          
echo.
echo.
echo                           Brought to you by RUJELUS22
echo                                 and TeaM VeNuM
echo                                  and LordXeth
echo.
PAUSE
cls
mode con:cols=80 lines=61
if not exist %~dp0tools\Settings\firstrun.txt goto firstopen
:afterfirstrun
set firstrun=off
echo 1 > %~dp0tools\Settings\firstrun.txt
echo Checking ADB connection status
set adbwifi=Connected
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set /A count+=1
	set a!count!=%%a
)
if /I !count! LSS 1 set adbwifi=Disconnected
if /I !count! GTR 1 set adbwifi=Connected
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set file=%month%.%day%.%year%_%hour%.%min%
set /p apktool=<%~dp0tools\Settings\apktool_settings.txt
set /p usrc=<%~dp0tools\Settings\compression_settings.txt
set capp=All
set heapy=512
set jar=0
set /p sound=<%~dp0tools\Settings\beep.txt
java -version
if errorlevel 1 goto nojava
if not exist "%sdklocation%" goto nosdk
set /A count=0
for %%F in (place-here-for-modding/*) do (
	set /A count+=1
	set tmpstore=%%~nF%%~xF
)
if %count%==1 set capp=%tmpstore%
cls
:restart
set signleodex=0
set rest_=%capp%
    set /a count_=0
    if not defined rest_ (set /a count_=-1 & set rest_=X)
    :_loop
      set /a count_+=1
      set rest_=%rest_:~1%
      if defined rest_ goto :_loop
set capplength=%count_% & goto next
:next
if %capplength% GTR 35 set cappmenu=!capp:~0,35!...
if %capplength% LSS 36 set cappmenu=%capp%
set remountavlible=No
echo Checking ADB connection status
set adbwifi=Connected
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set /A count+=1
	set a!count!=%%a
)
if /I !count! LSS 1 set adbwifi=Disconnected
if /I !count! GTR 1 set adbwifi=Connected
cls
for /F "tokens=*" %%i in ('adb.exe remount') do set remount=%%i
if "%remount%"=="remount succeeded" (
	set remountavlible=Yes
)
echo %remountavlible%>%~dp0tools/temp/remount.txt
set /p bg=<%~dp0tools\Settings\themebg.txt
set /p err=<%~dp0tools\Settings\themeerr.txt
set /p high=<%~dp0tools\Settings\themehigh.txt
set /p dis=<%~dp0tools\Settings\themedis.txt
set decompileeverythingselected=0
%~dp0tools\Apps\chgcolor %bg%
set menu1=error
if %sound% EQU 1 set sound2=On
if %sound% EQU 0 set sound2=Off
																				::BEGIN THE MENU
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  RUJELUS22s Android AIO Tool
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
																				::ADB WIFI CONNECT MENU
if %adbwifi%==Connected goto adbwificonnected
if %adbwifi%==Disconnected goto adbwifidisconnected
:adbwificonnected
%~dp0tools\Apps\chgcolor %dis%
echo  -    Already Connected to the phone
%~dp0tools\Apps\chgcolor %bg%
goto adbwifidone
:adbwifidisconnected
echo  0    Connect to phone through adb wifi
:adbwifidone
																				::PULL MENU
if %adbwifi%==Disconnected goto pulldisconnected
if %adbwifi%==Connected goto pullconnected
:pulldisconnected
set pull=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected to pull from
%~dp0tools\Apps\chgcolor %bg%
goto pullmenudone
:pullconnected
set pull=on
echo  1    Pull something from the phone
:pullmenudone
																				::DECOMPILE MENU
set odexfile=!capp:~0,-4!.odex
if %adbwifi%==Disconnected goto disconnecteddecompile
:checkfornonodex
if exist %~dp0place-here-for-modding\*.apk goto allowdecompile
if exist %~dp0place-here-for-modding\*.jar goto allowdecompile
:nodecompile
set decompile=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    Nothing in place-here-for-modding
%~dp0tools\Apps\chgcolor %bg%
goto decompilemenudone
:disconnecteddecompile
if not exist %~dp0place-here-for-modding\%odexfile% goto checkfornonodex
set decompile=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone connected to decompile with
%~dp0tools\Apps\chgcolor %bg%
goto decompilemenudone
:allowdecompile
set decompile=on
echo  2    Decompile %cappmenu%
:decompilemenudone
																				::OPTIMIZE MENU
if %jar%==1 goto notdecompiledoptimizejar
if not exist %~dp0projects\%capp% goto notdecompiledoptimize
if exist %~dp0projects\%capp% goto optimizemenu
:notdecompiledoptimize
set optimize=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    %cappmenu% has not been decompiled yet
%~dp0tools\Apps\chgcolor %bg%
goto optimizemenudone
:optimizemenu
set optimize=on
echo  3    Optimize images inside the %cappmenu% folder
goto optimizemenudone
:notdecompiledoptimizejar
set optimize=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No images in a jar to optimize
%~dp0tools\Apps\chgcolor %bg%
:optimizemenudone
																				::COMPILE MENU
set odexfile=!capp:~0,-4!.odex
if %adbwifi%==Disconnected goto disconnectedcompileodex
::DO NOT REMOVE
:compilenonodex
if not exist %~dp0projects\%capp% if not exist %~dp0projects-smali\%capp% goto compilenotdecompiled
if exist %~dp0projects\%capp% goto connectedcompile
if exist %~dp0projects-smali\%capp% goto connectedcompile
:compilenotdecompiled
set compile=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    %cappmenu% has not been decompiled
%~dp0tools\Apps\chgcolor %bg%
goto compilemenudone
:disconnectedcompileodex
if not exist %~dp0place-here-for-modding\%odexfile% goto compilenonodex
set compile=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone connected to compile with
%~dp0tools\Apps\chgcolor %bg%
goto compilemenudone
:connectedcompile
set compile=on
echo  4    Compile %cappmenu%
:compilemenudone
																				::SIGN MENU
if not exist %~dp0done\unsigned%capp% goto unsignednotfound
if exist %~dp0done\unsigned%capp% goto allowsign
:unsignednotfound
set sign=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    %cappmenu% has not been compiled yet
%~dp0tools\Apps\chgcolor %bg%
goto signmenudone
:allowsign
set sign=on
echo  5    Sign %cappmenu%
:signmenudone
																				::ZIPALIGN MENU
echo  6    Zipalign Menu
																				::CWM ZIP MENU
set zip=on
echo  7    Make a CWM Flashable Zip
																				::INSTALL MENU
if %jar%==1 goto noinstalljarfile
if %adbwifi%==Disconnected goto noinstall
if not exist %~dp0done\signed%capp% goto nosignedinstall
if exist %~dp0done\signed%capp% goto allowinstall
:noinstall
set install=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected to install to
%~dp0tools\Apps\chgcolor %bg%
goto installmenudone
:nosignedinstall
set install=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    %cappmenu% has not been signed
%~dp0tools\Apps\chgcolor %bg%
goto installmenudone
:noinstalljarfile
set install=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    You can not install a jar file
%~dp0tools\Apps\chgcolor %bg%
goto installmenudone
:allowinstall
set install=on
echo  8    Install %cappmenu% to the phone
:installmenudone
																				::PUSHMENU
if %adbwifi%==Disconnected goto nopushmenu
if %adbwifi%==Connected goto allowpushmenu
:nopushmenu
set push=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected to push to
%~dp0tools\Apps\chgcolor %bg%
goto pushmenudone
:allowpushmenu
set push=on
echo  9    Push something to the phone
:pushmenudone
																				::FLASH MENU
if %adbwifi%==Disconnected goto nophoneflashmenu
if %remountavlible%==No goto noremountflash
if %adbwifi%==Connected goto allowflashmenu
:nophoneflashmenu
set flash=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected to flash to
%~dp0tools\Apps\chgcolor %bg%
goto flashmenudone
:noremountflash
set flash=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    Your kernel does not support this feature [adb remount]
%~dp0tools\Apps\chgcolor %bg%
goto flashmenudone
:allowflashmenu
set flash=on
echo  10   Flash something to the phone
:flashmenudone
																				::ODEX MENU
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Odex Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
if %adbwifi%==Disconnected goto odexmenunophone
if %remountavlible%==No goto odexmenunoremount
if %adbwifi%==Connected goto allowodex
:allowodex
set odex=on
echo  20   Deodex the ROM on your phone
echo  21   Deodex a single file
echo  22   Odex the ROM on your phone
echo  23   Odex a single file
echo  24   Odex Information
echo.
goto odexmenudone
:odexmenunophone
set odex=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No Phone Plugged in               
echo  -    No Phone Plugged in
echo  -    No Phone Plugged in
echo  -    No Phone Plugged in
%~dp0tools\Apps\chgcolor %bg%
echo  24   Odex Information
echo.
goto odexmenudone
:odexmenunoremount
set odex=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    Your kernel does not support this feature [adb remount]            
echo  -    Your kernel does not support this feature [adb remount]
echo  -    Your kernel does not support this feature [adb remount]
echo  -    Your kernel does not support this feature [adb remount]
%~dp0tools\Apps\chgcolor %bg%
echo  24   Odex Information
echo.
:odexmenudone
																				::SPECIAL ITEMS MENU
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Special Items
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  90   Open Color Edit
if not exist %~dp0dot9\*.9.png goto skipcompile9
set compile9=on
echo  91   Compile all .9's in %~dp0dot9
goto skipcompile9done
:skipcompile9
set compile9=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    no .9 Images in %~dp0dot9
%~dp0tools\Apps\chgcolor %bg%
:skipcompile9done
echo  92   Open MD5 Checker
echo  93   Phone and Emulator Menu
																				::SEARCH ITEMS
if not exist %~dp0projects\*.apk goto noapksearch
if exist %~dp0projects\*.apk goto allowsearch
:noapksearch
if not exist %~dp0projects-smali\*.jar goto nothingtosearch
if exist %~dp0projects-smali\*.jar goto allowsearch
:nothingtosearch
set search=off
%~dp0tools\Apps\chgcolor %dis%
echo   -   Nothing decompiled to search
%~dp0tools\Apps\chgcolor %bg%
goto searchmenudone
::DO NOT REMOVE
:noallsearch
set search=off
%~dp0tools\Apps\chgcolor %dis%
echo   -   You can not search All [Choose a project]
%~dp0tools\Apps\chgcolor %bg%
goto searchmenudone
:allowsearch
if %capp% EQU All goto noallsearch
::DO NOT REMOVE
set search=on
echo  94   Search inside of %cappmenu%
:searchmenudone
																			::SPECIAL ITEMS BOTTOM
echo  95   Open Notepad++ [With smali highlighting]
echo  96   Open a Color Wheel
echo  97   Color Change [for smali]
echo.
echo  98   Other Tools
echo  99   Options and Misc
echo.
																				::SELECT MENU
echo  ------------------------------------------------------------------------------
echo  #########  11   Select Project ################  100   Refresh Tool  #########
echo  ------------------------------------------------------------------------------
echo  ###############################  **   Exit App  ##############################
echo  ------------------------------------------------------------------------------
SET /P menu1=Please make your decision:
																			::END MENU CHOICES
if %menu1% EQU backup (
	set odexbackup=yes
	goto backupb4odex
)
if %adbwifi%==Connected goto disableconnect
if %menu1%==0 goto connect
:disableconnect

if %push%==on goto enablepush
if %push%==off goto disablepush
:enablepush
if %menu1%==1 goto pull
:disablepush

if %decompile%==on goto enabledecompile
if %decompile%==off goto disabledecompile
:enabledecompile
if %menu1%==2 goto decompile
:disabledecompile

if %optimize%==on goto enableoptimize
if %optimize%==off goto disableoptimize
:enableoptimize
if %menu1%==3 goto optimize
:disableoptimize

if %compile%==on goto enablecompile
if %compile%==off goto disablecompile
:enablecompile
if %menu1%==4 goto compile
::DO NOT REMOVE
:disablecompile

if %sign%==on goto enablesign
if %sign%==off goto disablesign
:enablesign
if %menu1%==5 goto sign
:disablesign

if %menu1%==6 goto zipalign
if %menu1%==7 goto makezip

if %install%==on goto enableinstall
if %install%==off goto disableinstall
:enableinstall
if %menu1%==8 goto install
:disableinstall

if %push%==on goto enablepush
if %push%==off goto disablepush
:enablepush
if %menu1%==9 goto push
:disablepush

if %flash%==on goto enableflash
if %flash%==off goto disableflash
:enableflash
if %menu1%==10 goto flash
:disableflash

if %menu1%==11 goto setproject

if %odex%==on goto enableodex
if %odex%==off goto disableodex
:enableodex
if %menu1%==20 goto deodexwarning
if %menu1%==21 set signleodex=1 & goto setapi
if %menu1%==22 goto odexwarning
if %menu1%==23 goto reodexchoose
::DO NOT REMOVE
:disableodex
if %menu1%==24 goto odexinformation

if %menu1%==90 goto coloredit
if %compile9%==off goto disablecompile9
if %menu1%==91 goto xultimate
:disablecompile9
if %menu1%==92 goto md5checker
::DO NOT REMOVE
if %menu1%==93 goto phone

if %search%==on goto enablesearch
if %search%==off goto disablesearch
:enablesearch
if %menu1%==94 goto search
:disablesearch

if %menu1%==95 goto notepad
if %menu1%==96 goto colorpick
::DO NOT REMOVE
if %menu1%==97 goto colorchange
if %menu1%==98 goto othertools
if %menu1%==99 goto options
if %menu1%==100 goto restart
::DO NOT REMOVE
if %menu1%==** goto leave
goto what

:what
cls
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %err%
echo You entered an option that is not part of the menu
%~dp0tools\Apps\chgcolor %bg%
if %sound%==0 goto skipbeep
start /min %~dp0tools\beep.bat
:skipbeep
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:nosdk
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  The Android SDK was not found
%~dp0tools\Apps\chgcolor %bg%
if %sound%==0 goto skipbeep
start /min %~dp0tools\beep.bat
:skipbeep
echo  ------------------------------------------------------------------------------
echo.
echo  If you have already installed the SDK but not to the default location choose 
echo  option 99 on the main menu then option 5 and set the path to your SDK
echo.
echo.
echo  If you have not installed it already I can start the download for you.
echo.
set /P input=Download SDK [y/n]:
if %input% EQU y start http://dl.google.com/android/installer_r22.2.1-windows.exe
echo.
goto restart
:nojava
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  Java was not found.
%~dp0tools\Apps\chgcolor %bg%
if %sound%==0 goto skipbeep
start /min %~dp0tools\beep.bat
:skipbeep
echo  ------------------------------------------------------------------------------
echo.
echo  Would you like me to open the download page for you?
echo.
set /P input=Please make your decision [y/n]:
if %input% EQU y start http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
echo.
exit
																				::SET A PROJECT
:setproject
set input=error
cls
echo  ------------------------------------------------------------------------------>%~dp0tools\temp\filelist.txt
echo  Current Project: %capp%>>%~dp0tools\temp\filelist.txt
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2%>>%~dp0tools\temp\filelist.txt
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb>>%~dp0tools\temp\filelist.txt
echo  ------------------------------------------------------------------------------>>%~dp0tools\temp\filelist.txt
echo  Choose a projects>>%~dp0tools\temp\filelist.txt
set /A count=0
for %%f in (place-here-for-modding/*) do (
	if "%%~xf" NEQ ".odex" set /A count+=1
)
if !count! GTR 35 (
	echo.>>%~dp0tools\temp\filelist.txt
	echo  Space Bar = Next Page          Enter = Next Line>>%~dp0tools\temp\filelist.txt
)
echo  ------------------------------------------------------------------------------>>%~dp0tools\temp\filelist.txt
echo   0   All>>%~dp0tools\temp\filelist.txt
set /A count=0
cd %~dp0
for %%f in (place-here-for-modding/*) do (
	if "%%~xf" NEQ ".odex" set /A count+=1
	if "%%~xf" NEQ ".odex" set a!count!=%%f
	if /I !count! LSS 10 if "%%~xf" NEQ ".odex" echo   !count!   %%f>>%~dp0tools\temp\filelist.txt
	if /I !count! GTR 9  if "%%~xf" NEQ ".odex" echo   !count!  %%f>>%~dp0tools\temp\filelist.txt
)
echo  ------------------------------------------------------------------------------>>%~dp0tools\temp\filelist.txt
type %~dp0tools\temp\filelist.txt | more /e +0
set /P input=Enter It's Number: %=%
if /I %input% GTR !count! goto what
if /I %input% LSS 1 (
	set capp=All
	set usrc=9
	set dec=0
	set capp=All
	set heapy=512
	set jar=0
	goto restart
)
set capp=!a%input%!
set jar=0
set ext=jar
if "!capp:%ext%=!" NEQ "%capp%" set jar=1
del /q %~dp0tools\temp\filelist.txt
goto restart
																				::CONNECT
:connect
cls
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  What is the IP of your phone
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  99   Go Back
echo.
echo  ------------------------------------------------------------------------------
set input=error
set /P input=Type input: %=%
if %input%==99 goto restart
%~dp0tools\adb.exe connect %input% > NUL
if errorlevel 1 goto errorlogadb
set adbwifi=Connected
echo.
echo Successfully connected to your phone with adbwifi
goto restart
:errorlogadb
if %sound%==0 goto skipbeep1
start /min %~dp0tools\beep.bat
:skipbeep1
%~dp0tools\Apps\chgcolor %err%
echo "Could not connect to the phone"
%~dp0tools\Apps\chgcolor %bg%
PAUSE
set adbwifi=Disconnected
goto restart
																				::PULL START
:pull
cls
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto pullmenu
echo.
%~dp0tools\Apps\chgcolor %high%
echo There are multiple devices plugged in. Which do you want to pull from?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
)
set input=error
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
goto pullmenu
																				::PULL ONE OR MORE
:pullmenu
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Pull Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Pull One File
echo  2    Pull More than one File
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Type input: %=%
if %input% EQU 1 goto pullone
if %input% EQU 2 goto pullall
if %input% EQU 99 goto restart
goto what
																				::PULL ALL START
:pullall
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to pull
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Pull /system/app/
echo  2    Pull /system/framework/
echo  3    Pull /data/app/
echo  4    Pull The Whole system
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Type input: %=%
if %input% EQU 2 goto pullframe
if %input% EQU 1 goto pullapp
if %input% EQU 3 goto pulldata
if %input% EQU 4 goto dumpsystem
if %input% EQU 99 goto restart
goto what
																				::PULL ENTIRE SYSTEM
:dumpsystem
if exist %~dp0pulled\Phone rd /s /q %~dp0pulled\Phone > NUL
mkdir %~dp0pulled\Phone > NUL
mkdir %~dp0pulled\Phone\system > NUL
mkdir %~dp0pulled\Phone\data > NUL
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
echo.
echo Pulling zImage and everything from /system/ and /data/ to:
echo %~dp0pulled\Phone
%~dp0tools\adb.exe -s %devicefinal% pull /system/ %~dp0pulled\Phone\system\ > NUL
%~dp0tools\adb.exe -s %devicefinal% pull /data/ %~dp0pulled\Phone\data\ > NUL
%~dp0tools\adb.exe -s %devicefinal% shell dd if=/dev/block/mmcblk0p6 of=/sdcard/pulled-zImage > NUL
%~dp0tools\adb.exe -s %devicefinal% pull /sdcard/pulled-zImage %~dp0pulled\Phone\zImage > NUL
%~dp0tools\adb.exe -s %devicefinal% shell rm /sdcard/pulled-zImage > NUL
echo successfully pulled everything from /system/ and /data/
goto restart
																				::PULL /SYSTEM/FRAMEWORK/
:pullframe
if exist %~dp0pulled\system\framework rd /s /q %~dp0pulled\system\framework > NUL
mkdir %~dp0pulled\system\framework > NUL
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
echo.
echo Pulling all apps and jars from \system\framework\ to:
echo %~dp0pulled\system\framework
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/ %~dp0pulled\system\framework\ > NUL
echo successfully pulled all apks and jars from /system/framework/
goto restart
																				::PULL /SYSTEM/APP/
:pullapp
if exist %~dp0pulled\system\app rd /s /q %~dp0pulled\system\app > NUL
mkdir %~dp0pulled\system\app > NUL
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
echo.
echo Pulling all apps from \system\app\ to:
echo %~dp0pulled\system\app
%~dp0tools\adb.exe -s %devicefinal% pull /system/app/ %~dp0pulled\system\app\ > NUL
echo successfully pulled all apks from /system/app/
goto restart
																				::PULL /DATA/APP/
:pulldata
if exist %~dp0pulled\data\app rd /s /q %~dp0pulled\data\app > NUL
mkdir %~dp0pulled\data\app > NUL
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
echo.
echo Pulling all apps from \data\app\ to:
echo %~dp0pulled\data\app
%~dp0tools\adb.exe -s %devicefinal% pull /data/app/ %~dp0pulled\data\app\ > NUL
echo successfully pulled all apks from /data/app/
goto restart
																				::PULL ONE FILE
:pullone
cls
set input=error
echo.
%~dp0tools\Apps\chgcolor %high%
echo What apk would you like to pull?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Example: /system/app/Settings.apk
echo.
set /P input=Type input: %=%
echo Pulling %input%
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% pull %input% %~dp0tools\temp\temp.apk > NUL
%~dp0tools\adb.exe -s %devicefinal% pull !input:~0,-4!.odex %~dp0tools\temp\temp.odex > NUL
set jar=0
set ext=jar
if "!input:%ext%=!" NEQ "%input%" set jar=1
echo.
for %%a in (%input%) do (
	%~dp0tools\Apps\chgcolor %high%
	echo The current file name is %%~nxa would you like to change it?
	%~dp0tools\Apps\chgcolor %bg%
	set tempname=%%~nxa
)
set inputrename=error
echo.
set /P inputrename=Type input: %=%
if %inputrename%==y goto renameapk
if %inputrename%==n goto norenameapk
goto what
																				::PULL ONE FILE RENAME FILE
:renameapk
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo What would you like to name this file?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Example: Settings.apk
set /P input=Type input: %=%
if exist %~dp0pulled\%input% (
	echo.
	%~dp0tools\Apps\chgcolor %err%
	echo That name already exists, Try another name
	%~dp0tools\Apps\chgcolor %bg%
	PAUSE
	goto renameapk)
	rename "%~dp0tools\temp\temp.apk" %input% > NUL
	rename "%~dp0tools\temp\temp.odex" !input:~0,-4!.odex > NUL
	echo.
	set inab=error
	%~dp0tools\Apps\chgcolor %high%
	echo Would you like to set this as your current project [y/n]
	%~dp0tools\Apps\chgcolor %bg%
	echo.
	set /P inab=Type input: %=%
	if %inab%==y (
	move /y %~dp0tools\temp\%input% %~dp0place-here-for-modding\%input% > NUL
	copy /y %~dp0place-here-for-modding\%input% %~dp0pulled\%input% > NUL
	move /y %~dp0tools\temp\!input:~0,-4!.odex %~dp0place-here-for-modding\!input:~0,-4!.odex > NUL
	copy /y %~dp0place-here-for-modding\!input:~0,-4!.odex %~dp0pulled\!input:~0,-4!.odex > NUL
	set capp=%input%
)
if %inab%==n move /y %~dp0tools\temp\%input% %~dp0pulled\%input% > NUL
if %inab%==n move /y %~dp0tools\temp\%input% %~dp0pulled\!input:~0,-4!.odex > NUL
goto restart
																				::PULL ONE FILE NO RENAME
:norenameapk
set  input=%tempname%
echo.
set inab=error
%~dp0tools\Apps\chgcolor %high%
echo Would you like to set this as your current project [y/n]
%~dp0tools\Apps\chgcolor %bg%
echo.
set /P inab=Type input: %=%
if %inab%==y (
	move /y %~dp0tools\temp\temp.apk %~dp0place-here-for-modding\%input% > NUL
	copy /y %~dp0place-here-for-modding\%input% %~dp0pulled\%input% > NUL
	move /y %~dp0tools\temp\temp.odex %~dp0place-here-for-modding\!input:~0,-4!.odex > NUL
	copy /y %~dp0place-here-for-modding\!input:~0,-4!.odex %~dp0pulled\!input:~0,-4!.odex > NUL
	set capp=%input%
)
if %inab%==n (
	set  input=%tempname%
	move /y %~dp0tools\temp\temp.apk %~dp0pulled\%input% > NUL
	move /y %~dp0tools\temp\temp.odex %~dp0pulled\!input:~0,-4!.odex > NUL
)
goto restart
																				::FLASH MENU
:flash
echo Checking ADB connection status
set adbwifi=Connected
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
cls
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto flashsomething
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo There are multiple devices plugged in. Which do you want to flash to?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::FLASH SINGLE DEVICES
:flashsomething
cls
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  This will Flash a CWM zip of your choosing to the phone:
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Is this what you want to do?
echo.
echo  ------------------------------------------------------------------------------
set input=error
set /P input=Continue [y/n]: %=%
if %input% EQU n goto restart
set input=error
echo.
%~dp0tools\Apps\chgcolor %high%
echo What do you want to flash?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Example: C:\something.apk.zip
set /P input=Type input: %=%
echo.
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
%~dp0tools\Apps\chgcolor %high%
echo Copying the zip to your phone
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Please Wait...
echo.
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set date=%hour%_%min%
%~dp0tools\adb.exe shell mkdir /sdcard/Flashables > NUL
%~dp0tools\adb.exe push %input% /sdcard/Flashables/%date%_AIO_CWM.zip > NUL
%~dp0tools\adb.exe -s %devicefinal% shell "echo 'install_zip(\"/emmc/Flashables/%date%_AIO_CWM.zip\");' >> /cache/recovery/extendedcommand"
%~dp0tools\adb.exe -s %devicefinal% shell "echo install /mnt/sdcard/Flashables/%date%_AIO_CWM.zip >> /cache/recovery/openrecoveryscript"
echo Rebooting your phone
%~dp0tools\adb.exe reboot recovery > NUL
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::PUSH START
:push
echo Checking ADB connection status
set adbwifi=Connected
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
cls
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto pushmenu
echo.
%~dp0tools\Apps\chgcolor %high%
echo There are multiple devices plugged in. Which do you want to push to?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
set input=error
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::PUSH MENU
:pushmenu
set menu5=error
cls
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to push
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
if not exist %~dp0done\signed%capp% if not exist %~dp0done\unsigned%capp% if not exist %~dp0done\%capp% goto nopushproject
set pushpro=yes
echo.
echo  1    Push your project to the phone
goto pushprojectdone
:nopushproject
set pushpro=no
%~dp0tools\Apps\chgcolor %dis%
echo  -    No signed or unsigned project to push
%~dp0tools\Apps\chgcolor %bg%
:pushprojectdone
if not exist %~dp0done\flashable\%capp%-CWM.zip goto nocwmpush
echo  2    Push your Flashable zip to /sdcard/Flashables/
goto cwmpushdone
:nocwmpush
%~dp0tools\Apps\chgcolor %dis%
echo  -    No Flashable %capp% to push
%~dp0tools\Apps\chgcolor %bg%
:cwmpushdone
echo  3    Push something else to the phone
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P menu5=Type input: %=%
if %pushpro%==no goto nopushpro
if %menu5% EQU 1 goto pushsignedunsigned
::DO NOT REMOVE
:nopushpro
if %pushpro%==no goto nopushcwm
if %menu5% EQU 2 goto pushcwm
:nopushcwm
if %menu5% EQU 3 goto pushsomething
if %menu5% EQU 99 goto restart
goto what
																				::PUSH SOMETHING
:pushsomething
echo.
set input=error
set input2=error
%~dp0tools\Apps\chgcolor %high%
echo What do you want to push?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Example: C:\something.apk
set /P input=Type input: %=%
echo.
%~dp0tools\Apps\chgcolor %high%
echo Where do you want to push it?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Example of input : /system/app/Settings.apk
set /P input2=Type input: %=%
echo Waiting for device
echo.
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
echo.
echo Pushing %input% to %input2%
%~dp0tools\adb.exe -s %devicefinal% push %input% %input2% > NUL
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo Push finished
echo.
echo Pushed %input% to %input2%
%~dp0tools\Apps\chgcolor %bg%
PAUSE
goto restart
																				::PUSH CHECK IF SIGNED OR NOT
:pushsignedunsigned
::DO NOT REMOVE
set signed=n
set unsigned=n
if exist %~dp0done\signed%capp% set signed=y
if exist %~dp0done\unsigned%capp% set unsigned=y
if %signed% EQU y goto signedyes
if %unsigned% EQU y goto pushunsigned
echo.
%~dp0tools\Apps\chgcolor %err%
echo Niether done\signed%capp% or done\unsigned%capp% was found
echo.
echo Make sure you compile your project first
%~dp0tools\Apps\chgcolor %bg%
if %sound%==0 goto skipbeep2
start /min %~dp0tools\beep.bat
:skipbeep2
echo.
PAUSE
goto restart
:signedyes
if %unsigned% EQU y goto bothsignedun
goto pushsigned

																				::PUSH BOTH SIGNED PUSH WHICH
:bothsignedun
set input=error
echo.
echo Is your project signed or not? [y/n]
set /P input=Type input: %=%
if %input% EQU y goto pushsigned
if %input% EQU n goto pushunsigned
goto what
																				::PUSH SIGNED
:pushsigned
set input=error
if not exist %~dp0done\signed%capp% goto errorlog
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
echo.
%~dp0tools\Apps\chgcolor %high%
echo Where do you want adb to push your project to
echo and as what do you want to name it?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo Example of input : /system/app/Settings.apk
set /P input=Type input: %=%
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
echo.
set odexfile=!capp:~0,-4!.odex
set odexfileinput=!input:~0,-4!.odex
echo Pushing done\signed%capp% to %input%
if not exist %~dp0place-here-for-modding\%odexfile% %~dp0tools\adb.exe -s %devicefinal% push %~dp0done\signed%capp% %input% > NUL
if exist %~dp0place-here-for-modding\%odexfile% (
	%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\%capp% %input% > NUL
	%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\%odexfile% %odexfileinput% > NUL
)
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo Push was successful
echo.
echo Pushed signed%capp% to %input%
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::PUSH UNSIGNED
:pushunsigned
if not exist %~dp0done\unsigned%capp% goto errorlog
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
echo.
%~dp0tools\Apps\chgcolor %high%
echo Where do you want adb to push your project to
echo and as what do you want to name it?
%~dp0tools\Apps\chgcolor %bg%
set input=error
echo.
echo Example of input : /system/app/Settings.apk
set /P input=Type input: %=%
echo.
set odexfile=!capp:~0,-4!.odex
set odexfileinput=!input:~0,-4!.odex
if not exist %~dp0place-here-for-modding\%odexfile% (
	echo Pushing %~dp0done\unsigned%capp% to %input%
	%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\unsigned%capp% %input% > NUL
)
if exist %~dp0place-here-for-modding\%odexfile% (
	echo Pushing %~dp0done\%capp% to %input%
	%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\%capp% %input% > NUL
	%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\%odexfile% %odexfileinput% > NUL
)
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo Push was successful
echo.
if exist %~dp0place-here-for-modding\%odexfile% echo Pushed %capp% to %input%
if not exist %~dp0place-here-for-modding\%odexfile% echo Pushed unsigned%capp% to %input%
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::PUSH CWM ZIP
:pushcwm
if not exist %~dp0done\flashable\%capp%-CWM.zip goto errorlog
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
echo.
%~dp0tools\Apps\chgcolor %high%
echo Pushing done\flashable\%capp%-CWM.zip to /sdcard/Flashables/
%~dp0tools\Apps\chgcolor %bg%
%~dp0tools\adb.exe shell mkdir /sdcard/Flashables > NUL
%~dp0tools\adb.exe -s %devicefinal% shell rm /sdcard/Flashables/%capp%-CWM.zip > NUL
%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\flashable\%capp%-CWM.zip /sdcard/Flashables/ > NUL
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo Push was successful
echo.
echo Pushed %capp%-CWM.zip to /sdcard/Flashables/
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::DECOMPILE START
:decompile
if exist %~dp0projects\%capp% goto again
if exist %~dp0projects-smali\%capp% goto again
if %jar% EQU 0 goto decompileapk
if %jar% EQU 1 goto decompilejar
																				::DECOMPILE AGAIN
:again
cls
set input=error
echo.
%~dp0tools\Apps\chgcolor %high%
echo %capp% has already been decompiled.
echo Would you like to decompile it again [y/n]
%~dp0tools\Apps\chgcolor %bg%
echo.
set /P input=Type input: %=%
if %input% EQU y goto decompile2
if %input% EQU n goto restart
																				::DECOMPILE AGAIN APK OR JAR
:decompile2
if exist %~dp0place-here-for-modding\!capp:~0,-4!.odex copy /y %~dp0tools\odex\originals\%capp% %~dp0place-here-for-modding\%capp% > NUL
if %jar% EQU 0 goto decompileapk
if %jar% EQU 1 goto decompilejar
																				::DECOMPILE APK
:decompileapk
set odexfile=!capp:~0,-4!.odex
if exist %~dp0place-here-for-modding\%odexfile% goto decompileodexapk
:decompileapkodex
echo.
echo Preparing %capp%
if %capp% EQU All goto decompileall
if not exist %~dp0originals\%capp%\%capp% (
	mkdir %~dp0originals\%capp% > NUL
	copy /y %~dp0place-here-for-modding\%capp% %~dp0originals\%capp%\%capp% > NUL
)
if %capp% EQU framework-res.apk goto skipped
if %capp% EQU twframework-res.apk goto skipped
%~dp0tools\Apps\7za.exe x %~dp0place-here-for-modding\%capp% -y -o%~dp0tools\temp\%capp% > NUL
if not exist %~dp0tools\temp\%capp%\classes.dex goto skipped
if exist %~dp0projects-smali\%capp% rd /s /q %~dp0projects-smali\%capp% > NUL
if not exist %~dp0projects-smali\%capp% mkdir %~dp0projects-smali\%capp% > NUL
move /y %~dp0tools\temp\%capp%\classes.dex %~dp0projects-smali\%capp%\classes.dex > NUL
cd %~dp0tools\temp\%capp% > NUL
%~dp0tools\Apps\7za.exe a ..\%capp%.zip * > NUL
cd %~dp0
move /y %~dp0tools\temp\%capp%.zip %~dp0place-here-for-modding\%capp% > NUL
rd /s /q %~dp0tools\temp\%capp% > NUL
:skipped
echo.
echo Decompiling %capp%
if exist %~dp0place-here-for-modding\signed%capp% del /q %~dp0place-here-for-modding\signed%capp% > NUL
if exist %~dp0place-here-for-modding\unsigned%capp% del /q %~dp0place-here-for-modding\unsigned%capp% > NUL
if exist %~dp0projects\%capp% rd /s /q %~dp0projects\%capp% > NUL
java -Xmx%heapy%m -jar %~dp0tools\build\%apktool% d %~dp0place-here-for-modding\%capp% %~dp0projects\%capp%
if errorlevel 1 goto errorlog
if %capp% EQU framework-res.apk goto restart
if %capp% EQU twframework-res.apk goto restart
java -jar %~dp0tools\build\baksmali.jar %~dp0projects-smali\%capp%\classes.dex
if exist %~dp0projects-smali\%capp% rd /s /q %~dp0projects-smali\%capp% > NUL
move /y out %~dp0projects-smali\%capp% > NUL
copy /y %~dp0originals\%capp%\%capp% %~dp0place-here-for-modding\ > NUL
if exist %~dp0tools\temp\%capp% rd /s /q %~dp0tools\temp\%capp%
cd %~dp0
if errorlevel 1 goto errorlog
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  %capp% decompiled successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new project is located at:
echo.
%~dp0tools\Apps\chgcolor %high%
echo  XML and Images
%~dp0tools\Apps\chgcolor %bg%
echo %~dp0projects\%capp%
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Smali files
%~dp0tools\Apps\chgcolor %bg%
echo %~dp0projects-smali\%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::DECOMPILE JAR
:decompilejar
set odexfile=!capp:~0,-4!.odex
if exist %~dp0place-here-for-modding\%odexfile% goto decompileodexjar
if %capp% EQU all goto decompileall
:decompilejarodex
if not exist %~dp0originals\%capp% mkdir %~dp0originals\%capp% > NUL
copy /y %~dp0place-here-for-modding\%capp% %~dp0originals\%capp%\%capp% > NUL
if exist %~dp0place-here-for-modding\signed%capp% del /q %~dp0place-here-for-modding\signed%capp% > NUL
if exist %~dp0place-here-for-modding\unsigned%capp% del /q %~dp0place-here-for-modding\unsigned%capp% > NUL
if exist %~dp0projects-smali\%capp% rd /s /q %~dp0projects-smali\%capp% > NUL
echo.
echo Decompiling %capp%
java -jar %~dp0tools\build\baksmali.jar -x %~dp0place-here-for-modding\%capp% -o %~dp0projects-smali\%capp%
if errorlevel 1 goto errorlog
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo %capp% decompiled successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new project is located at:
echo.
echo  %~dp0projects-smali\%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::DECOMPILE ALL MENU
:decompileall
if exist %~dp0place-here-for-modding\*.odex goto decompileodexapkall
:decompileallodex
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to decompile
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    All jars
echo  2    All apks
echo  3    Everything in place-here-for-modding
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Type input: %=%
if %input% EQU 2 goto decompileallapk
::DO NOT REMOVE
if %input% EQU 1 goto decompilealljar
if %input% EQU 3 goto decompileeverything
if %input% EQU 99 goto restart
goto what
																				::DECOMPILE ALL APKS
:decompileallapk
if exist %~dp0place-here-for-modding\*.odex goto decompileodexapkall
:decompileallodexapk
cls
echo.
if exist %~dp0tools\temp\*.apk rd /s /q %~dp0tools\temp\*.apk > NUL
if exist %~dp0tools\temp\*.zip rd /s /q %~dp0tools\temp\*.zip > NUL
cd %~dp0tools\temp > NUL
echo Preparing ALL Apks
echo.
for %%g in (%~dp0place-here-for-modding\*.apk) do (
	if exist %~dp0projects\%%~nxg rd /s /q %~dp0projects\%%~nxg > NUL
	if exist %~dp0projects-smali\%%~nxg rd /s /q %~dp0projects-smali\%%~nxg > NUL
	if exist %~dp0originals\%%~nxg rd /s /q %~dp0originals\%%~nxg > NUL
	mkdir %~dp0originals\%%~nxg > NUL
	copy /y %~dp0place-here-for-modding\%%~nxg %~dp0originals\%%~nxg\%%~nxg > NUL
	%~dp0tools\Apps\7za.exe x %~dp0place-here-for-modding\%%~nxg -y -o%~dp0tools\temp\%%~nxg > NUL
	mkdir %~dp0projects-smali\%%~nxg > NUL
	if exist %~dp0tools\temp\%%~nxg\classes.dex move /y %~dp0tools\temp\%%~nxg\classes.dex %~dp0projects-smali\%%~nxg\classes.dex > NUL
)
if not exist %~dp0projects-smali\framework-res.apk mkdir %~dp0projects-smali\framework-res.apk > NUL
if not exist %~dp0projects-smali\twframework-res.apk mkdir %~dp0projects-smali\twframework-res.apk > NUL
copy %~dp0tools\classes.dex %~dp0projects-smali\framework-res.apk\ > NUL
copy %~dp0tools\classes.dex %~dp0projects-smali\twframework-res.apk\ > NUL
for %%g in (%~dp0place-here-for-modding\*.apk) do (
	cd %~dp0tools\temp\%%~nxg > NUL
	%~dp0tools\Apps\7za.exe a %~dp0tools\temp\%%~nxg.zip * > NUL
	move /y %~dp0tools\temp\%%~nxg.zip %~dp0place-here-for-modding\%%~nxg > NUL
	cd %~dp0 > NUL
	rd /s /q %~dp0tools\temp\%%~nxg > NUL
)
%~dp0tools\Apps\chgcolor %high%
echo Decompiling ALL Apks
%~dp0tools\Apps\chgcolor %bg%
echo.
cd %~dp0tools\build > NUL
for %%g in (%~dp0place-here-for-modding\*.apk) do (
	echo Decompiling %%~nxg
	java -Xmx%heapy%m -jar %apktool% d %~dp0place-here-for-modding\%%~nxg %~dp0projects\%%~nxg
)
if errorlevel 1 goto errorlog
echo.
%~dp0tools\Apps\chgcolor %high%
echo Decompiling smali for ALL apks
%~dp0tools\Apps\chgcolor %bg%
echo.
for %%g in (%~dp0place-here-for-modding\*.apk) do (
	echo Decompiling smali for %%~nxg
	java -jar baksmali.jar %~dp0projects-smali\%%~nxg\classes.dex -o %~dp0projects-smali\%%~nxg
	del /q %~dp0projects-smali\%%~nxg\classes.dex > NUL
)
if errorlevel 1 goto errorlog
if exist %~dp0projects-smali\framework-res.apk rd /s /q %~dp0projects-smali\framework-res.apk > NUL
if exist %~dp0projects-smali\twframework-res.apk rd /s /q %~dp0projects-smali\twframework-res.apk > NUL
if exist %~dp0tools\temp\*.apk rd /s /q %~dp0tools\temp\*.apk > NUL
if exist %~dp0tools\temp\*.zip rd /s /q %~dp0tools\temp\*.zip > NUL
for %%g in (%~dp0place-here-for-modding\*.apk) do copy /y %~dp0originals\%%~nxg\%%~nxg %~dp0place-here-for-modding\ > NUL
cd %~dp0
::DO NOT REMOVE
if %decompileeverythingselected% EQU 1 goto decompilealljar
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Batch decompiling was successful
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new projects are located at:
echo.
%~dp0tools\Apps\chgcolor %high%
echo  XML and Images
%~dp0tools\Apps\chgcolor %bg%
echo  %~dp0projects
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Smali files
%~dp0tools\Apps\chgcolor %bg%
echo  %~dp0projects-smali
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::DECOMPILE ALL JARS
:decompilealljar
::DO NOT REMOVE
if exist %~dp0place-here-for-modding\*.odex goto decompileodexapkall
:decompileallodexjar
cls
echo.
for %%g in (%~dp0place-here-for-modding\*.jar) do (
	if exist %~dp0originals\%%~nxg rd /s /q %~dp0originals\%%~nxg > NUL
	if exist %~dp0projects-smali\%%~nxg rd /s /q %~dp0projects-smali\%%~nxg > NUL
	mkdir %~dp0originals\%%~nxg > NUL
	copy /y %~dp0place-here-for-modding\%%~nxg %~dp0originals\%%~nxg\%%~nxg > NUL
)
%~dp0tools\Apps\chgcolor %high%
echo Decompiling ALL jars
%~dp0tools\Apps\chgcolor %bg%
echo.
for %%g in (%~dp0place-here-for-modding\*.jar) do (
	echo Decompiling %%~nxg
	java -jar %~dp0tools\build\baksmali.jar -x %~dp0place-here-for-modding\%%~nxg -o %~dp0projects-smali\%%~nxg
)
if errorlevel 1 goto errorlog
for %%g in (%~dp0place-here-for-modding\*.jar) do copy /y %~dp0originals\%%~nxg\%%~nxg %~dp0place-here-for-modding\ > NUL
if %decompileeverythingselected% EQU 1 goto decompilebothhappened
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Batch decompiling was successful
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new projects are located at:
echo.
echo  %~dp0projects-smali\
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:decompilebothhappened
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Batch decompiling was successful
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new projects are located at:
echo.
%~dp0tools\Apps\chgcolor %high%
echo  XML and Images
%~dp0tools\Apps\chgcolor %bg%
echo  %~dp0projects\
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Smali files
%~dp0tools\Apps\chgcolor %bg%
echo  %~dp0projects-smali\
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::DECOMPILE EVERYTHING
:decompileeverything
set decompileeverythingselected=1
goto decompileallapk
goto restart
																				::COMPILE START
:compile
::DO NOT REMOVE
if %jar% EQU 0 goto compileapk
if %jar% EQU 1 goto compilejar
																				::COMPILE APK
:compileapk
if not exist %~dp0projects\%capp% goto dirnada
echo.
echo  Building %capp%
if exist %~dp0done\unsigned%capp% del /q %~dp0done\unsigned%capp% > NUL
if exist %~dp0done\signed%capp% del /q %~dp0done\signed%capp% > NUL
java -Xmx%heapy%m -jar %~dp0tools\build\%apktool% b %~dp0projects\%capp% %~dp0done\unsigned%capp%
if errorlevel 1 goto errorlog
if exist %~dp0keep rd /s /q "%~dp0keep > NUL
%~dp0tools\Apps\7za.exe x -o%~dp0keep %~dp0place-here-for-modding/%capp% > NUL
echo.
if %sound%==0 goto skipbeep3
start /min %~dp0tools\beep.bat
:skipbeep3
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  In the apk folder you'll find a keep folder. Delete everything you have
echo  modified and leave files that you haven't. If you have modified any xml's,
echo  then delete the resources.arsc from that folder as well.
echo.
echo  Once done then press enter on this script.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
PAUSE
echo.
set odexfile=!capp:~0,-4!.odex
echo  Making new apk
%~dp0tools\Apps\7za.exe a -tzip %~dp0done/unsigned%capp% %~dp0keep/* -mx%usrc% -r > NUL
if exist %~dp0keep rd /s /q %~dp0keep > NUL
if not exist %~dp0projects-smali\%capp% goto restart
echo.
echo  Compiling %capp%'s smali
if exist %~dp0tools\temp\compile\%capp% rd /s /q %~dp0tools\temp\compile\%capp% > NUL
mkdir %~dp0tools\temp\compile\%capp% > NUL
cd %~dp0tools\temp\
java -Xmx%heapy%M -jar %~dp0tools\build\smali.jar %~dp0projects-smali\%capp%\
if errorlevel 1 goto errorlog
move /y %~dp0tools\temp\out.dex %~dp0tools\temp\compile\%capp%\classes.dex > NUL
%~dp0tools\Apps\7za.exe x %~dp0done\unsigned%capp% -y -o%~dp0tools\temp\compile\%capp% > NUL
%~dp0tools\Apps\7za.exe a %~dp0tools\temp\compile\%capp%.zip %~dp0tools\temp\compile\%capp%\* > NUL
move /y %~dp0tools\temp\compile\%capp%.zip %~dp0done\unsigned%capp% > NUL
rd /s /q %~dp0tools\temp\compile\%capp% > NUL
if exist %~dp0place-here-for-modding\%odexfile% goto reodexcheck
goto deodexdone
:reodexcheck
if %remountavlible%==No goto noreodex
if %remountavlible%==Yes goto reodex
goto deodexdone
::DO NOT REMOVE
:noreodex
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  %capp% compiled successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new project is located at:
echo.
echo  %~dp0done\unsigned%capp%
echo.
echo  %capp% Can not be Re-Odexed
echo  No phone with adb remount support is plugged in
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
::DO NOT REMOVE
:deodexdone
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  %capp% compiled successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new project is located at:
echo.
echo  %~dp0done\unsigned%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::COMPILE JAR
:compilejar
echo.
set odexfile=!capp:~0,-4!.odex
echo  Compiling %capp%
if exist %~dp0tools\temp\compile rd /s /q %~dp0tools\temp\compile > NUL
mkdir %~dp0tools\temp\compile > NUL
cd %~dp0tools\temp\compile > NUL
%~dp0tools\Apps\7za.exe x %~dp0place-here-for-modding\%capp% -y > NUL
java -Xmx%heapy%m -jar %~dp0tools\build\smali.jar %~dp0projects-smali\%capp%\
if errorlevel 1 goto errorlog
move %~dp0tools\temp\compile\out.dex %~dp0tools\temp\compile\classes.dex > NUL
%~dp0tools\Apps\7za.exe a -tzip "%~dp0done\unsigned%capp%" "*" -mx%usrc% -r > NUL
cd %~dp0
rd /s /q %~dp0tools\temp\compile > NUL
if exist %~dp0place-here-for-modding\%odexfile% goto reodex > NUL
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  %capp% compiled successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new project is located at:
echo.
echo  %~dp0done\unsigned%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::START FLASH MENU
:makezip
set deodexromzip=0
:makezipdeodex
if not exist %~dp0tools\cwm\system\framework\ mkdir %~dp0tools\cwm\system\framework\ > NUL
if not exist %~dp0tools\cwm\system\app\ mkdir %~dp0tools\cwm\system\app\ > NUL
if not exist %~dp0tools\cwm\tools\ mkdir %~dp0tools\cwm\tools\ > NUL
if exist %~dp0tools\cwm\system\app\* del /q %~dp0tools\cwm\system\app\* > NUL
if exist %~dp0tools\cwm\system\framework\* del /q %~dp0tools\cwm\system\framework\* > NUL
if exist %~dp0tools\cwm\tools\ del /q %~dp0tools\cwm\tools\* > NUL
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What phone is the project for?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  ------------------------------- Samsung Devices ------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  1    Galaxy SII
echo  2    Galaxy SIII
echo  3    Galaxy Nexus
echo  4    Galaxy Note
echo  5    Galaxy Note II
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- Asus Devices --------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  6    Nexus 7
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- HTC Devices ---------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  7    Evo LTE
echo  8    One X
echo  9    One S
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- LG Devices ---------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  10   Nexus 4
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto sete4gt
if %input% EQU 2 goto setsiii
if %input% EQU 3 goto setgnex
if %input% EQU 4 goto setnote
if %input% EQU 5 goto setnoteII
if %input% EQU 6 goto setn7
if %input% EQU 7 goto setevolte
if %input% EQU 8 goto setonex
if %input% EQU 9 goto setones
if %input% EQU 10 goto setn4

if %input% EQU 99 goto restart
goto what

:sete4gt
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\et4g\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setn7
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\n7\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setonex
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\onex\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setgnex
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\gnex\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setsiii
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\S3\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setevolte
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\evolte\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setnote
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\note\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setnoteII
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\noteII\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setones
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\ones\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where

:setn4
del /q %~dp0tools\cwm\META-INF\com\google\android\*
copy %~dp0tools\flash_scripts\n4\* %~dp0tools\cwm\META-INF\com\google\android\
if %deodexromzip% EQU 1 goto zipdeodexed
goto where
																				::FLASH TO WHERE MENU
::DO NOT REMOVE
:where
cls
set location=error
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Where should your project go?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Flash to /system/framework/
echo  2    Flash to /system/app/
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P location=Type input: %=%
if %location%==99 goto restart
echo.
cls
set input=error
if not exist %~dp0done\unsigned%capp% goto nounsignedcwm
if exist %~dp0done\unsigned%capp% goto allowcwm
:nounsignedcwm
if not exist %~dp0done\signed%capp% goto nocwmnothingtozip
if exist %~dp0done\signed%capp% goto allowcwm
:nocwmnothingtozip
goto makeanothercwm
:allowcwm
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Would you like to make a zip of %capp%
echo  or something else?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    %capp%
echo  2    Something Else
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto currentname
if %input% EQU 2 goto makeanothercwm
if %input% EQU 99 goto restart
cls
echo.
echo  ------------------------------------------------------------------------------
echo.
:currentname
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  The current project name is %capp%
echo  Would you like to rename the file [y/n]?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU y goto makecwmrename
if %input% EQU n goto makecwm
goto what
																				::MAKE FLASHABLE ZIP OF SOMETHING
:makeanothercwm
if exist %~dp0done\flashable\%newname%-CWM.zip del /q %~dp0done\flashable\%newname%-CWM.zip > NUL
set input=error
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to make a zip of?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo  Type or drag your file here
echo.
set /P input=Type input: %=%
set inputodex=!input:~0,-4!.odex
if %location% EQU 1 (
	copy /y %input% %~dp0tools\cwm\system\framework\ > NUL
	copy /y %~dp0tools\placeholder %~dp0tools\cwm\system\app\ > NUL
	if exist %inputodex% (
		copy /y %inputodex% %~dp0tools\cwm\system\framework\ > NUL
	)
)
if %location% EQU 2 (
	copy /y %input% %~dp0tools\cwm\system\app\ > NUL
	copy /y %~dp0tools\placeholder %~dp0tools\cwm\system\framework\ > NUL
	if exist %inputodex% (
		copy /y %inputodex% %~dp0tools\cwm\system\app\ > NUL
	)
)
copy /y %~dp0tools\flash_scripts\run\normal\run.sh %~dp0tools\cwm\tools\ > NUL
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set file=%month%.%day%.%year%_%hour%.%min%
%~dp0tools\Apps\7za.exe a %~dp0done\flashable\%file%-CWM.zip %~dp0tools\cwm\* > NUL
del /q %~dp0tools\cwm\system\framework\* > NUL
del /q %~dp0tools\cwm\system\app\* > NUL
del /q %~dp0tools\cwm\tools\* > NUL
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  CWM Flashable zip was made successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  CWM Flashable zip located at:
echo.
echo  %~dp0done\flashable\%file%-CWM.zip
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
set input=error
set /p remountavlible=<%~dp0tools\temp\remount.txt
if %remountavlible% EQU No goto endzip
if %adbwifi%==Connected (
	echo Would you like to flash the zip now? [y/n]
	set zipname=%file%-CWM.zip
	%~dp0tools\Apps\chgcolor %bg%
	set /P input=Type input: %=%	
)
if %input% EQU y goto flashzip
if %input% EQU n goto restart
:endzip
PAUSE
goto restart
																				::MAKE FLASHABLE ZIP AND RENAME
:makecwmrename
if exist %~dp0done\flashable\%newname%-CWM.zip del /q %~dp0done\flashable\%newname%-CWM.zip > NUL
set input=error
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to name it?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo Example: Settings.apk
echo.
set /P input=Type input: %=%
set bothfound=error
set newname=%input%
set odexfile=!capp:~0,-4!.odex
set newodex=!input:~0,-4!.odex
if exist %~dp0done\%odexfile% (
	cls
	echo.
	%~dp0tools\Apps\chgcolor %high%
	echo  odex and deodex files found
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	echo.
	echo  Would you like to the zip the odexed or deodexed version of your project?
	echo.
	echo  1    Odex
	echo  2    Deodexed
	echo.
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  99   Go Back
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set /P bothfound=Please make your decision:
)
if %location% EQU 1 (
	copy /y %~dp0done\unsigned%capp% %~dp0tools\cwm\system\framework\%input% > NUL
	copy /y %~dp0tools\placeholder %~dp0tools\cwm\system\app\ > NUL
	if %bothfound% EQU 1 (
		copy /y %~dp0done\%odexfile% %~dp0tools\cwm\system\framework\%newodex% > NUL
		copy /y %~dp0done\%capp% %~dp0tools\cwm\system\framework\%input% > NUL
	)
)
if %location% EQU 2 (
	copy /y %~dp0done\unsigned%capp% %~dp0tools\cwm\system\app\%input% > NUL
	copy /y %~dp0tools\placeholder %~dp0tools\cwm\system\framework\ > NUL
	if %bothfound% EQU 1 (
		copy /y %~dp0done\%odexfile% %~dp0tools\cwm\system\app\%newodex% > NUL
		copy /y %~dp0done\%capp% %~dp0tools\cwm\system\app\%input% > NUL
	)
)
copy /y %~dp0tools\flash_scripts\run\normal\run.sh %~dp0tools\cwm\tools\ > NUL
%~dp0tools\Apps\7za.exe a %~dp0done\flashable\%capp%-CWM.zip %~dp0tools\cwm\* > NUL
del /q %~dp0tools\cwm\system\framework\* > NUL
del /q %~dp0tools\cwm\system\app\* > NUL
del /q %~dp0tools\cwm\tools\* > NUL
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  CWM Flashable zip was made successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  CWM Flashable zip located at:
echo.
echo  %~dp0done\flashable\%newname%-CWM.zip
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
set input=error
set /p remountavlible=<%~dp0tools\temp\remount.txt
if %remountavlible% EQU No goto endzip
if %adbwifi%==Connected (
	echo  Would you like to flash the zip now? [y/n]
	set zipname=%newname%-CWM.zip
	%~dp0tools\Apps\chgcolor %bg%
	set /P input=Type input: %=%	
)
if %input% EQU y goto flashzip
if %input% EQU n goto restart
:endzip
PAUSE
goto restart
																				::MAKE FLASHABLE ZIP
:makecwm
if exist %~dp0done\flashable\%capp%-CWM.zip del /q %~dp0done\flashable\%capp%-CWM.zip > NUL
set bothfound=error
set odexfile=!capp:~0,-4!.odex
set newodex=!input:~0,-4!.odex
if exist %~dp0done\%odexfile% (
	cls
	echo.
	%~dp0tools\Apps\chgcolor %high%
	echo  odex and deodex files found
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	echo.
	echo  Would you like to the zip the odexed or deodexed version of your project?
	echo.
	echo  1    Odex
	echo  2    Deodexed
	echo.
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  99   Go Back
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set /P bothfound=Please make your decision:
)
if %location% EQU 1 (
	copy /y %~dp0done\unsigned%capp% %~dp0tools\cwm\system\framework\%capp% > NUL
	copy /y %~dp0tools\placeholder %~dp0tools\cwm\system\app\ > NUL
	if %bothfound% EQU 1 (
		copy /y %~dp0done\%odexfile% %~dp0tools\cwm\system\framework\%odexfile% > NUL
		copy /y %~dp0done\%capp% %~dp0tools\cwm\system\framework\%capp% > NUL
	)
)
if %location% EQU 2 (
	copy /y %~dp0done\unsigned%capp% %~dp0tools\cwm\system\app\%capp% > NUL
	copy /y %~dp0tools\placeholder %~dp0tools\cwm\system\framework\ > NUL
	if %bothfound% EQU 1 (
		copy /y %~dp0done\%odexfile% %~dp0tools\cwm\system\app\%odexfile% > NUL
		copy /y %~dp0done\%capp% %~dp0tools\cwm\system\app\%capp% > NUL
	)
)
copy /y %~dp0tools\flash_scripts\run\normal\run.sh %~dp0tools\cwm\tools\ > NUL
%~dp0tools\Apps\7za.exe a %~dp0done\flashable\%capp%-CWM.zip %~dp0tools\cwm\* > NUL
del /q %~dp0tools\cwm\system\framework\* > NUL
del /q %~dp0tools\cwm\system\app\* > NUL
del /q %~dp0tools\cwm\tools\* > NUL
cls
set input=error
echo.
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  CWM Flashable zip was made successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  CWM Flashable zip located at:
echo.
echo  %~dp0done\flashable\%capp%-CWM.zip
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
set /P remountavlible=<%~dp0tools\temp\remount.txt
if %remountavlible% EQU No goto endzip
if %adbwifi%==Connected (
	echo  Would you like to flash the zip now? [y/n]
	set zipname=%capp%-CWM.zip
	%~dp0tools\Apps\chgcolor %bg%
	set /P input=Type input: %=%	
)
if %input% EQU y goto flashzip
if %input% EQU n goto restart
:endzip
PAUSE
goto restart
																				::FLASH ZIP AFTER MADE
:flashzip
echo.
echo  Pushing %~dp0done\flashable\%zipname% to the phone
%~dp0tools\adb.exe shell mkdir /sdcard/Flashables > NUL
%~dp0tools\adb.exe push %~dp0done\flashable\%zipname% /sdcard/Flashables/%zipname% > NUL
%~dp0tools\adb.exe -s %devicefinal% shell "echo 'install_zip(\"/emmc/Flashables/%zipname%\");' >> /cache/recovery/extendedcommand"
%~dp0tools\adb.exe -s %devicefinal% shell "echo install /mnt/sdcard/Flashables/%zipname%.zip >> /cache/recovery/openrecoveryscript"
echo.
echo  Rebooting your phone
%~dp0tools\adb.exe reboot recovery > NUL
goto restart
																				::INSTALL MENU
:install
set input=error
set odexfile=!capp:~0,-4!.odex
if exist %~dp0place-here-for-modding\%odexfile% goto noodexinstall
goto allowinstall
																				::INSTALL ODEX 
:noodexinstall
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Odex files can not be installed this way
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Make a CWM zip or push the odex file to the phone
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::INSTALL CHECK DEVICES
:allowinstall
cls
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  This will Install %~dp0done\signed%capp% to the phone:
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Is this what you want to do?
echo.
echo  ------------------------------------------------------------------------------
set input=error
set /P input=Continue [y/n]: %=%
if %input% EQU n goto restart
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set /A count+=1
	set a!count!=%%a
)
if /I !count! LSS 2 goto single
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to install to?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo  !count!    !tempvar:~0,-7!
)
echo.
echo  99   Go Back
echo.
set /P input=Enter It's Number: %=%
echo.
if %input%==99 goto restart
%~dp0tools\Apps\chgcolor %high%
set device=!a%input%!
set devicefinal=%device:~0,-7%
echo  Installing %capp% to %devicefinal%
echo  This can take a minute on an emulator.
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% install -r %~dp0done\signed%capp%
echo.
PAUSE
goto restart
																				::INSTALL SINGLE DEVICE
:single
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Installing %capp% to the phone
echo  This can take a minute on an emulator.
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe install -r %~dp0done\signed%capp%
echo.
PAUSE
goto restart
																				::OPTIMIZE IMAGES
:optimize
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Which Optimizer Would You like to Use?:
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    advpng
echo  2    optipng
echo  3    pngcrush x86
echo  4    pngcrush x64
echo  5    pngout
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set input=error
echo  Starting Optimization >%~dp0tools\logs\pngoptimizelog.log
if not exist %~dp0projects\%capp% goto dirnada
if not exist %~dp0tools\temp\optimize\drawable mkdir %~dp0tools\temp\optimize\drawable
if not exist %~dp0tools\temp\optimize\drawable-ldpi mkdir %~dp0tools\temp\optimize\drawable-ldpi
if not exist %~dp0tools\temp\optimize\drawable-mdpi mkdir %~dp0tools\temp\optimize\drawable-mdpi
if not exist %~dp0tools\temp\optimize\drawable-hdpi mkdir %~dp0tools\temp\optimize\drawable-hdpi
if not exist %~dp0tools\temp\optimize\drawable-xhdpi mkdir %~dp0tools\temp\optimize\drawable-xhdpi
if not exist %~dp0tools\temp\optimize\drawable-xxhdpi mkdir %~dp0tools\temp\optimize\drawable-xxhdpi
if exist %~dp0projects\%capp%\res\drawable\*.9.png xcopy /s /y %~dp0projects\%capp%\res\drawable\*.9.png %~dp0tools\temp\optimize\drawable > NUL
if exist %~dp0projects\%capp%\res\drawable-ldpi\*.9.png xcopy /s /y %~dp0projects\%capp%\res\drawable-ldpi\*.9.png %~dp0tools\temp\optimize\drawable-ldpi > NUL
if exist %~dp0projects\%capp%\res\drawable-mdpi\*.9.png xcopy /s /y %~dp0projects\%capp%\res\drawable-mdpi\*.9.png %~dp0tools\temp\optimize\drawable-mdpi > NUL
if exist %~dp0projects\%capp%\res\drawable-hdpi\*.9.png xcopy /s /y %~dp0projects\%capp%\res\drawable-hdpi\*.9.png %~dp0tools\temp\optimize\drawable-hdpi > NUL
if exist %~dp0projects\%capp%\res\drawable-xhdpi\*.9.png xcopy /s /y %~dp0projects\%capp%\res\drawable-xhdpi\*.9.png %~dp0tools\temp\optimize\drawable-xhdpi > NUL
if exist %~dp0projects\%capp%\res\drawable-xxhdpi\*.9.png xcopy /s /y %~dp0projects\%capp%\res\drawable-xxhdpi\*.9.png %~dp0tools\temp\optimize\drawable-xxhdpi > NUL
set /P input=Please make your decision:
if %input%==1 goto advpng
if %input%==2 goto optipng
if %input%==3 goto pngcrush86
if %input%==4 goto pngcrush64
if %input%==5 goto pngout
if %input%==99 goto restart
goto what
:advpng
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Optimizing %capp%'s Pngs with advpng
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This can take awhile please wait...
echo.
echo  The PNG optimization log can be found here:
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo  Please Wait...
cd %~dp0projects\%capp%\res\
for /r %%f in (*.png) do (
	%~dp0tools\Apps\advpng -z4 %%f >>%~dp0tools\logs\pngoptimizelog.log
)
cd %~dp0
xcopy /s /y %~dp0tools\temp\optimize %~dp0projects\%capp%\res > NUL
rd /s /q %~dp0tools\temp\optimize
if errorlevel 1 goto errorlog
goto restart
:optipng
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Optimizing %capp%'s Pngs with optipng
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This can take awhile please wait...
echo.
echo  The PNG optimization log can be found here:
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo Please Wait...
%~dp0tools\Apps\roptipng -o99 %~dp0projects\%capp%\**\*.png >%~dp0tools\logs\pngoptimizelog.log
xcopy /s /y %~dp0tools\temp\optimize %~dp0projects\%capp%\res > NUL
rd /s /q %~dp0tools\temp\optimize
if errorlevel 1 goto errorlog
goto restart
:pngcrush86
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Optimizing %capp%'s Pngs with pngcrush x86
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This can take awhile please wait...
echo.
echo  The PNG optimization log can be found here:
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo  Please Wait...
cd %~dp0projects\%capp%\res\
for /r %%f in (*.png) do (
	%~dp0tools\Apps\pngcrush_x86 -reduce -brute %%f tempfile.tmp>>%~dp0tools\logs\pngoptimizelog.log
	del /q %%f>>%~dp0tools\logs\pngoptimizelog.log
	move /s /y tempfile.tmp %%f>>%~dp0tools\logs\pngoptimizelog.log
	echo moving tempfile.tmp to %%f>>%~dp0tools\logs\pngoptimizelog.log
)
cd %~dp0
xcopy /s /y %~dp0tools\temp\optimize %~dp0projects\%capp%\res > NUL
rd /s /q %~dp0tools\temp\optimize
if errorlevel 1 goto errorlog
goto restart
:pngcrush64
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Optimizing %capp%'s Pngs with pngcrush x64
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This can take awhile please wait...
echo.
echo  The PNG optimization log can be found here:
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo  Please Wait...
cd %~dp0projects\%capp%\res\
for /r %%f in (*.png) do (
	%~dp0tools\Apps\pngcrush_x64 -reduce -brute %%f tempfile.tmp>>%~dp0tools\logs\pngoptimizelog.log
	del /q %%f>>%~dp0tools\logs\pngoptimizelog.log
	move /s /y tempfile.tmp %%f>>%~dp0tools\logs\pngoptimizelog.log
	echo moving tempfile.tmp to %%f>>%~dp0tools\logs\pngoptimizelog.log
)
cd %~dp0
xcopy /s /y %~dp0tools\temp\optimize %~dp0projects\%capp%\res > NUL
rd /s /q %~dp0tools\temp\optimize
if errorlevel 1 goto errorlog
goto restart
:pngout
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Optimizing %capp%'s Pngs with pngout
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This can take awhile please wait...
echo.
echo  The PNG optimization log can be found here:
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo  Please Wait...
cd %~dp0projects\%capp%\res\
for /r %%f in (*.png) do (
	%~dp0tools\Apps\pngout %%f>>%~dp0tools\logs\pngoptimizelog.log
)
cd %~dp0
xcopy /s /y %~dp0tools\temp\optimize %~dp0projects\%capp%\res > NUL
rd /s /q %~dp0tools\temp\optimize
if errorlevel 1 goto errorlog
goto restart
																				::SIGN SOMETHING
:sign
set signaturemade=0
set uselocalsig=0
set usegeneric=0
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Sign With?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
if not exist %~dp0tools\keys\*.keystore goto nosigs
set nosigna=on
echo.
echo  1    Use a previously made keystore to sign?
goto nosigsdone
:nosigs
set nosigna=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No previously made keystore to use
%~dp0tools\Apps\chgcolor %bg%
:nosigsdone
echo  2    Make your own key and use it to sign?
echo  3    Sign %capp% with a generic test key
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision:
if %nosigna% EQU off goto nolocal
if %input%==1 set uselocalsig=yes & goto signodexcheck
:nolocal
if %input%==2 goto makesig
if %input%==3 set usegeneric=yes & goto signodexcheck
if %input%==99 goto restart
goto what
																				::MAKE SIGNATURE
:makesig
cls
set signame=error
if not exist %~dp0tools\keys\ mkdir %~dp0tools\keys\
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to name your new keystore?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P signame=Enter a name:
if %PROCESSOR_ARCHITECTURE%==x86 (
	start %~dp0tools\build\32\keytool -genkey -alias %signame%.keystore -keyalg RSA -validity 20000 -keystore %~dp0tools\keys\%signame%.keystore
	if errorlevel 1 goto errorlog
	set signaturemade=yes
	goto sigmade
) else (
	start %~dp0tools\build\64\keytool -genkey -alias %signame%.keystore -keyalg RSA -validity 20000 -keystore %~dp0tools\keys\%signame%.keystore
	if errorlevel 1 goto errorlog
	set signaturemade=yes
	goto sigmade
)
:sigmade
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Complete the setup wizard
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  When finished your new keystore will be located at:
echo  %~dp0tools\keys\%signame%.keystore
echo.
echo  ------------------------------------------------------------------------------
echo.
echo  Press any key to sign %capp% with your new keystore
PAUSE > NUL
:signodexcheck
set odexfile=!capp:~0,-4!.odex
if exist %~dp0done\%odexfile% if exist %~dp0done\unsigned%capp% goto signchoose
if exist %~dp0done\%odexfile% goto signodex
goto signdeodexed
																				::SIGN CHOOSE
:signchoose
set input=error
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  %capp% odex and deodex available
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Would you like to the sign the odexed or deodexed version of your project?
echo.
echo  1    Odex
echo  2    Deodexed
echo.
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision:
if %input%==1 goto signodex
if %input%==2 goto signdeodexed
::DO NOT REMOVE
goto what
																				::SIGN ODEX
:signodex
set signname=
set keytouse=
set homedir=
set keyname=
set java_home=
echo.
if %usegeneric% EQU yes (
	cls
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Signing Odexed %capp%.
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	java -Xmx%heapy%m -jar %~dp0tools\build\signapk.jar -w %~dp0tools\build\certificate.pem %~dp0tools\build\key.pk8 %~dp0done\%capp% %~dp0done\signedOdexed%capp%
	goto finishsignodex
)
if %uselocalsig% EQU yes goto localsig
goto nextchoice
:localsig
	cls
	echo.
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Which key should I use?
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set /A count=0
	cd %~dp0
	for %%f in (%~dp0tools\keys\*) do (
		set /A count+=1
		set a!count!=%%f
		if /I !count! LSS 10 echo   !count!   %%f 
		if /I !count! GTR 9 echo   !count!  %%f 
	)
	echo  ------------------------------------------------------------------------------
	set /P signname=Enter It's Number: %=%
	cls
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Signing Odexed %capp%.
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set keytouse=!a%signname%!	
	for %%a in (%keytouse%) do set keyname=%%~nxa	
	set homedir=%~dp0done	
	set toolsdir=%~dp0tools
	for /f "skip=2 tokens=2*" %%A in ('REG QUERY "HKLM\Software\JavaSoft\Java Development Kit\1.6" /v JavaHome') do set java_home=%%B
	set java_home="%java_home%\bin\jarsigner.exe"
	if not exist %java_home% goto wrongjdk
	call %~dp0tools\build\jarsignerodex %java_home% %capp% %keytouse% %keyname% %homedir% %toolsdir%
	if errorlevel 1 goto errorlog
	goto finishsignodex
:nextchoice
if %signaturemade% EQU yes goto madesig
goto errorlog
:madesig
	cls
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Signing Odexed %capp%.
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set signame=%~dp0tools\keys\%signame%.keystore
	set keytouse=!a%signame%!
	for %%a in (%keytouse%) do set keyname=%%~nxa
	set homedir=%~dp0done
	set toolsdir=%~dp0tools
	for /f "skip=2 tokens=2*" %%A in ('REG QUERY "HKLM\Software\JavaSoft\Java Development Kit\1.6" /v JavaHome') do set java_home=%%B
	set java_home="%java_home%\bin\jarsigner.exe"
	if not exist %java_home% goto wrongjdk
	call %~dp0tools\build\jarsignerodex %java_home% %capp% %keytouse% %keyname% %homedir% %toolsdir%
	if errorlevel 1 goto errorlog
	goto finishsignodex
																				::SIGN DEODEX
:signdeodexed
set signname=
set keytouse=
set homedir=
set keyname=
set java_home=
echo.
if %usegeneric% EQU yes (
	cls
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Signing Deodexed %capp%.
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	java -Xmx%heapy%m -jar %~dp0tools\build\signapk.jar -w %~dp0tools\build\certificate.pem %~dp0tools\build\key.pk8 %~dp0done\unsigned%capp% %~dp0done\signed%capp%
	goto finishsign
)
if %uselocalsig% EQU yes goto localsig
goto nextchoice
:localsig
	cls
	echo.
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Which key should I use?
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set /A count=0
	cd %~dp0
	for %%f in (%~dp0tools\keys\*) do (
		set /A count+=1
		set a!count!=%%f
		if /I !count! LSS 10 echo   !count!   %%f 
		if /I !count! GTR 9 echo   !count!  %%f 
	)
	echo  ------------------------------------------------------------------------------
	set /P signname=Enter It's Number: %=%
	cls
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Signing Deodexed %capp%.
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set keytouse=!a%signname%!	
	for %%a in (%keytouse%) do set keyname=%%~nxa	
	set homedir=%~dp0done
	set toolsdir=%~dp0tools
	for /f "skip=2 tokens=2*" %%A in ('REG QUERY "HKLM\Software\JavaSoft\Java Development Kit\1.6" /v JavaHome') do set java_home=%%B
	set java_home="%java_home%\bin\jarsigner.exe"
	if not exist %java_home% goto wrongjdk
	call %~dp0tools\build\jarsigner %java_home% %capp% %keytouse% %keyname% %homedir% %toolsdir%
	if errorlevel 1 goto errorlog
	goto finishsign
:nextchoice
if %signaturemade% EQU yes goto madesig
goto errorlog
:madesig
	cls
	echo  ------------------------------------------------------------------------------
	%~dp0tools\Apps\chgcolor %high%
	echo  Signing Deodexed %capp%.
	%~dp0tools\Apps\chgcolor %bg%
	echo  ------------------------------------------------------------------------------
	set signame=%~dp0tools\keys\%signame%.keystore
	set keytouse=!a%signame%!
	for %%a in (%keytouse%) do set keyname=%%~nxa
	set homedir=%~dp0done
	set toolsdir=%~dp0tools
	for /f "skip=2 tokens=2*" %%A in ('REG QUERY "HKLM\Software\JavaSoft\Java Development Kit\1.6" /v JavaHome') do set java_home=%%B
	set java_home="%java_home%\bin\jarsigner.exe"
	if not exist %java_home% goto wrongjdk
	call %~dp0tools\build\jarsigner %java_home% %capp% %keytouse% %keyname% %homedir% %toolsdir%
	if errorlevel 1 goto errorlog
	goto finishsign
																				::JDK 1.6 IS NOT INSTALLED
:wrongjdk
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  Java JDK 1.6 Was Not Found
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Install Java JDK version 1.6 to sign a file with your own signature.
echo.
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Would you like me to open the download page for you?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision [y/n]:
if %input% EQU y start http://www.oracle.com/technetwork/java/javase/downloads/jdk6u37-downloads-1859587.html
echo.
goto restart
																				::FINISH SIGN
:finishsign
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  %capp% Signed Successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new signed project is located at:
echo.
echo  %~dp0done\signed%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::FINISH ODEX SIGN
:finishsignodex
echo.
%~dp0tools\Apps\chgcolor %high%
echo  %capp% Signed Successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new signed project is located at:
echo.
echo  %~dp0done\signedOdexed%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::ZIPALIGN MENU
:zipalign
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Zipalign Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
if not exist %~dp0done\unsigned%capp% goto nounsignedzip
if exist %~dp0done\unsigned%capp% goto allowzipalign
:nounsignedzip
if not exist %~dp0done\signed%capp% goto cappnotindone
if exist %~dp0done\signed%capp% goto allowzipalign
:cappnotindone
set zipalign=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No unsgined or signed %capp% found in your done found
%~dp0tools\Apps\chgcolor %bg%
goto cappzipaligndone
:allowzipalign
set zipalign=on
echo  1    Zipalign your project
:cappzipaligndone
if not exist %~dp0done\*.apk goto noapkindone
if exist %~dp0done\*.apk goto allowallzipalign
:noapkindone
if not exist %~dp0done\*.jar goto noapkorjarindone
if exist %~dp0done\*.jar goto allowallzipalign
:noapkorjarindone
set zipalignall=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No apks or jars found in your done folder
%~dp0tools\Apps\chgcolor %bg%
goto allzipaligndone
:allowallzipalign
set zipalignall=on
echo  2    Zipalign everything in the done folder
:allzipaligndone
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision:
if %zipalign%==on if %input%==1 goto zipalignone
if %zipalignall%==on if %input%==2 goto zipalignall
if %input%==99 goto restart
goto what
																				::ZIPALIGN PROJECT
:zipalignone
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Zipaligning Apk
%~dp0tools\Apps\chgcolor %bg%
echo.
if exist %~dp0done\unsigned%capp% %~dp0tools\Apps\zipalign -f 4 %~dp0done\unsigned%capp% %~dp0done\unsignedaligned%capp%
if exist %~dp0done\signed%capp% %~dp0tools\Apps\zipalign -f 4 %~dp0done\signed%capp% %~dp0done\signedaligned%capp%
if exist %~dp0done\unsigned%capp% del /q %~dp0done\unsigned%capp% > NUL
if exist %~dp0done\signed%capp% del /q %~dp0done\signed%capp% > NUL
if exist %~dp0done\unsignedaligned%capp% move %~dp0done\unsignedaligned%capp% %~dp0done\unsigned%capp% > NUL
if exist %~dp0done\signedaligned%capp% move %~dp0done\signedaligned%capp% %~dp0done\signed%capp% > NUL
%~dp0tools\Apps\chgcolor %high%
echo  %capp% zipaligned successfully
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new zipaligned project is located at:
echo.
if exist %~dp0done\unsigned%capp% echo  %~dp0done\unsigned%capp%
if exist %~dp0done\signed%capp% echo  %~dp0done\signed%capp%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::ZIPALIGN ALL
:zipalignall
if not exist %~dp0done\*.apk goto errorlog
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Zipaligning ALL Apks in the done folder
%~dp0tools\Apps\chgcolor %bg%
echo.
for %%g in (%~dp0done\signed*.apk) do (
	%~dp0tools\Apps\zipalign -f 4 %~dp0done\%%~nxg %~dp0done\aligned-%%~nxg
	echo zipaligning %%~nxg
	del /q %~dp0done\%%~nxg > NUL
	move %~dp0done\aligned-%%~nxg %~dp0done\%%~nxg > NUL
)
for %%g in (%~dp0done\unsigned*.apk) do (
	%~dp0tools\Apps\zipalign -f 4 %~dp0done\%%~nxg %~dp0done\aligned-%%~nxg
	echo zipaligning %%~nxg
	del /q %~dp0done\%%~nxg > NUL
	move %~dp0done\aligned-%%~nxg %~dp0done\%%~nxg > NUL
)
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Zipaligning finished
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new zipaligned projects are located at:
echo.
echo  %~dp0done\
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::COLOR CHANGE
:colorchange
cls
set /p Color="Enter a Hex or Smali color to convert: "
set LenTest=%Color%
set CharTest=%Color%
set cnt=1

:LenCount
set LenTest=%LenTest:~1%
if not A%LenTest%A==AA set /a cnt+=1&& goto LenCount
if %Cnt% GTR 6 goto LenError
if %Cnt% LSS 6 goto LenError
set cnt=1

:CharCheck
if %cnt% GTR 6 set cnt=1&& goto UCase
set Char%cnt%=!CharTest:~,1!
for %%I in (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F) do (
	if /i !Char%cnt%!==%%I (
		set /a cnt+=1
		set CharTest=!CharTest:~1!
		goto CharCheck
	)
)
Goto CharError

:UCase
if %cnt% GTR 6 set color=%Char1%%Char2%%Char3%%Char4%%Char5%%Char6%&& set cnt=1&& goto Convert
if !Char%cnt%!==a set Char%cnt%=!Char%cnt%:a=A!&& set /a cnt+=1&& goto UCase
if !Char%cnt%!==b set Char%cnt%=!Char%cnt%:b=B!&& set /a cnt+=1&& goto UCase
if !Char%cnt%!==c set Char%cnt%=!Char%cnt%:c=C!&& set /a cnt+=1&& goto UCase
if !Char%cnt%!==d set Char%cnt%=!Char%cnt%:d=D!&& set /a cnt+=1&& goto UCase
if !Char%cnt%!==e set Char%cnt%=!Char%cnt%:e=E!&& set /a cnt+=1&& goto UCase
if !Char%cnt%!==f set Char%cnt%=!Char%cnt%:f=F!&& set /a cnt+=1&& goto UCase
set/a cnt+=1&& goto UCase

:Convert
if %cnt% GTR 6 set NColor=%Char1%%Char2%%Char3%%Char4%%Char5%%Char6% && goto Output
if !Char%cnt%!==0 set Char%cnt%=!Char%cnt%:0=F!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==1 set Char%cnt%=!Char%cnt%:1=E!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==2 set Char%cnt%=!Char%cnt%:2=D!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==3 set Char%cnt%=!Char%cnt%:3=C!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==4 set Char%cnt%=!Char%cnt%:4=B!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==5 set Char%cnt%=!Char%cnt%:5=A!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==6 set Char%cnt%=!Char%cnt%:6=9!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==7 set Char%cnt%=!Char%cnt%:7=8!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==8 set Char%cnt%=!Char%cnt%:8=7!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==9 set Char%cnt%=!Char%cnt%:9=6!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==A set Char%cnt%=!Char%cnt%:A=5!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==B set Char%cnt%=!Char%cnt%:B=4!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==C set Char%cnt%=!Char%cnt%:C=3!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==D set Char%cnt%=!Char%cnt%:D=2!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==E set Char%cnt%=!Char%cnt%:E=1!&& set /a cnt+=1&& goto Convert
if !Char%cnt%!==F set Char%cnt%=!Char%cnt%:F=0!&& set /a cnt+=1&& goto Convert
set/a cnt+=1&& goto Convert

:Output
cls
echo Original color code:
echo  --------
echo ^| %Color% ^|
echo  --------
echo.
echo New color code:
echo  --------
echo ^| %NColor% ^|
echo  --------
echo.
if EXIST %windir%\System32\clip.exe echo Converted color code has been copied to clipboard&& echo %NColor% | clip
echo Press any key to return to continue...
pause>nul
set Color=
set NColor=
set LenTest=
set CharTest=
set Cnt=
set Char1=
set Char2=
set Char3=
set Char4=
set Char5=
set Char6=
goto restart

:LenError
echo Invalid Hex color length (%cnt%)
echo Press any key to return to color entry...
pause>nul
goto colorchange

:CharError
echo Invalid Hex character (!Char%cnt%!)
echo Press any key to return to color entry...
pause>nul
goto colorchange
																				::PULL LOGS FROM PHONE
:info
cls
set input=error
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto pullinfo
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to pull from?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
:pullinfo
del /q %~dp0phone-info\*.*
echo  Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
echo  Pull info from the phone and putting it in the phone-info dir
%~dp0tools\adb.exe -s %devicefinal% shell logcat -d > %~dp0phone-info\logcat.txt
%~dp0tools\adb.exe -s %devicefinal% shell dmesg >  %~dp0phone-info\dmesg.txt
%~dp0tools\adb.exe -s %devicefinal% shell getprop > %~dp0phone-info\prop.txt
%~dp0tools\adb.exe -s %devicefinal% pull /data/log/ %~dp0phone-info\dumpstates
%~dp0tools\adb.exe -s %devicefinal% pull /cache/recovery/last_log %~dp0phone-info\recovery_log.txt
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Phone Logs and Information have been pulled
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  The logs are located at:
echo.
echo  %~dp0phone-info\logcat.txt
echo  %~dp0phone-info\dmesg.txt
echo  %~dp0phone-info\prop.txt
echo  %~dp0phone-info\dumpstates
echo  %~dp0phone-info\recovery_log.txt
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
::DO NOT REMOVE
																				::NOT DECOMPILED ERROR
:dirnada
echo.
%~dp0tools\Apps\chgcolor %err%
echo %capp% has not been decompiled, please do so before doing this step
%~dp0tools\Apps\chgcolor %bg%
if %sound%==0 goto skipbeep4
start /min %~dp0tools\beep.bat
:skipbeep4
PAUSE
goto restart
																				::SEARCH
:search
if not exist %~dp0projects\%capp% goto searchsmali
if not exist %~dp0projects-smali\%capp% goto searchres
cls
set input=error
cd ..
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Where do you want to search?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Search smali
echo  2    Search res
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto searchsmali
::DO NOT REMOVE
if %input% EQU 2 goto searchres
::DO NOT REMOVE
if %input% EQU 99 goto restart
goto what
																				::SEARCH RES
:searchres
if %capp% EQU All goto skipsearch
start %~dp0tools\Apps\PRGrep\PRGrep.exe -dir "%~dp0projects\%capp%\res"
goto restart
																				::SEARCH SMALI
:searchsmali
if %capp% EQU All goto skipsearch
start %~dp0tools\Apps\PRGrep\PRGrep.exe -dir "%~dp0projects-smali\%capp%\"
goto restart
:skipsearch
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  No project selected to search inside of
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Choose a project with option 11
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::OPEN COLOR PICKER
:colorpick
::DO NOT REMOVE
start %~dp0tools\Apps\ColorMania.exe
goto restart
																				::OPEN ADB SHELL
:shell
set input=error
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto goshell
if /I !count! GTR 1 goto shellmultiple
:shellmultiple
echo.
%~dp0tools\Apps\chgcolor %high%
echo There are multiple devices plugged in. Which do you want to pull from?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
:goshell
start cmd.exe /c %~dp0tools\shell.cmd %devicefinal%
goto restart
																				::ERROR OCCURED
:errorlog
if %sound%==0 goto skipbeep5
rd /s /q %~dp0tools\temp\* > NUL
del /q %~dp0tools\temp\*.* > NUL
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
for /F "tokens=*" %%i in ('adb.exe remount') do set remount=%%i
if "%remount%"=="remount succeeded" (
	set remountavlible=Yes
)
echo %remountavlible%>%~dp0tools/temp/remount.txt
start /min %~dp0tools\beep.bat
:skipbeep5
%~dp0tools\Apps\chgcolor %err%
echo.
echo  An Error Occured, Please Check The Log
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::OPTIONS OTHER TOOLS 
:othertools
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Options other Apps
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Open droidAtScreen
echo  2    Open better9patch
echo  3    Open AXMLPrinterGUI
echo  4    Open Android Image Scaler
echo  5    Open Jd-GUI
echo  6    Open HxD Hex Editor
echo  7    Open VisualColorPicker
echo  8    Open ColorEdit
echo.
echo  9    Open GOptime Menu
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto droidatscreen
if %input% EQU 2 goto better9patch
if %input% EQU 3 goto axmlprintergui
if %input% EQU 4 goto androidimagescaler
if %input% EQU 5 goto jdgui
if %input% EQU 6 goto hxd
if %input% EQU 7 goto visualcolorpicker
if %input% EQU 8 goto coloredit
if %input% EQU 9 goto goptimize
if %input% EQU 99 goto restart
echo.
PAUSE
goto restart
																				::OPTIONS GOPTIMIZE 
:goptimize
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Options other Apps
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Open GOptimize
echo  2    Open ManualGO
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto autogo
if %input% EQU 2 goto manualgo
if %input% EQU 99 goto restart
echo.
PAUSE
goto restart
																				::OPTIONS MENU
:options
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Options and Misc Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Set the compression ratio
echo  2    Set max memory
echo  3    Set apktool version
echo  4    Set your resource files
echo  5    Set your Android SDK location
echo  6    Clean your folders
echo  7    Check the log
if %sound% EQU 0 goto optionskip 
echo  8    Disable sounds
:optionskip
if %sound% EQU 1 goto optionskip2 
echo  8    Enable sounds
:optionskip2
echo  9    Change the theme
echo.
echo  10   Check and Install an update by Rujelus22
echo  11   Check and Install an update by LordXeth
echo.
if %noupdatecheck% EQU 1 goto optionskip5
echo  12   Enable startup update check
:optionskip5
if %noupdatecheck% EQU 0 goto optionskip6
echo  12   Disable startup update check
:optionskip6
echo.
echo.
echo  13   About / Full Changelog
echo  14   About / Resources List
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Type input: %=%
if %input% EQU 1 goto compression
if %input% EQU 2 goto memory
::DO NOT REMOVE
if %input% EQU 3 goto apkver
::DO NOT REMOVE
if %input% EQU 4 goto setframe
if %input% EQU 5 goto setsdkfolder
if %input% EQU 6 goto clean
if %input% EQU 7 goto log
if %sound% EQU 0 goto optionskip3
if %input% EQU 8 goto disablebeep
:optionskip3
if %sound% EQU 1 goto optionskip4
if %input% EQU 8 goto enablebeep
:optionskip4
if %input% EQU 9 goto theme
if %input% EQU 10 goto update
if %input% EQU 11 goto update-lx
if %noupdatecheck% EQU 0 goto optionskip7
if %input% EQU 12 goto disableupdate
:optionskip7
if %noupdatecheck% EQU 1 goto optionskip8
if %input% EQU 12 goto enableupdate
:optionskip8
if %input% EQU 13 goto aboutfullchangelog
if %input% EQU 14 goto aboutresourceslist
if %input% EQU 99 goto restart
goto what
																				::ENABLE DISABLE UPDATES
:disableupdate
set firstrun=off
:disableupdatefirstrun
set noupdatecheck=error
set /p noupdatecheck=<%~dp0tools\Settings\updates.txt
set noupdatecheck=0
echo %noupdatecheck% > %~dp0tools\Settings\updates.txt
if %firstrun% EQU on goto firstrunbeep
goto restart
:enableupdate
set firstrun=off
:enableupdatefirstrun
set noupdatecheck=error
set /p noupdatecheck=<%~dp0tools\Settings\updates.txt
set noupdatecheck=1
echo %noupdatecheck% > %~dp0tools\Settings\updates.txt
if %firstrun% EQU on goto firstrunbeep
goto restart
																				::UPDATE AIO-1
:update
if exist %~dp0tools\checkversion.txt del /q %~dp0tools\checkversion.txt > NUL
cd %~dp0tools
%~dp0tools\Apps\wget\wget -q http://downloads.teamvenum.com/aio_script/checkversion.txt > NUL
cd %~dp0
set /p check=<%~dp0tools\checkversion.txt
set /p current=<%~dp0tools\Settings\version.txt
if /I !current! LSS !check! goto updatenow1
echo.
%~dp0tools\Apps\chgcolor %high%
echo  No updates at this time
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::UPDATE AIO-2
:update-lx
if exist %~dp0tools\checkversion.txt del /q %~dp0tools\checkversion.txt > NUL
cd %~dp0tools
%~dp0tools\Apps\wget\wget -q http://www.daily-battlefield.net/downloads/AIO_Script/checkversion.txt > NUL
cd %~dp0
set /p check=<%~dp0tools\checkversion.txt
set /p current=<%~dp0tools\Settings\version.txt
if /I !current! LSS !check! goto updatenow2
echo.
%~dp0tools\Apps\chgcolor %high%
echo  No updates at this time
%~dp0tools\Apps\chgcolor %bg%
echo.
PAUSE
goto restart
																				::RUN UPDATE-1
:updatenow1
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  New Update Found
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Would you like to install it?
set /P input=Type input: %=%
if %input% EQU n goto restart
if %input% EQU y goto exitandupdate1
goto what
:exitandupdate1
echo  Exiting ADB
tasklist /FI "IMAGENAME eq adb.exe" | find /I /N "adb.exe" > NUL
if "%ERRORLEVEL%"=="0" taskkill /IM adb.exe /f > NUL
echo  Leaving the app. Goodbye
start cmd.exe /c %~dp0tools\update.cmd
exit
goto restart
																				::RUN UPDATE-2
:updatenow2
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  New Update Found
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Would you like to install it?
set /P input=Type input: %=%
if %input% EQU n goto restart
if %input% EQU y goto exitandupdate2
goto what
:exitandupdate2
echo  Exiting ADB
tasklist /FI "IMAGENAME eq adb.exe" | find /I /N "adb.exe" > NUL
if "%ERRORLEVEL%"=="0" taskkill /IM adb.exe /f > NUL
echo  Leaving the app. Goodbye
start cmd.exe /c %~dp0tools\update-lx.cmd
exit
goto restart
																				::ABOUT FULL CHANGELOG
:aboutfullchangelog
cls
mode con:cols=80 lines=61
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  About / Full Changelog
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
type %~dp0tools\Settings\changelog.txt
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Setup Tools
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
type %~dp0tools\Settings\droidatscreen_path.txt
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Type input: %
if %input% EQU 99 goto restart
goto what
																				::ABOUT RESOURCES LIST
:aboutresourceslist
cls
mode con:cols=80 lines=55
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  About / Resources List
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo.
echo.
type %~dp0tools\Settings\changelog_resources.txt
echo.
echo.
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Type input: %
if %input% EQU 99 goto restart
goto what
																				::THEME MENU
:theme
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What would you like the main font color to be?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor 01
echo.
echo  1    Dark Blue
%~dp0tools\Apps\chgcolor 02
echo  2    Green
%~dp0tools\Apps\chgcolor 03
echo  3    Aqua
%~dp0tools\Apps\chgcolor 04
echo  4    Red
%~dp0tools\Apps\chgcolor 05
echo  5    Purple
%~dp0tools\Apps\chgcolor 06
echo  6    Yellow
%~dp0tools\Apps\chgcolor 07
echo  7    White
%~dp0tools\Apps\chgcolor 08
echo  8    Grey
%~dp0tools\Apps\chgcolor 09
echo  9    Light Blue
%~dp0tools\Apps\chgcolor 0A
echo  10   Light Green
%~dp0tools\Apps\chgcolor 0B
echo  11   Light Aqua
%~dp0tools\Apps\chgcolor 0C
echo  12    Light Red
%~dp0tools\Apps\chgcolor 0D
echo  13   Light Purple
%~dp0tools\Apps\chgcolor 0E
echo  14   Light Yellow
%~dp0tools\Apps\chgcolor 0F
echo  15   Bright White
%~dp0tools\Apps\chgcolor %bg%
echo.
if %firstrun% EQU on goto firstrunskip
echo  16   Reset to the default theme theme
echo.
echo  99   Go Back
echo.
:firstrunskip
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto theme01
if %input% EQU 2 goto theme02
if %input% EQU 3 goto theme03
if %input% EQU 4 goto theme04
if %input% EQU 5 goto theme05
if %input% EQU 6 goto theme06
if %input% EQU 7 goto theme07
if %input% EQU 8 goto theme08
if %input% EQU 9 goto theme09
if %input% EQU 10 goto theme0A
if %input% EQU 11 goto theme0B
if %input% EQU 12 goto theme0C
if %input% EQU 13 goto theme0D
if %input% EQU 14 goto theme0E
if %input% EQU 15 goto theme0F
if %firstrun% EQU on goto firstrunmenuskip
if %input% EQU 16 goto themeRT
if %input% EQU 99 goto restart
:firstrunmenuskip
goto what
																				::THEME HIGHLIGHT
:themehighlight
cls
%~dp0tools\Apps\chgcolor %bg%
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What do you want the highlight color to be?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor 01
echo.
echo  1    Dark Blue
%~dp0tools\Apps\chgcolor 02
echo  2    Green
%~dp0tools\Apps\chgcolor 03
echo  3    Aqua
%~dp0tools\Apps\chgcolor 04
echo  4    Red
%~dp0tools\Apps\chgcolor 05
echo  5    Purple
%~dp0tools\Apps\chgcolor 06
echo  6    Yellow
%~dp0tools\Apps\chgcolor 07
echo  7    White
%~dp0tools\Apps\chgcolor 08
echo  8    Grey
%~dp0tools\Apps\chgcolor 09
echo  9    Light Blue
%~dp0tools\Apps\chgcolor 0A
echo  10   Light Green
%~dp0tools\Apps\chgcolor 0B
echo  11   Light Aqua
%~dp0tools\Apps\chgcolor 0C
echo  12   Light Red
%~dp0tools\Apps\chgcolor 0D
echo  13   Light Purple
%~dp0tools\Apps\chgcolor 0E
echo  14   Light Yellow
%~dp0tools\Apps\chgcolor 0F
echo  15   Bright White
%~dp0tools\Apps\chgcolor %bg%
echo.
if %firstrun% EQU on goto firstrunskip
echo  99   Go Back
echo.
:firstrunskip
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto themehigh01
if %input% EQU 2 goto themehigh02
if %input% EQU 3 goto themehigh03
if %input% EQU 4 goto themehigh04
if %input% EQU 5 goto themehigh05
if %input% EQU 6 goto themehigh06
if %input% EQU 7 goto themehigh07
if %input% EQU 8 goto themehigh08
if %input% EQU 9 goto themehigh09
if %input% EQU 10 goto themehigh0A
if %input% EQU 11 goto themehigh0B
if %input% EQU 12 goto themehigh0C
if %input% EQU 13 goto themehigh0D
if %input% EQU 14 goto themehigh0E
if %input% EQU 15 goto themehigh0F
if %input% EQU 16 goto themeRT
if %firstrun% EQU on goto firstrunmenuskip
if %input% EQU 99 goto theme
:firstrunmenuskip
goto what
																				::THEME DISABLE
:themedis
cls
%~dp0tools\Apps\chgcolor %bg%
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What do you want the disabled menu color to be?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor 01
echo.
echo  1    Dark Blue
%~dp0tools\Apps\chgcolor 02
echo  2    Green
%~dp0tools\Apps\chgcolor 03
echo  3    Aqua
%~dp0tools\Apps\chgcolor 04
echo  4    Red
%~dp0tools\Apps\chgcolor 05
echo  5    Purple
%~dp0tools\Apps\chgcolor 06
echo  6    Yellow
%~dp0tools\Apps\chgcolor 07
echo  7    White
%~dp0tools\Apps\chgcolor 08
echo  8    Grey
%~dp0tools\Apps\chgcolor 09
echo  9    Light Blue
%~dp0tools\Apps\chgcolor 0A
echo  10   Light Green
%~dp0tools\Apps\chgcolor 0B
echo  11   Light Aqua
%~dp0tools\Apps\chgcolor 0C
echo  12   Light Red
%~dp0tools\Apps\chgcolor 0D
echo  13   Light Purple
%~dp0tools\Apps\chgcolor 0E
echo  14   Light Yellow
%~dp0tools\Apps\chgcolor 0F
echo  15   Bright White
%~dp0tools\Apps\chgcolor %bg%
echo.
if %firstrun% EQU on goto firstrunskip
echo  99   Go Back
echo.
:firstrunskip
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto themedis01
if %input% EQU 2 goto themedis02
if %input% EQU 3 goto themedis03
if %input% EQU 4 goto themedis04
if %input% EQU 5 goto themedis05
if %input% EQU 6 goto themedis06
if %input% EQU 7 goto themedis07
if %input% EQU 8 goto themedis08
if %input% EQU 9 goto themedis09
if %input% EQU 10 goto themedis0A
if %input% EQU 11 goto themedis0B
if %input% EQU 12 goto themedis0C
if %input% EQU 13 goto themedis0D
if %input% EQU 14 goto themedis0E
if %input% EQU 15 goto themedis0F
if %firstrun% EQU on goto firstrunmenuskip
if %input% EQU 99 goto themehighlight
:firstrunmenuskip
goto what
																				::THEME ERROR
:themeerr
cls
%~dp0tools\Apps\chgcolor %bg%
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What do you want the error color to be?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor 01
echo.
echo  1    Dark Blue
%~dp0tools\Apps\chgcolor 02
echo  2    Green
%~dp0tools\Apps\chgcolor 03
echo  3    Aqua
%~dp0tools\Apps\chgcolor 04
echo  4    Red
%~dp0tools\Apps\chgcolor 05
echo  5    Purple
%~dp0tools\Apps\chgcolor 06
echo  6    Yellow
%~dp0tools\Apps\chgcolor 07
echo  7    White
%~dp0tools\Apps\chgcolor 08
echo  8    Grey
%~dp0tools\Apps\chgcolor 09
echo  9    Light Blue
%~dp0tools\Apps\chgcolor 0A
echo  10   Light Green
%~dp0tools\Apps\chgcolor 0B
echo  11   Light Aqua
%~dp0tools\Apps\chgcolor 0C
echo  12   Light Red
%~dp0tools\Apps\chgcolor 0D
echo  13   Light Purple
%~dp0tools\Apps\chgcolor 0E
echo  14   Light Yellow
%~dp0tools\Apps\chgcolor 0F
echo  15   Bright White
%~dp0tools\Apps\chgcolor %bg%
echo.
if %firstrun% EQU on goto firstrunskip
echo  99   Go Back
echo.
:firstrunskip
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input% EQU 1 goto themeerr01
if %input% EQU 2 goto themeerr02
if %input% EQU 3 goto themeerr03
if %input% EQU 4 goto themeerr04
if %input% EQU 5 goto themeerr05
if %input% EQU 6 goto themeerr06
if %input% EQU 7 goto themeerr07
if %input% EQU 8 goto themeerr08
if %input% EQU 9 goto themeerr09
if %input% EQU 10 goto themeerr0A
if %input% EQU 11 goto themeerr0B
if %input% EQU 12 goto themeerr0C
if %input% EQU 13 goto themeerr0D
if %input% EQU 14 goto themeerr0E
if %input% EQU 15 goto themeerr0F
if %firstrun% EQU on goto firstrunskip
if %input% EQU 99 goto themedis
:firstrunskip
goto what
																				::SET DEFAULT THEME
:themeRT
set theme=0F
set err=4F
set dis=08
set high=1F
echo %theme% > %~dp0tools\Settings\themebg.txt
echo %err% > %~dp0tools\Settings\themeerr.txt
echo %dis% > %~dp0tools\Settings\themedis.txt
echo %high% > %~dp0tools\Settings\themehigh.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::DARK BLUE COLORS
:theme01
set theme=01
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh01
set high=1F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis01
set dis=01
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr01
set err=01
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::GREEN COLORS
:theme02
set theme=02
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh02
set high=2F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis02
set dis=02
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr02
set err=02
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::AQUA COLORS
:theme03
set theme=03
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh03
set high=3F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis03
set dis=03
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr03
set err=03
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::RED COLORS
:theme04
set theme=04
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh04
set high=4F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis04
set dis=04
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr04
set err=04
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::PURPLE COLORS
:theme05
set theme=05
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh05
set high=5F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis05
set dis=05
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr05
set err=05
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::YELLOW COLORS
:theme06
set theme=06
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh06
set high=6F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis06
set dis=06
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr06
set err=06
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::WHITE COLORS
:theme07
set theme=07
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh07
set high=7F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis07
set dis=07
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr07
set err=07
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::GREY COLORS
:theme08
set theme=08
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh08
set high=8F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis08
set dis=08
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr08
set err=08
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::LIGHT BLUE
:theme09
set theme=09
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh09
set high=9F
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis09
set dis=09
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr09
set err=09
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::LIGHT GREEN
:theme0A
set theme=0A
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh0A
set high=AF
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis0A
set dis=0A
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr0A
set err=0A
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::LIGHT AQUA
:theme0B
set theme=0B
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh0B
set high=BF
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis0B
set dis=0B
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr0B
set err=0B
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::LIGHT RED
:theme0C
set theme=0C
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh0C
set high=CF
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis0C
set dis=0C
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr0C
set err=0C
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::LIGHT PURPLE
:theme0D
set theme=0D
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh0D
set high=DF
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis0D
set dis=0D
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr0D
set err=0D
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::LIGHT YELLOW
:theme0E
set theme=0E
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh0E
set high=EF
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis0E
set dis=0E
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr0E
set err=0E
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::BRIGHT WHITE
:theme0F
set theme=0F
echo %theme% > %~dp0tools\Settings\themebg.txt
set bg=%theme%
goto themehighlight
:themehigh0F
set high=F0
echo %high% > %~dp0tools\Settings\themehigh.txt
goto themedis
:themedis0F
set dis=0F
echo %dis% > %~dp0tools\Settings\themedis.txt
goto themeerr
:themeerr0F
set err=0F
echo %err% > %~dp0tools\Settings\themeerr.txt
if %firstrun% EQU on goto afterfirstrun
goto restart
																				::ENABLE DISABLE SOUNDS
:disablebeep
set firstrun=off
:disablebeepfirstrun
set /p sound=<%~dp0tools\Settings\beep.txt
set sound=0
echo %sound% > %~dp0tools\Settings\beep.txt
if %firstrun% EQU on goto settheme
goto restart
:enablebeep
set firstrun=off
:enablebeepfirstrun
set /p sound=<%~dp0tools\Settings\beep.txt
set sound=1
echo %sound% > %~dp0tools\Settings\beep.txt
if %firstrun% EQU on goto settheme
goto restart
																				::SET SDK MANAGER
:setsdkfolder
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Where is your Android SDK located?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo Example: C:\Program Files\Android\android-sdk
set /P input=Type input: %=%
echo %input% > %~dp0tools\Settings\sdk_location.txt
echo.
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Your SDK is now set to
echo  %input%
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
goto restart
																				::OPEN AVD MANAGER
:emulator
set /p sdklocation=<%~dp0tools\Settings\sdk_location.txt
if exist "%sdklocation%" (
	"%sdklocation%\AVD Manager.exe"
	goto restart
)
if exist "C:\Program Files (x86)\Android\android-sdk" (
	"C:\Program Files (x86)\Android\android-sdk\AVD Manager.exe"
	goto restart
)
if exist "C:\Program Files\Android\android-sdk" (
	"C:\Program Files\Android\android-sdk\AVD Manager.exe"
	goto restart
)
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  Android-sdk was not found at 
echo.
echo %sdklocation%
echo  or at C:\Program Files ^(x86^)\Android\android-sdk
echo  or at C:\Program Files\Android\android-sdk
echo.
echo  Install the Android-SDK to open an emulator
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
if %sound%==0 goto skipbeep6
start /min %~dp0tools\beep.bat
:skipbeep6
PAUSE
goto restart
																				::SET APKTOOL VERSION
:apkver
set firstrun=off
::DO NOT REMOVE
:apkverfirstrun
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Which version would you like to use
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo  #					#				     #
echo  #	1    1.3.2	7    1.5.0	#		   12    2.0.0-b1    #
echo  #	2    1.4.0	8    1.5.1	#    		   13    2.0.0-b2    #
echo  #	3    1.4.1	9    1.5.2	#    Apktool  	   14    2.0.0-b3    #
echo  #	4    1.4.2	10   1.5.3	#      2.0	   15    2.0.0-b4    #
echo  #	5    1.4.3	11   1.5.3-inv	#		   16    2.0.0-b5    #
echo  #	6    1.4.9			#		   17    2.0.0-b6    #
echo  #					#				     #
if %firstrun% EQU on goto firstrunskip
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
:firstrunskip
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %input%==1 goto version1
if %input%==2 goto version2
if %input%==3 goto version3
if %input%==4 goto version4
if %input%==5 goto version5
if %input%==6 goto version6
if %input%==7 goto version7
if %input%==8 goto version8
if %input%==9 goto version9
if %input%==10 goto version10
if %input%==11 goto version11
if %input%==12 goto version12
if %input%==13 goto version13
if %input%==14 goto version14
if %input%==15 goto version15
if %input%==16 goto version16
if %input%==17 goto version17
if %firstrun% EQU on goto firstrunmenuskip
if %input%==99 goto restart
:firstrunmenuskip
goto what
:version1
set apktool=apktool-1.3.2.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version2
set apktool=apktool-1.4.0.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version3
set apktool=apktool-1.4.1.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version4
set apktool=apktool-1.4.2.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version5
set apktool=apktool-1.4.3.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version6
set apktool=apktool-1.4.9.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version7
set apktool=apktool-1.5.0.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version8
set apktool=apktool-1.5.1.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version9
set apktool=apktool-1.5.2.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version10
set apktool=apktool-1.5.3.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version11
set apktool=apktool-1.5.3-inv.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version12
set apktool=apktool-2.0.0b1.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version13
set apktool=apktool-2.0.0b2.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version14
set apktool=apktool-2.0.0b3.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version15
set apktool=apktool-2.0.0b4.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version16
set apktool=apktool-2.0.0b5.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart
:version17
set apktool=apktool-2.0.0b6.jar
echo %apktool% > %~dp0tools\Settings\apktool_settings.txt
if %firstrun% EQU on goto setupdates
goto restart																				::OPEN LOG
:log
cls
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Which Log Would You Like To View
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Script Log
if not exist %~dp0tools\logs\odexlog.log goto noodexlog
set odexlog=on
echo  2    Odex Log
goto odexlogdone
:noodexlog
set odexlog=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    Odex Log was not found
%~dp0tools\Apps\chgcolor %bg%
:odexlogdone
if not exist %~dp0tools\logs\reodexlog.log goto noreodexlog
set reodexlog=on
echo  3    Re-Odex Log
goto reodexlogdone
:noreodexlog
set reodexlog=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    Re-Odex Log was not found
%~dp0tools\Apps\chgcolor %bg%
:reodexlogdone
if not exist %~dp0tools\logs\deodexlog.log goto nodeodexlog
set deodexlog=on
echo  4    Deodex Log
goto deodexlogdone
:nodeodexlog
set deodexlog=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    Deodex Log was not found
%~dp0tools\Apps\chgcolor %bg%
:deodexlogdone
if not exist %~dp0tools\logs\pngoptimizelog.log goto nopnglog
set pnglog=on
echo  5    PNG Optimization Log
goto pnglogdone
:nopnglog
set pnglog=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    PNG Log was not found
%~dp0tools\Apps\chgcolor %bg%
:pnglogdone
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision:
if %input%==1 goto scriptlog
if %odexlog%==off goto skipodexlog
if %input%==2 goto odexlog
:skipodexlog
if %reodexlog%==off goto skipreodexlog
if %input%==3 goto reodexlog
:skipreodexlog
if %deodexlog%==off goto skipdeodexlog
if %input%==4 goto deodexlog
:skipdeodexlog
if %deodexlog%==off goto skippnglog
if %input%==5 goto pnglog
:skippnglog
if %input%==99 goto restart
goto what
:scriptlog
start %~dp0tools\Apps\Notepad++\notepad++.exe %~dp0tools\logs\log.log
goto restart
:odexlog
start %~dp0tools\Apps\Notepad++\notepad++.exe %~dp0tools\logs\odexlog.log
goto restart
:reodexlog
start %~dp0tools\Apps\Notepad++\notepad++.exe %~dp0tools\logs\reodexlog.log
goto restart
:deodexlog
start %~dp0tools\Apps\Notepad++\notepad++.exe %~dp0tools\logs\deodex.log
goto restart
:pnglog
start %~dp0tools\Apps\Notepad++\notepad++.exe %~dp0tools\logs\pngoptimizelog.log
goto restart
																				::CLEAN MENU
:clean
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Clean and Backup Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Clean the Done Folder
echo  2    Clean the Droid-Screen
echo  3    Clean the Originals Folder
echo  4    Clean the Odex Originals Folder
echo  5    Clean the place-here-for-modding Folder
echo  6    Clean the place-scale-images Folder
echo  7    Clean the Projects\Projects-smali Folders
echo  8    Clean the Pulled Folder
echo  9    Clean All Folders\Files
echo  10   Clean All Folders\Files with backup [Takes awhile]
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision:
																				::CLEAN DONE
if %input%==1 (
	echo  Clearing Done Dir
	rd /s /q %~dp0done
	mkdir %~dp0done
	mkdir %~dp0done\optimized
	mkdir %~dp0done\flashable
	goto restart
)
																				::CLEAN DROID-SCREEN
IF %input%==2 (
	echo  Clearing Droid-Screen folder
	rd /s /q %~dp0droid-screen
	mkdir %~dp0droid-screen
	goto restart
)
																				::CLEAN ORIGINALS
IF %input%==3 (
	echo  Clearing Originals Dir
	if exist %~dp0originals rd /s /q %~dp0originals
	mkdir %~dp0originals
	goto restart
)
																				::CLEAN ODEX ORIGINALS
IF %input%==4 (
	echo  Clearing Odex Originals folder
	if exist %~dp0tools\odex\originals rd /s /q %~dp0tools\odex\originals
	goto restart
)
																				::CLEAN PLACE-HERE-FOR-MODDING
IF %input%==5 (
	echo  Clearing place-here-for-modding folder
	rd /s /q %~dp0place-here-for-modding
	mkdir %~dp0place-here-for-modding
	goto restart
)
																				::CLEAN PLACE-SCALE-IMAGES
IF %input%==6 (
	echo  Clearing place-scale-images folder
	rd /s /q %~dp0place-scale-images
	mkdir %~dp0place-scale-images
	mkdir %~dp0place-scale-images\res
	goto restart
)
																				::CLEAN PROJECTS AND PROJECTS-SMALI
IF %input%==7 (
	echo  Clearing Projects and Projects-smali
	rd /s /q %~dp0projects
	rd /s /q %~dp0projects-smali
	mkdir %~dp0projects
	mkdir %~dp0projects-smali
	goto restart
)
																				::CLEAN PULLED
IF %input%==8 (
	echo  Clearing Pull
	rd /s /q %~dp0pulled
	mkdir %~dp0pulled
	goto restart
)
																				::CLEAN ALL
IF %input%==9 (
	echo  Cleaning all dirs
	rd /s /q %~dp0done
	rd /s /q %~dp0droid-screen
	rd /s /q %~dp0originals
	if exist %~dp0tools\odex\originals rd /s /q %~dp0tools\odex\originals
	rd /s /q %~dp0place-here-for-modding
	rd /s /q %~dp0place-scale-images
	rd /s /q %~dp0projects
	rd /s /q %~dp0projects-smali
	rd /s /q %~dp0pulled
	mkdir %~dp0done
	mkdir %~dp0droid-screen
	mkdir %~dp0originals
	mkdir %~dp0place-here-for-modding
	mkdir %~dp0place-scale-images
	mkdir %~dp0place-scale-images\res
	mkdir %~dp0projects
	mkdir %~dp0projects-smali
	mkdir %~dp0pulled
	goto restart
)
																				::CLEAN ALL WITH BACKUP
IF %input%==10 (
	goto renamebackupzip
)
IF %input%==99 goto restart
																				::RENAME BACKUP ZIP
:renamebackupzip
set backup=error
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set file=%month%.%day%.%year%_%hour%.%min%
echo.
%~dp0tools\Apps\chgcolor %high%
echo  The backup file will be named:
%~dp0tools\Apps\chgcolor %bg%
echo %file%.zip
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Would you like to rename the file [y/n]
%~dp0tools\Apps\chgcolor %bg%
set /P backup=Type input: %=%
if %backup% EQU n goto makebackupzip
if %backup% EQU y goto renamezip
goto what	
																				::MAKE BACKUP ZIP
:makebackupzip
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Backing up and cleaning all dirs
echo  Please wait...
%~dp0tools\Apps\chgcolor %bg%
cd %~dp0
if not exist %~dp0originals\odex\ mkdir %~dp0originals\odex\ > NUL
if exist %~dp0tools\odex\originals move %~dp0tools\odex\originals %~dp0originals\odex\ > NUL
%~dp0tools\Apps\7za.exe a %~dp0backup\%File%.zip "*" -x@%~dp0tools\Settings\exclude.txt -mx%usrc% -r > NUL
rd /s /q %~dp0done
rd /s /q %~dp0droid-screen
rd /s /q %~dp0originals
rd /s /q %~dp0place-here-for-modding
rd /s /q %~dp0place-scale-images
rd /s /q %~dp0projects
rd /s /q %~dp0projects-smali
rd /s /q %~dp0pulled
mkdir %~dp0done
mkdir %~dp0droid-screen
mkdir %~dp0originals
mkdir %~dp0place-here-for-modding
mkdir %~dp0place-scale-images
mkdir %~dp0place-scale-images\res
mkdir %~dp0projects
mkdir %~dp0projects-smali
mkdir %~dp0pulled
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Folders cleaned and backup made
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new backup is located at:
echo.
echo  %~dp0backup\%file%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
echo.
PAUSE
goto restart
																				::RENAME BACKUP ZIP
:renamezip
set FILE=error
echo  Would you like to name the file?
set /P FILE=Type input: %=%
set file=%FILE%
goto makebackupzip
																				::SET RESOURCE FILES
:setframe
cls
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set file=%month%.%day%.%year%_%hour%.%min%
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Which resource files would you like to use?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Resource files are very picky. If one of the default choices does not work
echo  use option 10 and put in your own framework files
echo.
%~dp0tools\Apps\chgcolor %high%
echo  ------------------------------- Samsung Devices ------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  1    Galaxy SII (Stock)
echo  2    Galaxy SIII (Stock)
echo  3    Galaxy Nexus (Stock)
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- Asus Devices --------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  4    Nexus 7 (Stock)
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- HTC Devices ---------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  5    Evo LTE (Stock)
echo  6    One X (Stock)
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- Other Resource Files ------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  7    CM9
echo  8    CM10
echo.
echo  9    CM10.2 Nexus 4 (CyanKang)
echo.
echo  10   MIUI
echo.
%~dp0tools\Apps\chgcolor %high%
echo  -------------------------------- Use Your Own --------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  88   Other
echo.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Please make your decision:
if %input% EQU 1 goto e4gtresource
if %input% EQU 2 goto s3resource
if %input% EQU 3 goto gnexresource
if %input% EQU 4 goto n7resource
if %input% EQU 5 goto evotleresource
if %input% EQU 6 goto onexresource
if %input% EQU 7 goto cm9resource
if %input% EQU 8 goto cm10resource
if %input% EQU 9 goto cm102cyankang
if %input% EQU 10 goto miuiresource
if %input% EQU 88 goto resourceinstall
if %input% EQU 99 goto restart

:e4gtresource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\e4gt\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\e4gt\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for the Galaxy Epic 4G Touch
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:s3resource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\s3\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\s3\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for the Galaxy SIII
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:n7resource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\n7\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\n7\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for the Nexus 7
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:evotleresource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\evolte\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\evolte\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for the Evo LTE
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:gnexresource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\gnex\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\gnex\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for the Galaxy Nexus
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:onexresource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\onex\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\onex\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for the One X
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:cm9resource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\cm9\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\cm9\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for CM9
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:cm10resource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\cm10\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\cm10\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for CM10
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:cm102cyankang
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\cm102cyankang\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\cm102cyankang\2.apk %UserProfile%\apktool\framework\2.apk > NUL
copy %~dp0tools\resources\cm102cyankang\127.apk %UserProfile%\apktool\framework\127.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for CM10.1 Schubi
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:miuiresource
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk > NUL
move %UserProfile%\apktool\framework\127.apk %~dp0\backup\127-resource-backup-%file%.apk > NUL
copy %~dp0tools\resources\miui\1.apk %UserProfile%\apktool\framework\1.apk > NUL
copy %~dp0tools\resources\miui\2.apk %UserProfile%\apktool\framework\2.apk > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo. 
echo  Your resource files have been set for MIUI
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::SET RESOURCE OTHER
:resourceinstall
set input=error
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Where is your framework-res.apk file?
echo.
echo  Example: C:\framework-res.apk
%~dp0tools\Apps\chgcolor %bg%
set /P input=Type input or drag file here: %=%
echo.
echo  Setting new resource file and backing up the old one
copy /y %input% %~dp0tools\temp\framework-res.apk > NUL
%~dp0tools\Apps\7za.exe x %~dp0tools\temp\framework-res.apk -y -o%~dp0tools\temp\framework\ > NUL
mkdir %~dp0tools\temp\framework2
copy %~dp0tools\temp\framework\resources.arsc %~dp0tools\temp\framework2\resources.arsc > NUL
cd %~dp0tools\temp\framework2\
%~dp0tools\Apps\7za.exe a "1.zip" "*" -mx%usrc% -r > NUL
move %UserProfile%\apktool\framework\1.apk %~dp0\backup\1-resource-backup-%file%.apk > NUL
move /y 1.zip %UserProfile%\apktool\framework\1.apk > NUL
cd ..
rd /s /q %~dp0tools\temp\framework
rd /s /q %~dp0tools\temp\framework2
del /q %~dp0tools\temp\framework-res.apk
cls
set input=error
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Where is your secondary resource file?
echo.
echo  Example: C:\twframework-res.apk or c:\com.htc.resources.apk
%~dp0tools\Apps\chgcolor %bg%
echo  if AOSP based ROM use the framework-res.apk file again
set /P input=Type input: %=%
echo.
copy /y %input% %~dp0tools\temp\framework-res2.apk > NUL
%~dp0tools\Apps\7za.exe x %~dp0tools\temp\framework-res2.apk -y -o%~dp0tools\temp\framework3\ > NUL
mkdir %~dp0tools\temp\framework22
copy %~dp0tools\temp\framework3\resources.arsc %~dp0tools\temp\framework22\resources.arsc > NUL
cd %~dp0tools\temp\framework22\
%~dp0tools\Apps\7za.exe a "2.zip" "*" -mx%usrc% -r > NUL
IF EXIST "%UserProfile%\apktool\framework\2.apk" (move %UserProfile%\apktool\framework\2.apk %~dp0\backup\2-resource-backup-%file%.apk)
move /y 2.zip %UserProfile%\apktool\framework\2.apk > NUL
cd ..
rd /s /q %~dp0tools\temp\framework3
rd /s /q %~dp0tools\temp\framework22
del /q %~dp0tools\temp\framework-res2.apk
echo.
if %sound%==0 goto skipbeep12
start /min %~dp0tools\beep.bat
:skipbeep12
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Your new 1 resource file is set and located at:
%~dp0tools\Apps\chgcolor %bg%
echo %UserProfile%\apktool\framework\1.apk
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Your old resource file is located at:
%~dp0tools\Apps\chgcolor %bg%
echo %~dp0backup\1-resource-backup-%file%.apk
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Your new 2 resource file is set and located at:
%~dp0tools\Apps\chgcolor %bg%
echo %UserProfile%\apktool\framework\2.apk
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Your old resource file is located at:
%~dp0tools\Apps\chgcolor %bg%
echo %~dp0backup\2-resource-backup-%file%.apk
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::REBOOT RECOVERY
:rebootr
cls
set input=error
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto rebootrnow
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to pull from?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
:rebootrnow
cd %~dp0tools
echo Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe remount > NUL
echo.
echo  Rebooting the phone to Recovery
%~dp0tools\adb.exe reboot recovery
goto restart
																				::REBOOT PHONE
:reboot
cls
set input=error
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto rebootnow
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to pull from?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
:rebootnow
cd %~dp0tools
echo  Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe remount > NUL
echo.
echo  Rebooting the phone
%~dp0tools\adb.exe reboot
goto restart
																				::SET COMPRESSION
:compression
set input=error
echo.
set /P input=Enter Compression Level (0-9) : %=%
echo %input% > %~dp0tools\Settings\compression_settings.txt
set usrc=%input%
goto restart
																				::SET MEMORY
:memory
echo.
set input=error
set /P input=Enter max size for java heap space in megabytes (eg 512) : %=%
set heapy=%input%
goto restart
																				::OPEN NOTEPAD++
:notepad
start %~dp0tools\Apps\Notepad++\notepad++.exe
goto restart
																				::OPEN DROID At SCREEN
:droidatscreen
start %~dp0tools\Apps\droidatscreen.jar
goto restart
																				::OPEN BETTER 9 PATCH
:better9patch
start %~dp0tools\Apps\better9patch.jar
goto restart
																				::OPEN AMXL PRINTER GUI
:amxlprintergui
start %~dp0tools\Apps\AXMLPrinterGUI\AXMLPrinter.exe
goto restart
																				::OPEN ANDROID IMAGE SCALER
:androidimagescaler
start %~dp0tools\Apps\AndroidImageScaler\AndroidImageScaler.exe
goto restart
																				::OPEN JD-GUI
:jdgui
start %~dp0tools\Apps\Jd-GUI\jd-gui.exe
goto restart
																				::OPEN HXD HEX EDITOR
:hxd
start %~dp0tools\Apps\HxD\HxD.exe
goto restart
																				::OPEN VISUAL COLOR PICKER
:visualcolorpicker
start %~dp0tools\Apps\VisualColorPicker\ColorPicker.exe
goto restart
																				::OPEN COLOR EDIT
:coloredit
start %~dp0tools\Apps\VisualColorPicker\ColorEdit.exe
goto restart
																				::OPEN AUTO GOPTIMIZE
:autogo
start cmd.exe /c GOptimize.cmd
goto restart
																				::OPEN MANUAL GOPTIMIZE
:manualgo
start cmd.exe /c ManualGO.cmd
goto restart
																				::PHONE MENU
:phone
cls
echo  Checking ADB connection status
set adbwifi=Connected
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set /A COUNT+=1
	set a!count!=%%a
)
if /I !count! LSS 1 set adbwifi=Disconnected
if /I !count! GTR 1 set adbwifi=Connected
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Phone\Emulator Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
if %adbwifi%==Connected goto allowemulator
set emulator=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected
%~dp0tools\Apps\chgcolor %bg%
goto emulatordone
:allowemulator
set emulator=on
echo.
echo  1    Open Adb shell
:emulatordone
echo  2    Open an Android Emulator
echo  3    Open the Android SDK [To Update]
if %adbwifi%==Connected goto allowlogs
set logs=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected
%~dp0tools\Apps\chgcolor %bg%
goto logsdone
:allowlogs
set logs=on
echo  4    Get log info from the phone\emulator
:logsdone
if %adbwifi%==Connected goto allowddms
set ddms=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected
%~dp0tools\Apps\chgcolor %bg%
goto ddmsdone
:allowddms
set ddms=on
echo  5    Open Dalvik Debug Monitor [Screenshots and Debug]
:ddmsdone
if %adbwifi%==Connected goto allowpermissions
set permissions=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected
%~dp0tools\Apps\chgcolor %bg%
goto permissionsdone
:allowpermissions
set permissions=on
echo  6    Set file permissions
:permissionsdone
::echo.
::if %adbwifi%==Connected goto allowcwmbackup
::set cwmback=off
::%~dp0tools\Apps\chgcolor %dis%
::echo  -    No phone or emulator connected
::%~dp0tools\Apps\chgcolor %bg%
::goto cwmbackupdone
:::allowcwmbackup
::set cwmback=on
::echo  7    Make an nand backup
:::cwmbackupdone
::if %adbwifi%==Connected goto allowcwmrestore
::set cwmrestore=off
::%~dp0tools\Apps\chgcolor %dis%
::echo  -    No phone or emulator connected
::%~dp0tools\Apps\chgcolor %bg%
::goto cwmrestoredone
:::allowcwmrestore
::set cwmrestore=on
::echo  8    Restore an nand backup
:::cwmrestoredone
::if %adbwifi%==Connected goto allowmanaagenand
::set managenand=off
::%~dp0tools\Apps\chgcolor %dis%
::echo  -    No phone or emulator connected
::%~dp0tools\Apps\chgcolor %bg%
::goto manaagenanddone
:::allowmanaagenand
::set managenand=on
::echo  9    Manage your nand backups
:::manaagenanddone
echo.
if %adbwifi%==Connected goto allowreboot
set reboot=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected
%~dp0tools\Apps\chgcolor %bg%
goto rebootdone
:allowreboot
set reboot=on
echo  10   Reboot the phone
:rebootdone
if %adbwifi%==Connected goto allowrebootrecovery
set rebootrecovery=off
%~dp0tools\Apps\chgcolor %dis%
echo  -    No phone or emulator connected
%~dp0tools\Apps\chgcolor %bg%
goto rebootrecoverydone
:allowrebootrecovery
set rebootrecovery=on
echo  11   Reboot the phone to recovery
:rebootrecoverydone
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Type input: %=%
if %emulator% EQU off goto disallowshell
if %input% EQU 1 goto shell
:disallowshell
if %input% EQU 2 goto emulator
if %input% EQU 3 goto andsdk
if %logs% EQU off goto disallowlogs
if %input% EQU 4 goto info
:disallowlogs
if %ddms% EQU off goto disallowddms
if %input% EQU 5 goto ddms
:disallowddms
if %permissions% EQU off goto disallowpermissions
if %input% EQU 6 goto permissions
:disallowpermissions
::if %cwmback% EQU off goto disallowcwmback
::if %input% EQU 7 goto nandbackup
::DO NOT REMOVE
:::disallowcwmback
::if %cwmrestore% EQU off goto disallowcwmrestore
::if %input% EQU 8 goto restorebackup
:::disallowcwmrestore
::if %managenand% EQU off goto disallowmanagenand
::if %input% EQU 9 goto managebackups
:disallowmanagenand
if %reboot% EQU off goto disallowreboot
if %input% EQU 10 goto reboot
:disallowreboot
if %rebootrecovery% EQU off goto disallowrebootrecovery
if %input% EQU 11 goto rebootr
:disallowrebootrecovery
if %input% EQU 99 goto restart
goto what
																				::MAKE NAND BACKUP
:nandbackup
::DO NOT REMOVE
set odexbackup=no
:backupb4odex
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set file=%month%.%day%.%year%_%hour%.%min%
cls 
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Pushing needed information to the phone
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Please Wait...
echo.
%~dp0tools\adb.exe -s %devicefinal% shell "echo 'backup_rom(\"/sdcard/clockworkmod/backup/%file%\");' >> /cache/recovery/extendedcommand"
%~dp0tools\adb.exe -s %devicefinal% shell "echo backup /TWRP/BACKUP/%devicefinal%/%file% >> /cache/recovery/openrecoveryscript"
%~dp0tools\adb.exe -s %devicefinal% reboot recovery
echo  Your phone will now reboot and make an nand backup.
echo.
echo  Your phone will reboot itself when the backup is complete.
if %odexbackup% EQU yes echo.
if %odexbackup% EQU yes echo  The ROM odex process will restart after your backup has completed.
echo.
echo.
if %odexbackup% EQU yes (
	ping -n 10 127.0.0.1 > nul
	goto nanddoneodex
)
PAUSE
goto restart
																				::RESTORE NAND BACKUP
:restorebackup
::DO NOT REMOVE
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
set input=error
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Which backup do you want to restore?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /A count=0
if exist %~dp0tools\odex\apps.txt del /q %~dp0tools\odex\apps.txt
%~dp0tools\adb.exe -s %devicefinal% shell "ls /sdcard/clockworkmod/backup/ | xargs -n 1 basename">>%~dp0tools\odex\apps.txt
%~dp0tools\adb.exe -s %devicefinal% shell "ls /sdcard/TWRP/BACKUP/%devicefinal%/ | xargs -n 1 basename">>%~dp0tools\odex\apps.txt
for /f %%A in (%~dp0tools\odex\apps.txt) do (
	set /A count+=1
	set a!count!=%%A
	if /I !count! LSS 10 echo   !count!   %%A
	if /I !count! GTR 9 echo   !count!  %%A
)
echo.
echo   99  Go Back
echo.
echo  ------------------------------------------------------------------------------
set /P input=Enter It's Number: %=%
if %input% EQU 99 goto restart
if /I %input% GTR !count! goto what
if /I %input% LSS 1 goto what
set restore=!a%input%!
cls 
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Starting the Restore Process
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Please Wait...
echo.
%~dp0tools\adb.exe -s %devicefinal% shell "echo 'restore_rom(\"/sdcard/clockworkmod/backup/%restore%\");' >> /cache/recovery/extendedcommand"
%~dp0tools\adb.exe -s %devicefinal% reboot recovery
echo  Your phone will now reboot and restore the %restore% backup.
echo.
echo  Your phone will reboot itself when the restore is complete.
echo.
echo.
PAUSE
goto restart
																				::MANGE BACKUP
:managebackups
cls
set /A count=0
%~dp0tools\adb.exe -s %devicefinal% shell ls -l /sdcard/clockworkmod/backup/* > %~dp0tools\Settings\backups.txt
for /f %%C in ('Find /V /C "" ^< %~dp0tools\Settings\backups.txt') do set count=%%C
if %count% EQU 1 goto checkagain
if %count% LSS 2 goto nobackups
if %count% GTR 1 goto allownandbackup
:checkagain
set /A count=0
if exist %~dp0tools\Settings\backups.txt del /q %~dp0tools\Settings\backups.txt
%~dp0tools\adb.exe -s %devicefinal% shell ls -l /sdcard/clockworkmod/backup/ > %~dp0tools\Settings\backups.txt
for /f %%C in ('Find /V /C "" ^< %~dp0tools\Settings\backups.txt') do set count=%%C
if exist %~dp0tools\Settings\backups.txt del /q %~dp0tools\Settings\backups.txt
if %count% LSS 1 goto nobackups
:allownandbackup
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
set input=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Which backup do you want to manage?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /A count=0
%~dp0tools\adb.exe -s %devicefinal% shell "ls /sdcard/clockworkmod/backup/ | xargs -n 1 basename">%~dp0tools\temp\apps.txt
for /f %%A in (%~dp0tools\temp\apps.txt) do (
	set /A count+=1
	set a!count!=%%A
	if /I !count! LSS 10 echo   !count!   %%A
	if /I !count! GTR 9 echo   !count!  %%A
)
echo.
echo  ------------------------------------------------------------------------------
set /P input=Enter It's Number: %=%
if /I %input% GTR !count! goto what
if /I %input% LSS 1 goto what
set manage=!a%input%!
if exist %~dp0tools\temp\apps.txt del /q %~dp0tools\temp\apps.txt
cls
set choice=error
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What would you like to do with this backup?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Delete it
echo  2    Fix MD5 mismatch error
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P choice=Enter a number: %=%
if %choice% EQU 1 goto deletenand
if %choice% EQU 2 goto fixmd5
if %choice% EQU 99 goto restart
goto what
:nobackups
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %err%
echo  You have no backups to manage
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::DELETE NAND
:deletenand
set deleteme=!a%input%!
cls
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Deleting /sdcard/clockworkmod/backup/%deleteme%
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/clockworkmod/backup/%deleteme%
echo. 
echo  /sdcard/clockworkmod/backup/%deleteme% has been deleted.
echo.
echo.
PAUSE
goto restart
																				::FIX NAND MD5 MISMATCH
:fixmd5
set fixme=!a%input%!
cls
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %err%
echo      WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  This should allow you to restore this backup. 
echo.
echo  This does not guarantee that the nand is actually good.
echo.
echo  ------------------------------------------------------------------------------
echo.
echo  Fixing MD5...
echo.
echo  Deleting old nandroid.md5
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/clockworkmod/backup/%fixme%/nandroid.md5
echo.
echo  Making new nandroid.md5
%~dp0tools\adb.exe -s %devicefinal% shell "md5sum /sdcard/clockworkmod/backup/%fixme%/*img > /sdcard/clockworkmod/backup/%fixme%/nandroid.md5"
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Fixed /sdcard/clockworkmod/backup/%fixme%/
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  You should be able to restore it now.
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::SET PERMISSONS
:permissions
cls
echo Checking ADB connection status
set adbwifi=Connected
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set /A count+=1
	set a!count!=%%a
)
if /I !count! LSS 1 set adbwifi=Disconnected
if /I !count! GTR 1 set adbwifi=Connected
cls
set input=error
echo  ------------------------------------------------------------------------------
echo  Current Project: %capp%
echo  Adb: %adbwifi% ^| Remount Available: %remountavlible% ^| Sounds: %sound2% 
echo  Apktool:%apktool% ^| Compression Level: %usrc% ^| Mem: %heapy%mb
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Permissions Menu
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  -    What file would you like to set?
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Example: /system/app/Email.apk
echo.
%~dp0tools\Apps\chgcolor %bg%
set /P input=Type input: %=%
echo.
set file=%input%
if %input% EQU 99 goto restart
%~dp0tools\Apps\chgcolor %high%
echo  What permissions would you like to give it?
set input=error
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  Common Permssions
%~dp0tools\Apps\chgcolor %high%
echo.
echo 755 for /system/etc/init.d/  rwxr-xr-x
echo 755 for /system/bin/  rwxr-xr-x
echo 644 for /system/app/  rw-r--r--
echo 644 for /system/framework/  rw-r--r--
echo 644 for /data/app/  rw-r--r--
echo 777 for full permissions  rwxrwxrwx
echo.
%~dp0tools\Apps\chgcolor %bg%
set /P input=Enter a Number: %=%
%~dp0tools\adb.exe shell chmod %input% %file%
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Permission %input% was set on %file%
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
PAUSE
goto restart
																				::OPEN MD5CHECKER
:md5checker
::DO NOT REMOVE
start %~dp0tools\Apps\Md5Checker.exe
goto restart
																				::OPEN ANDROID SDK
:andsdk
set /p sdklocation=<%~dp0tools\Settings\sdk_location.txt
if exist "%sdklocation%" (
	"%sdklocation%\SDK Manager.exe"
	goto restart
)
if exist "C:\Program Files (x86)\Android\android-sdk" (
	"C:\Program Files (x86)\Android\android-sdk\SDK Manager.exe"
	goto restart
)
if exist "C:\Program Files\Android\android-sdk" (
	"C:\Program Files\Android\android-sdk\SDK Manager.exe"
	goto restart
)
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  Android-sdk was not found at 
echo.
echo %sdklocation%
echo  or at C:\Program Files ^(x86^)\Android\android-sdk
echo  or at C:\Program Files\Android\android-sdk
echo.
echo  Install the Android-SDK to open an emulator
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
if %sound%==0 goto skipbeep7
start /min %~dp0tools\beep.bat
:skipbeep7
PAUSE
goto restart
																				::OPEN DDMS
:ddms
set /p sdklocation=<%~dp0tools\Settings\sdk_location.txt
if exist "%sdklocation%" (
	start cmd.exe /c "%sdklocation%\tools\monitor.bat"
	goto restart
)
if exist "C:\Program Files (x86)\Android\android-sdk" (
	start cmd.exe /c "C:\Program Files (x86)\Android\android-sdk\tools\monitor.bat"
	goto restart
)
if exist "C:\Program Files\Android\android-sdk" (
	start cmd.exe /c "C:\Program Files (x86)\Android\android-sdk\tools\monitor.bat"
	goto restart
)
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  Android-sdk was not found at 
echo.
echo %sdklocation%
echo  or at C:\Program Files ^(x86^)\Android\android-sdk
echo  or at C:\Program Files\Android\android-sdk
echo.
echo  Install the Android-SDK to open an emulator
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
if %beep%==Off goto skipbeep8
start /min %~dp0tools\beep.bat
:skipbeep8
PAUSE
goto restart
																				::DEODEX MENU
:setapi
set input=error
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto deodexmenu
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to deodex?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
:deodexmenu
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  What api level is your ROM?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  17   [Jelly Bean 4.2]
echo  16   [Jelly Bean 4.1, 4.1.1, 4.1.2]
echo  15   [Ice Cream Sandwich 4.0.3, 4.0.4]
echo  14   [Ice Cream Sandwich 4.0, 4.0.1, 4.0.2]
echo  13   [HoneyComb 3.2]
echo  12   [HoneyComb 3.1.x]
echo  11   [HoneyComb 3.0.x]
echo  10   [Gingerbread 2.3.3, 2.3.4]
echo   9   [Gingerbread 2.3, 2.3.1. 2.3.2]
echo   8   [Froyo 2.2.x]
echo   7   [Eclair 2.1.x]
echo   6   [Eclair 2.0.1]
echo   5   [Eclair 2.0]
echo   4   [Donut 1.6]
echo   3   [Cupcake 1.5]
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
set /P input=Enter a choice:
echo.
if %input% EQU 99 goto restart
if %input% GTR 17 goto what
if %input% LSS 3 goto what
echo %input% > %~dp0tools\Settings\api.txt
set api=%input%
if %signleodex% EQU 1 goto  singledeodex
goto deodexrom
goto what
																				::ODEX ROM WARNING
:odexwarning
cls
set input=error
echo.
echo.
%~dp0tools\Apps\chgcolor %err%
echo      WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %err%
echo  Have a good nand or backup before starting this process.
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  This will odex your currently installed ROM.
echo.
echo  This will take awhile to complete
echo  Your phone needs to be plugged into the PC for the entire process.
echo.
echo  Do you really want to do this?
echo.
echo  Type "backup" to make an nand backup and then odex the ROM
echo.
echo  ------------------------------------------------------------------------------
set /P input=Enter a choice [y/n/backup]:
echo.
if %input% EQU y goto odex
if %input% EQU n goto restart
if %input% EQU backup (
	set odexbackup=yes
	goto backupb4odex
)
goto what
																				::DEODEX ROM WARNING
:deodexwarning
cls
set input=error
echo.
echo.
%~dp0tools\Apps\chgcolor %err%
echo      WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
echo  This will deodex the ROM currently on your phone.
echo  This will not do anything to the phone. This process happens on the PC.
echo.
echo  After the process has finished you will be asked to make a flashable zip with
echo  the new files.
echo.
echo  This will take awhile to complete.
echo  Your phone needs to be plugged into the PC for the entire process.
echo.
echo  Do you really want to do this?
echo.
echo  ------------------------------------------------------------------------------
set /P input=Enter a choice [y/n]:
echo.
if %input% EQU y goto setapi
if %input% EQU n goto restart
goto what
																				::DEODEX ROM
:deodexrom
if exist %~dp0tools\logs\deodexlog.log del /q %~dp0tools\logs\deodexlog.log > NUL
if exist %~dp0tools\odex\odex\system\framework rd /s /q %~dp0tools\odex\odex\system\framework
mkdir %~dp0tools\odex\odex\system\framework
if exist %~dp0tools\odex\odex\system\app rd /s /q %~dp0tools\odex\odex\system\app
mkdir %~dp0tools\odex\odex\system\app
echo  Waiting for device
%~dp0tools\adb.exe wait-for-device > NUL
%~dp0tools\adb.exe -s %devicefinal% remount >%~dp0tools\logs\deodexlog.log
echo.
echo  Pulling the ROMs /system/app/ and /system/framework/ directories
echo  Please Wait...
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/ %~dp0tools\odex\odex\system\framework\
%~dp0tools\adb.exe -s %devicefinal% pull /system/app/ %~dp0tools\odex\odex\system\app\
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Starting the deodexing process please wait...
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
set baksmali="%~dp0tools\build\baksmali.jar"
set smali="%~dp0tools\build\smali.jar"
set zip="%~dp0tools\Apps\7za.exe"
set colorchange="%~dp0tools\Apps\chgcolor"
if exist %~dp0tools\odex\odex\out rd /s /q %~dp0tools\odex\odex\out >>%~dp0tools\logs\deodexlog.log
mkdir %~dp0tools\odex\odex\out >>%~dp0tools\logs\deodexlog.log
if exist %~dp0tools\odex\deodex\system\app rd /s /q %~dp0tools\odex\deodex\system\app >>%~dp0tools\logs\deodexlog.log
mkdir %~dp0tools\odex\deodex\system\app >>%~dp0tools\logs\deodexlog.log
if exist %~dp0tools\odex\deodex\system\framework rd /s /q %~dp0tools\odex\deodex\system\framework >>%~dp0tools\logs\deodexlog.log
mkdir %~dp0tools\odex\deodex\system\framework >>%~dp0tools\logs\deodexlog.log
%~dp0tools\Apps\chgcolor %high%
echo  Deodexing all /system/framework/ jars
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
set errors=0
if exist %~dp0tools\odex\errorfile.txt del /q %~dp0tools\odex\errorfile.txt > NUL
for %%F in (%~dp0tools\odex\odex\system\framework\*.apk) do move %%F %~dp0tools\odex\deodex\system\framework\ >>%~dp0tools\logs\deodexlog.log
for %%F in (%~dp0tools\odex\odex\system\framework\*.jar) do call %~dp0tools\odex\deodexjar %%F 0 %usrc% %api%
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Deodexing all /system/app/ apks
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
for %%F in (%~dp0tools\odex\odex\system\app\*.apk) do call %~dp0tools\odex\deodexapk %%F 0 %usrc% %api%
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Moving new deodexed files and cleaning up temp files
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
if exist %~dp0done\deodexed\system\app rd /s /q %~dp0done\deodexed\system\app >>%~dp0tools\logs\deodexlog.log
mkdir %~dp0done\deodexed\system\app >>%~dp0tools\logs\deodexlog.log
if exist %~dp0done\deodexed\system\framework rd /s /q %~dp0done\deodexed\system\framework >>%~dp0tools\logs\odexlog.log
mkdir %~dp0done\deodexed\system\framework >>%~dp0tools\logs\deodexlog.log
for %%F in (%~dp0tools\odex\deodex\system\framework\*.jar) do move %%F %~dp0done\deodexed\system\framework\ >>%~dp0tools\logs\deodexlog.log
for %%F in (%~dp0tools\odex\deodex\system\framework\*.apk) do move %%F %~dp0done\deodexed\system\framework\ >>%~dp0tools\logs\deodexlog.log
for %%F in (%~dp0tools\odex\deodex\system\app\*.apk) do move %%F %~dp0done\deodexed\system\app\ >>%~dp0tools\logs\deodexlog.log
if exist %~dp0tools\odex\odex\ rd /s /q %~dp0tools\odex\odex\ >>%~dp0tools\logs\deodexlog.log
if exist %~dp0tools\odex\deodex\ rd /s /q %~dp0tools\odex\deodex\ >>%~dp0tools\logs\deodexlog.log
echo.
set /p errors=<%~dp0tools\odex\error.txt
del /q %~dp0tools\odex\error.txt
if %errors% GTR 0 goto deodexerrors
echo %errors%
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Deodexing Complete!
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Would you like to make a CWM flashable zip of your new files?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
set /P input=Enter a choice [y/n]:
echo.
echo.
if %input% EQU y (
	set deodexromzip=1
	goto makezipdeodex	
)
echo.
cls
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Your new deodexed files are located at:
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  %~dp0done\deodexed\
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::DEODEX ERRORS
:deodexerrors
cls
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Deodexing Complete!
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  %errors% Error(s) occurred during the deodexing process
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Please check the error log located at:
echo  %~dp0tools\odex\errorfile.txt
echo. 
echo  Would you like to view the log now?
echo. 
echo  ------------------------------------------------------------------------------
set /P input=Enter a choice [y/n]:
if %input% EQU y goto viewerrorlog
goto restart
																				::VIEW DEODEX ERRORS
:viewerrorlog
start %~dp0tools\Apps\Notepad++\notepad++.exe %~dp0tools\odex\errorfile.txt
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Would you still like to make a CWM flashable zip of your new files?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set /P input=Enter a choice [y/n]:
echo.
echo.
if %input% EQU y (
	set deodexromzip=1
	goto makezipdeodex	
)
goto restart
																				::ZIP DEODEX FILES
:zipdeodexed
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set hour=%time:~0,2%
if /I %hour% LSS 9 set hour=0%time:~1,1%
set min=%time:~3,2%
set file=%month%.%day%.%year%_%hour%.%min%
cls
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Zipping your new deodexed fIles
echo.
echo  Please wait...
%~dp0tools\Apps\chgcolor %bg%
echo.
copy /y %~dp0done\deodexed\system\app\* %~dp0tools\cwm\system\app\ > NUL
copy /y %~dp0done\deodexed\system\framework\* %~dp0tools\cwm\system\framework\ > NUL
copy /y %~dp0tools\flash_scripts\run\deodex\run.sh %~dp0tools\cwm\tools\ > NUL
%~dp0tools\Apps\7za.exe a %~dp0done\flashable\Deodexed-%file%-CWM.zip %~dp0tools\cwm\* > NUL
del /q %~dp0tools\cwm\system\framework\* > NUL
del /q %~dp0tools\cwm\system\app\* > NUL
del /q %~dp0tools\cwm\tools\* > NUL
%~dp0tools\Apps\chgcolor %high%
echo  Your new CWM Zip file is located at: 
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
echo %~dp0done\flashable\Deodexed-%file%-CWM.zip
echo. 
echo. 
%~dp0tools\Apps\chgcolor %high%
echo  Your new deodexed files are located at: 
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
echo %~dp0done\deodexed\
echo.
PAUSE
goto restart
																				::CHOOSE DEODEX SINGLE FILE
:singledeodex
cls
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  What do you want to deodex?
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
echo Example: C:\something.apk
set /P input=Type file location or drag file here: %=%
if exist %~dp0tools\logs\deodexlog.log del /q %~dp0tools\logs\deodexlog.log > NUL
if not exist %~dp0tools\odex\odex\system\app\ mkdir %~dp0tools\odex\odex\system\app
if not exist %~dp0tools\odex\odex\system\framework\ mkdir %~dp0tools\odex\odex\system\framework
for %%i in (%input%) do set isjar="%%~xi"
if %isjar%==".jar" (
	copy /y %input% %~dp0tools\odex\odex\system\framework\
	set filetoodex=%input%
	copy /y %input:~0,-4%.odex %~dp0tools\odex\odex\system\framework
	echo %input%>%~dp0tools\odex\sigledeodexinput.txt
	goto filemoved
)
copy /y %input% %~dp0tools\odex\odex\system\app\
copy /y %input:~0,-4%.odex %~dp0tools\odex\odex\system\app\
echo %input%>%~dp0tools\odex\sigledeodexinput.txt
:filemoved
for /f "tokens=1,* delims=\" %%A in (%~dp0tools\odex\sigledeodexinput.txt) do (
	set capptemp=%capp%
	set capp=%%~nxB
)
del /q %~dp0tools\odex\sigledeodexinput.txt
																				::DEODEX SINGLE FILE
:deodexsomething
cls
set input=error
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto deodexsingledevice
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to use to deodex?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
::DO NOT REMOVE
:deodexsingledevice
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Getting required information from your phone
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe -s %devicefinal% pull /init.rc %~dp0tools\odex\init.rc
findstr "BOOTCLASSPATH" %~dp0tools\odex\init.rc > %~dp0tools\Settings\bootclass.txt
set /p bootclass=<%~dp0tools\Settings\bootclass.txt
set bootclass=%bootclass:~25%
del /q %~dp0tools\Settings\bootclass.txt
echo %bootclass%>%~dp0tools\Settings\bootclass.txt
:looppull
if "%bootclass%"==""  (
	goto :skiplooppull
) else (
	set bootclasspath=%~dp0tools\Settings\bootclass.txt
	for /f "tokens=1,* delims=:" %%a in (%bootclasspath%) do (
	set new=%%a
	set pullodex=!new:~0,-4!.odex
	%~dp0tools\adb.exe -s %devicefinal% pull %new% %~dp0tools\odex\odex\system\framework
	%~dp0tools\adb.exe -s %devicefinal% pull %pullodex% %~dp0tools\odex\odex\system\framework
	del /q %~dp0tools\Settings\bootclass.txt
	echo %%b>%~dp0tools\Settings\bootclass.txt
	set bootclass=%%b
	)
)
goto looppull
:skiplooppull
for %%i in (%filetoodex%) do set isjar="%%~xi"
if %isjar%==".jar" (
	copy /y %filetoodex% %~dp0tools\odex\odex\system\framework\
	set filetoodex=%input%
	copy /y %filetoodex:~0,-4%.odex %~dp0tools\odex\odex\system\framework
	goto filemovednow
)
echo.
:filemovednow	
if exist %~dp0tools\Settings\bootclass.txt del /q %~dp0tools\Settings\bootclass.txt
if exist %~dp0tools\odex\init.rc del /q %~dp0tools\odex\init.rc
set isjar=error
set baksmali="%~dp0tools\build\baksmali.jar"
set smali="%~dp0tools\build\smali.jar"
set zip="%~dp0tools\Apps\7za.exe"
set colorchange="%~dp0tools\Apps\chgcolor"
for %%i in (%~dp0tools\odex\odex\system\framework\%capp%) do set isjar="%%~xi"
if %isjar%==".jar" goto singleodexajar
call %~dp0tools\odex\deodexapk %capp% 0 %usrc% %api%
move %~dp0tools\odex\deodex\system\app\%capp% %~dp0done\unsigned%capp% > NUL
goto odexsingledone
:singleodexajar
call %~dp0tools\odex\deodexjar %capp% 0 %usrc% %api%
move %~dp0tools\odex\deodex\system\framework\%capp% %~dp0done\unsigned%capp% > NUL
:odexsingledone
if exist %~dp0tools\odex\odex\system\app\ rd /s /q %~dp0tools\odex\odex\system\app\
if exist %~dp0tools\odex\odex\system\framework\ rd /s /q %~dp0tools\odex\odex\system\framework\
echo. 
%~dp0tools\Apps\chgcolor %high%
echo  Your new deodexed file is located at: 
%~dp0tools\Apps\chgcolor %bg%
echo.
echo %~dp0done\unsigned%capp%
echo.
echo.
set capp=%capptemp%
PAUSE
goto restart
																				::ERROR ALREADY ODEXED APPS
:odexedapps
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo  Error    Error    Error    Error    Error    Error    Error    Error    Error
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your ROM already has odexed system apps
echo.
echo  You can not odex this ROM.
echo.
echo  You can deodex your ROM and then try again. 
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
:odexedframework
%~dp0tools\adb.exe -s %devicefinal% shell "ls /system/app/*.apk | xargs -n 1 basename">%~dp0tools\odex\apps.txt
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %err%
echo      WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your ROM already has an odexed framework
echo.
echo  Would you like to odex the /system/app dir [y/n]? 
echo.
echo  ------------------------------------------------------------------------------
echo.
set /P input=Make your choice: %=%
if %input%==n goto restart
goto odexjustapps
																				::ODEX AFTER NAND
:nanddoneodex
echo  Wait for you phone...
%~dp0tools\adb.exe wait-for-device
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
echo.
echo  Phone found waiting 60 seconds to allow the phone to finish booting
echo  Please wait...
ping -n 60 127.0.0.1 > nul
																				::ODEX ROM
:odex
cls
%~dp0tools\adb.exe wait-for-device
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set input=error
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto odexsingle
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to odex?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::ODEX ROM [GET BOOTCLASSPATH AND PUSH NEEDED FILES]
:odexsingle
if exist %~dp0tools\Settings\odexedapps.txt del /q %~dp0tools\Settings\odexedapps.txt
if exist %~dp0tools\Settings\appsoutput.txt del /q %~dp0tools\Settings\appsoutput.txt
%~dp0tools\adb.exe -s %devicefinal% shell ls -l /system/app/*odex > %~dp0tools\Settings\odexedapps.txt
for /f %%C in ('Find /V /C "" ^< %~dp0tools\Settings\odexedapps.txt') do set count=%%C
if exist %~dp0tools\Settings\odexedapps.txt del /q %~dp0tools\Settings\odexedapps.txt
if %count% GTR 1 goto odexedapps
%~dp0tools\adb.exe -s %devicefinal% pull /init.rc %~dp0tools\odex\init.rc
findstr "BOOTCLASSPATH" %~dp0tools\odex\init.rc > %~dp0tools\Settings\bootclass.txt
set /p bootclass=<%~dp0tools\Settings\bootclass.txt
set bootclass=%bootclass:~25%
set /p classpath=<%~dp0tools\Settings\bootclass.txt
set classpath=%classpath:~25%
del /q %~dp0tools\Settings\bootclass.txt
echo %bootclass%>%~dp0tools\Settings\bootclass.txt
if exist %~dp0tools\odex\init.rc del /q %~dp0tools\odex\init.rc > NUL
cls
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Getting needed information from your phone.
echo  Do not unplug your phone until the odexing process has finished.
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo  Please wait...
%~dp0tools\adb.exe -s %devicefinal% shell mkdir /sdcard/odex>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/odex/framework/>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell mkdir /sdcard/odex/framework>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/odex/app/>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell mkdir /sdcard/odex/app>>%~dp0tools\logs\odexlog.log
if exist %~dp0done\odexed\system\framework\ rd /s /q %~dp0done\odexed\system\framework\ > NUL
mkdir %~dp0done\odexed\system\framework\ > NUL
if exist %~dp0done\odexed\system\app\ rd /s /q %~dp0done\odexed\system\app\ > NUL
mkdir %~dp0done\odexed\system\app\ > NUL
if exist %~dp0tools\logs\odexlog.log  del /q %~dp0tools\logs\odexlog.log > NUL
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Pushing needed tools to your phone.
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\dexopt-wrapper /system/bin/>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zip /system/bin/>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zipalign /system/bin/>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/dexopt-wrapper>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zip>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zipalign>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /data/dalvik-cache/system@app@*.dex>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /data/dalvik-cache/system@framework@*.dex>>%~dp0tools\logs\odexlog.log
echo.
																				::ODEX ROM [ODEXING BOOTCLASSPATH]
%~dp0tools\adb.exe -s %devicefinal% shell ls -l /system/framework/*odex > %~dp0tools\Settings\odexedframework.txt
for /f %%C in ('Find /V /C "" ^< %~dp0tools\Settings\odexedframework.txt') do set count=%%C
if exist %~dp0tools\Settings\odexedframework.txt del /q %~dp0tools\Settings\odexedframework.txt
if %count% GTR 1 goto odexedframework
%~dp0tools\Apps\chgcolor %high%
echo  Odexing Bootclasspath jars
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
::DO NOT REMOVE
:loop
if "%bootclass%"==""  (
	goto :skip
) else (
	set bootclasspath=%~dp0tools\Settings\bootclass.txt
	for /f "tokens=1,* delims=:" %%A in (%bootclasspath%) do (
		set bootjar=%%A
		set bootjar2=!bootjar:~18!
		echo Odexing !bootjar2:~0,-4!.jar
		echo Odexing !bootjar2:~0,-4!.jar with the command:>>%~dp0tools\logs\odexlog.log
		echo %~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper %%A /system/framework/!bootjar2:~0,-4!.odex %classpath%>>%~dp0tools\logs\odexlog.log
		echo.>>%~dp0tools\logs\odexlog.log
		echo DEXOPT-WRAPPER OUTPUT:>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper %%A /system/framework/!bootjar2:~0,-4!.odex %classpath%>>%~dp0tools\logs\odexlog.log
		echo Copying /system/framework/!bootjar2:~0,-4!.jar to /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell cp /system/framework/!bootjar2:~0,-4!.jar /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar>>%~dp0tools\logs\odexlog.log
		echo Removing classes.dex from /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar classes.dex>>%~dp0tools\logs\odexlog.log
		echo zipaligning /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar /sdcard/odex/framework/!bootjar2:~0,-4!.jar>>%~dp0tools\logs\odexlog.log
		echo Copying /sdcard/odex/framework/!bootjar2:~0,-4!.jar  to /system/framework/!bootjar2:~0,-4!.jar>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell cp -rf /sdcard/odex/framework/!bootjar2:~0,-4!.jar /system/framework/!bootjar2:~0,-4!.jar>>%~dp0tools\logs\odexlog.log
		echo Removing Temp file: /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/odex/framework/!bootjar2:~0,-4!-temp.jar>>%~dp0tools\logs\odexlog.log
		del /q %~dp0tools\Settings\bootclass.txt
		echo %%B>%~dp0tools\Settings\bootclass.txt
		set bootclass=%%B
		echo.>>%~dp0tools\logs\odexlog.log
		echo.>>%~dp0tools\logs\odexlog.log
	)
)
goto loop
::DO NOT REMOVE
:skip
echo.
echo  Pulling new bootclass odex files
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/ %~dp0done\odexed\system\framework\>>%~dp0tools\logs\odexlog.log
del /q %~dp0done\odexed\system\framework\*.jar>>%~dp0tools\logs\odexlog.log
del /q %~dp0tools\Settings\bootclass.txt>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell "ls /system/framework/*.jar | xargs -n 1 basename">%~dp0tools\odex\items.txt
echo.
																				::ODEX ROM [ODEXING REMAINING FRAMEWORK JARS]
%~dp0tools\Apps\chgcolor %high%
echo  Odexing /system/framework jars
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
for /f "tokens=* delims= " %%A in (%~dp0tools\odex\items.txt) do (
	set app=%%A
	set app2=!app:~0,100!
	if exist "%~dp0done\odexed\system\framework\!app2:~0,-5!.odex" (
		echo Skipping !app2:~0,-5!.jar [Bootclass file]
		echo Skipping !app2:~0,-5!.jar [Bootclass file Already Done]>>%~dp0tools\logs\odexlog.log
	) else (
		echo Odexing !app2:~0,-1!
		echo Odexing !app2:~0,-1! with the command:>>%~dp0tools\logs\odexlog.log
		echo %~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper '/system/framework/!app2:~0,-1!' '/system/framework/!app2:~0,-5!.odex'>>%~dp0tools\logs\odexlog.log
		echo.>>%~dp0tools\logs\odexlog.log
		echo DEXOPT-WRAPPER OUTPUT:>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper '/system/framework/!app2:~0,-1!' '/system/framework/!app2:~0,-5!.odex'>>%~dp0tools\logs\odexlog.log
		echo Copying /system/framework/!app2:~0,-1!  to /sdcard/odex/framework/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell cp -rf /system/framework/!app2:~0,-1! /sdcard/odex/framework/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		echo Removing classes.dex from /sdcard/odex/framework/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/odex/framework/Temp-!app2:~0,-1! classes.dex>>%~dp0tools\logs\odexlog.log
		echo zipaligning /sdcard/odex/framework/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/odex/framework/Temp-!app2:~0,-1! /sdcard/odex/framework/!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		echo Copying %~dp0tools\adb.exe -s %devicefinal% to cp /sdcard/odex/framework/!app2:~0,-1! /system/framework/!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell cp -rf /sdcard/odex/framework/!app2:~0,-1! /system/framework/!app2:~0,-1!>>%~dp0tools\logs\odexlog.log		
		echo Removing Temp file: /sdcard/odex/framework/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/odex/framework/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
		echo.>>%~dp0tools\logs\odexlog.log
		echo.>>%~dp0tools\logs\odexlog.log
	)
)
																				::ODEX ROM [ODEXING SYSTEM APPS]
:odexjustapps
%~dp0tools\Apps\chgcolor %high%
echo  Odexing /system/app apks
echo  Your phone may hot reboot a few times. It will be fine.
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\adb.exe -s %devicefinal% shell "ls /system/app/*.apk | xargs -n 1 basename">%~dp0tools\odex\apps.txt
for /f "tokens=* delims= " %%A in (%~dp0tools\odex\apps.txt) do (
	set app=%%A
	set app2=!app:~0,100!
	echo  Odexing !app2:~0,-1!
	echo  Odexing !app2:~0,-1! with the command:>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe wait-for-device>>%~dp0tools\logs\odexlog.log
	echo %~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper '/system/app/!app2:~0,-1!' '/system/app/!app2:~0,-5!.odex'>>%~dp0tools\logs\odexlog.log
	echo.>>%~dp0tools\logs\odexlog.log
	echo  DEXOPT-WRAPPER OUTPUT:>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper '/system/app/!app2:~0,-1!' '/system/app/!app2:~0,-5!.odex'>>%~dp0tools\logs\odexlog.log
	echo  Copying /system/app/!app2:~0,-1! to /sdcard/odex/app/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe -s %devicefinal% shell cp -rf /system/app/!app2:~0,-1! /sdcard/odex/app/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	echo  Removing classes.dex from /sdcard/odex/app/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/odex/app/Temp-!app2:~0,-1! classes.dex>>%~dp0tools\logs\odexlog.log
	echo  zipaligning /sdcard/odex/app/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/odex/app/Temp-!app2:~0,-1! /sdcard/odex/app/!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	echo  Copying /sdcard/odex/app/!app2:~0,-1! to /system/app/!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe -s %devicefinal% shell cp -rf /sdcard/odex/app/!app2:~0,-1! /system/app/!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	echo  Removing Temp file: /sdcard/odex/app/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/odex/app/Temp-!app2:~0,-1!>>%~dp0tools\logs\odexlog.log
	echo.>>%~dp0tools\logs\odexlog.log
	echo.>>%~dp0tools\logs\odexlog.log
)
echo.
																				::ODEX ROM [CLEANING UP]
echo  Cleaning up
if exist %~dp0tools\Settings\odexedapps.txt del /q %~dp0tools\Settings\odexedapps.txt
if exist %~dp0tools\Settings\appsoutput.txt del /q %~dp0tools\Settings\appsoutput.txt
if exist %~dp0tools\Settings\odexedframework.txt del /q %~dp0tools\Settings\odexedframework.txt
if exist %~dp0tools\Settings\frameworkoutput.txt del /q %~dp0tools\Settings\frameworkoutput.txt
if exist %~dp0tools\odex\items.txt del /q %~dp0tools\odex\items.txt > NUL
if exist %~dp0tools\odex\apps.txt del /q %~dp0tools\odex\apps.txt > NUL
%~dp0tools\adb.exe -s %devicefinal% pull /system/app/ %~dp0done\odexed\system\app\>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/ %~dp0done\odexed\system\framework\>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/odex>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/dexopt-wrapper>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/zip>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/zipalign>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /data/dalvik-cache/system@app@*.dex>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /data/dalvik-cache/system@framework@*.dex>>%~dp0tools\logs\odexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod -R 644 /system/framework/*.*>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod -R 644 /system/app/*.*>>%~dp0tools\logs\reodexlog.log
echo.
%~dp0tools\Apps\chgcolor %high%
echo  Odexing complete, Your phone will now reboot.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\adb.exe -s %devicefinal% reboot
PAUSE
goto restart
																				::RE-ODEX IF STARTED ODEXED JAR
:reodexjar
cls
set input=error
echo.
%~dp0tools\Apps\chgcolor %err%
echo      WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  ------------------------------------------------------------------------------
echo.
echo   Re-odexing Jar files is done on the phone in the /framework dir
echo.
echo   Your phone must already be odexed and the original version of
echo   your project must be in the /system/framework/ directory
echo. 
echo   The newly odexed file will be running on the phone when this process 
echo   is complete.
echo.
echo   Make sure you have a good backup before you continue
echo   Are you sure you want to do this?
echo.
echo  ------------------------------------------------------------------------------
echo.
set /P input=Enter a choice [y/n]:
echo.
if %input% EQU y goto continue
if %input% EQU n goto restart
:continue
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
cls
set input=error
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto reodexsinglejar
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to use to odex %capp%?
%~dp0tools\Apps\chgcolor %bg%
echo.
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::RE-ODEX SINGLE JAR
:reodexsinglejar
%~dp0tools\adb.exe -s %devicefinal% pull /init.rc %~dp0tools\odex\init.rc
findstr "BOOTCLASSPATH" %~dp0tools\odex\init.rc > %~dp0tools\Settings\bootclass.txt
set /p bootclass=<%~dp0tools\Settings\bootclass.txt
set bootclass=%bootclass:~25%
set /p classpath=<%~dp0tools\Settings\bootclass.txt
set classpath=%classpath:~25%
del /q %~dp0tools\Settings\bootclass.txt
echo %bootclass%>%~dp0tools\Settings\bootclass.txt
if exist %~dp0tools\odex\init.rc del /q %~dp0tools\odex\init.rc > NUL
cls
echo.
echo  Re-Odexing %capp%
echo.
set odexfile=!capp:~0,-4!.odex
set moddedodexfile=!capp:~0,-4!_modded.odex
echo  Pushing needed tools to the phone...>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\dexopt-wrapper /system/bin/>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zip /system/bin/>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zipalign /system/bin/>>%~dp0tools\logs\reodexlog.log
echo  Setting permissions for new tools...>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/dexopt-wrapper>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zip>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zipalign>>%~dp0tools\logs\reodexlog.log
echo  Pushing the newly compiled deodexed %capp%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\unsigned%capp% /system/framework/%capp%
echo %~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper /system/framework/%capp% /system/framework/%moddedodexfile% %classpath%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper /system/framework/%capp% /system/framework/%moddedodexfile% %classpath%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell busybox dd if=/system/framework/%odexfile% of=/system/framework/%moddedodexfile% bs=1 count=20 skip=52 seek=52 conv=notrunc>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /q /system/framework/%odexfile%
%~dp0tools\adb.exe -s %devicefinal% shell mv -f /system/framework/%moddedodexfile% /system/framework/%odexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell zip -d /system/framework/%capp% classes.dex>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /system/framework/%capp% /system/framework/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell mv -f /system/framework/Temp-%capp% /system/framework/%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod -R 644 /system/framework/*.*>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/%capp% %~dp0done\%capp%
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/%odexfile% %~dp0done\%odexfile%
cls
echo.
echo  ------------------------------------------------------------------------------
echo.
%~dp0tools\Apps\chgcolor %high%
echo   Jar file has been odexed.
%~dp0tools\Apps\chgcolor %bg%
echo.
echo   Your newly created odexed files are located at:
echo.
echo   %~dp0done\%capp%
echo   %~dp0done\%odexfile%
echo.
echo  Reboot your phone to make sure the new file works.
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::RE-ODEX IF STARTED ODEXED APK
:reodex
set input=error
for %%F in (place-here-for-modding/*) do (
	if "%%~xF" NEQ ".odex" set /A count+=1
	if "%%~xF" NEQ ".odex" set a!count!=%%F
	if /I !count! LSS 10 if "%%~xF" NEQ ".odex" echo   !count!   %%F
	if /I !count! GTR 9  if "%%~xF" NEQ ".odex" echo   !count!  %%F 
)
for %%i in (%capp%) do (
	if "%%~xi" EQU ".jar" (
		cls
		echo.
		echo  ------------------------------------------------------------------------------
		echo.
		%~dp0tools\Apps\chgcolor %high%
		echo   Jar files will not be odexed automatically.
		%~dp0tools\Apps\chgcolor %bg%
		echo.
		echo   Your newly created deodexed file is located at:
		echo.
		echo   %~dp0done\unsigned%capp%
		echo.
		%~dp0tools\Apps\chgcolor %high%
		echo   Use the odex menu to reodex it. 
		echo   Option 23
		%~dp0tools\Apps\chgcolor %bg%
		echo.
		echo  ------------------------------------------------------------------------------
		echo.
		PAUSE
		goto restart
	)
	cls
	set /A count=0
	for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
		set tempvar=%%a
		set /A count+=1
		set a!count!=%%a
		set devicefinal=!tempvar:~0,-7!
	)
	if /I !count! LSS 2 goto reodexsingle
)
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to use to odex %capp%?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::RE-ODEX SINGLE DEVICE APK
:reodexsingle
echo.
echo  Re-Odexing %capp%
echo.
set odexfile=!capp:~0,-4!.odex
set moddedodexfile=!capp:~0,-4!_modded.odex
echo  Pushing needed tools to the phone...>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\dexopt-wrapper /system/bin/>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zip /system/bin/>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zipalign /system/bin/>>%~dp0tools\logs\reodexlog.log
echo  Setting permissions for new tools...>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/dexopt-wrapper>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zip>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zipalign>>%~dp0tools\logs\reodexlog.log
echo  Pushing the newly compiled deodexed %capp% and the original %odexfile%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0place-here-for-modding\%odexfile% /sdcard/>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0done\unsigned%capp% /sdcard/%capp%>>%~dp0tools\logs\reodexlog.log
echo  Running the commands:>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper /sdcard/%capp% /sdcard/%moddedodexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper /sdcard/%capp% /sdcard/%moddedodexfile%>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell busybox dd if=/sdcard/%odexfile% of=%moddedodexfile% bs=1 count=20 skip=52 seek=52 conv=notrunc>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell busybox dd if=/sdcard/%odexfile% of=/sdcard/%moddedodexfile% bs=1 count=20 skip=52 seek=52 conv=notrunc>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/%capp% classes.dex>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/%capp% classes.dex>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/%capp% /sdcard/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/%capp% /sdcard/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
echo  Deleting %~dp0done\%odexfile% and %~dp0done\%capp%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
del /q %~dp0done\%odexfile%
del /q %~dp0done\%capp%
echo  Pulling finished files>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% pull /sdcard/%moddedodexfile% %~dp0done\%odexfile%>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% pull /sdcard/Temp-%capp% %~dp0done\%capp%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% pull /sdcard/%moddedodexfile% %~dp0done\%odexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% pull /sdcard/Temp-%capp% %~dp0done\%capp%>>%~dp0tools\logs\reodexlog.log
echo  Cleaning Temp files>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/%moddedodexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/%odexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/dexopt-wrapper>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/zip>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/zipalign>>%~dp0tools\logs\reodexlog.log
cls
echo. 
%~dp0tools\Apps\chgcolor %high%
echo  Your new odexed files are located at: 
%~dp0tools\Apps\chgcolor %bg%
echo.
echo %~dp0done\%odexfile%
echo %~dp0done\%capp%
echo.
echo.
%~dp0tools\Apps\chgcolor %high%
echo  The deodexed version is located at: 
%~dp0tools\Apps\chgcolor %bg%
echo.
echo %~dp0done\unsigned%capp%
echo.
echo.
PAUSE
goto restart
																				::ODEX CHOOSE SIGLE APK
:reodexchoose
cls
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  This allow you to odex a single apk file:
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Odex %capp%
echo  2    Odex Another File
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  99   Go Back
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
set input=error
set /P input=Please Make A Choice: %=%
if %input%==1 goto odexcapp
if %input%==2 goto odexwhat
if %input%==99 goto restart
goto what
:odexwhat
echo.
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  What apk do you want to odex?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Example: C:\something.apk
set /P input=Type input: %=%
copy /y %input% %~dp0place-here-for-modding > NUL
echo %input%>%~dp0tools\odex\sigleodexinput.txt
for /f "tokens=1,* delims=\" %%A in (%~dp0tools\odex\sigleodexinput.txt) do (
	set capptemp=%capp%
	set capp=%%~nxB
)
del /q %~dp0tools\odex\sigleodexinput.txt > NUL
goto odexsomething
:odexcapp
set capptemp=%capp%
:odexsomething
set input=error
for %%i in (%capp%) do (
	if "%%~xi" EQU ".jar" (
		set capp=%capptemp%
		goto reodexjar
	)
	cls
	set /A count=0
	for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
		set tempvar=%%a
		set /A count+=1
		set a!count!=%%a
		set devicefinal=!tempvar:~0,-7!
	)
	if /I !count! LSS 2 goto reodexsingle
)
:reodexmultiple
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to use to odex %capp%?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::ODEX SINGLE DEVICE SINGLE APK
:reodexsingle
echo.
echo  Odexing %capp%
echo.
set odexfile=!capp:~0,-4!.odex
echo  Pushing needed tools to the phone...>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% remount > NUL
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\dexopt-wrapper /system/bin>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zip /system/bin>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0tools\odex\zipalign /system/bin>>%~dp0tools\logs\reodexlog.log
echo  Setting permissions for new tools...>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/dexopt-wrapper>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zip>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell chmod 755 /system/bin/zipalign>>%~dp0tools\logs\reodexlog.log
echo  Pushing the %capp% to the phone>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% push %~dp0place-here-for-modding\%capp% /sdcard/%capp%>>%~dp0tools\logs\reodexlog.log
echo  Running the commands:>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper /sdcard/%capp% /sdcard/%odexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell dexopt-wrapper /sdcard/%capp% /sdcard/%odexfile%>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/%capp% classes.dex>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell zip -d /sdcard/%capp% classes.dex>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/%capp% /sdcard/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell zipalign -f 4 /sdcard/%capp% /sdcard/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
echo  Deleting %~dp0done\%odexfile% and %~dp0done\%capp%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
if exist %~dp0done\%odexfile% del /q %~dp0done\%odexfile%
if exist %~dp0done\%capp% del /q %~dp0done\%capp%
echo Pulling finished files>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% pull /sdcard/%odexfile% %~dp0done\%odexfile%>>%~dp0tools\logs\reodexlog.log
echo %~dp0tools\adb.exe -s %devicefinal% pull /sdcard/Temp-%capp% %~dp0done\%capp%>>%~dp0tools\logs\reodexlog.log
echo.>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% pull /sdcard/%odexfile% %~dp0done\%odexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% pull /sdcard/Temp-%capp% %~dp0done\%capp%>>%~dp0tools\logs\reodexlog.log
echo  Cleaning Temp files>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/Temp-%capp%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /sdcard/%odexfile%>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/dexopt-wrapper>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/zip>>%~dp0tools\logs\reodexlog.log
%~dp0tools\adb.exe -s %devicefinal% shell rm -rf /system/bin/zipalign>>%~dp0tools\logs\reodexlog.log
cls
echo. 
%~dp0tools\Apps\chgcolor %high%
echo  Your new odexed files are located at: 
%~dp0tools\Apps\chgcolor %bg%
echo.
echo %~dp0done\%odexfile%
echo %~dp0done\%capp%
echo.
echo.
set capp=%capptemp%
PAUSE
goto restart
																				::DECOMPILE ODEXED JAR
:decompileodexjar
cls
set input=error
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto decompileodexjarsingle
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to decompile %capp% with?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::DECOMPILE SINGLE DEVICE ODEXED JAR
:decompileodexjarsingle
echo.
%~dp0tools\Apps\chgcolor %high%
echo  I have noticed this is an odexed jar.
echo  I will now deodex and then decompile it for you.
echo.
echo  Please Wait...
%~dp0tools\Apps\chgcolor %bg%
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
echo.
echo  Getting some needed information from your phone. 
if not exist %~dp0tools\odex\originals mkdir %~dp0tools\odex\originals
if exist %~dp0tools\odex\originals\%capp% copy  /y %~dp0tools\odex\originals\%capp% %~dp0place-here-for-modding\%capp% > NUL
if exist %~dp0tools\odex\odex\system\framework rd /s /q %~dp0tools\odex\odex\system\framework > NUL
mkdir %~dp0tools\odex\odex\system\framework\ > NUL
if exist %~dp0tools\odex\odex\system\app rd /s /q %~dp0tools\odex\odex\system\app > NUL
mkdir %~dp0tools\odex\odex\system\app\ > NUL
if exist %~dp0tools\odex\deodex\system\app rd /s / q%~dp0tools\odex\deodex\system\app > NUL
mkdir %~dp0tools\odex\deodex\system\app > NUL
if exist %~dp0tools\odex\deodex\system\framework rd /s /q %~dp0tools\odex\deodex\system\framework > NUL
mkdir %~dp0tools\odex\deodex\system\framework > NUL
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/ %~dp0tools\odex\odex\system\framework\ > NUL
copy  /y %~dp0place-here-for-modding\%capp% %~dp0tools\odex\originals\%capp% > NUL
echo.
echo  Deodexing !capp:~0,-4!.jar...
if not exist %~dp0tools\odex\odex\out mkdir %~dp0tools\odex\odex\out > NUL
java -jar %~dp0tools\build\baksmali.jar -a %api% -x %~dp0place-here-for-modding\!capp:~0,-4!.odex -d %~dp0tools\odex\odex\system\framework -o %~dp0tools\odex\deodex\system\app\!capp:~0,-4!
if errorlevel 1 goto errorlog
java -jar %~dp0tools\build\smali.jar -a %api% %~dp0tools\odex\deodex\system\app\!capp:~0,-4! -o %~dp0tools\odex\odex\out\classes.dex
if errorlevel 1 goto errorlog
copy /y %~dp0place-here-for-modding\!capp:~0,-4!.jar %~dp0tools\odex\odex\system\app\!capp:~0,-4!.jar > NUL
%~dp0tools\Apps\7za.exe u -tzip %~dp0tools\odex\odex\system\app\!capp:~0,-4!.jar %~dp0tools\odex\odex\out\classes.dex -mx%usrc% > NUL
echo.
move %~dp0tools\odex\odex\system\app\!capp:~0,-4!.jar %~dp0place-here-for-modding\ > NUL
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Cleaning up temp files.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
if exist %~dp0tools\odex\odex\ rd /s /q %~dp0tools\odex\odex\ > NUL
if exist %~dp0tools\odex\deodex\ rd /s /q %~dp0tools\odex\deodex\ > NUL
set capp=!capp:~0,-4!.jar
::DO NOT REMOVE
goto decompilejarodex
::DO NOT REMOVE
goto errorlog
																				::DECOMPILE ALL ODEXED APKS [NOT WORKING YET]
:decompileodexapkall
cls
%~dp0tools\Apps\chgcolor %err%
echo.
echo  Batch Decompiling of odexed apks or jars is not supported yet.
echo.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
PAUSE
goto restart
																				::DECOMPILE ODEXED APK
:decompileodexapk
cls
set input=error
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	set devicefinal=!tempvar:~0,-7!
)
if /I !count! LSS 2 goto decompileodexapksingle
echo.
%~dp0tools\Apps\chgcolor %high%
echo  There are multiple devices plugged in. Which do you want to decompile %capp% with?
%~dp0tools\Apps\chgcolor %bg%
echo.
%~dp0tools\adb.exe devices>%~dp0tools\temp\adb.txt
set /A count=0
for /F "tokens=* skip=1 delims=" %%a in (%~dp0tools\temp\adb.txt) do (
	set tempvar=%%a
	set /A count+=1
	set a!count!=%%a
	echo !count! !tempvar:~0,-7!
	set devicefinal=%%a
)
echo.
set /P input=Enter It's Number: %=%
echo.
set device=!a%input%!
set devicefinal=%device:~0,-7%
																				::DECOMPILE ODEXED APK SINGLE DEVICE
:decompileodexapksingle
echo.
%~dp0tools\Apps\chgcolor %high%
echo  I have noticed this is an odexed apk.
echo  I will now deodex and then decompile it for you.
echo.
echo  Please Wait...
%~dp0tools\Apps\chgcolor %bg%
echo.
echo  Getting some needed information from your phone.
if not exist %~dp0tools\odex\originals mkdir %~dp0tools\odex\originals
if exist %~dp0tools\odex\originals\%capp% copy  /y %~dp0tools\odex\originals\%capp% %~dp0place-here-for-modding\%capp% > NUL
if exist %~dp0tools\odex\odex\system\framework rd /s /q %~dp0tools\odex\odex\system\framework > NUL
mkdir %~dp0tools\odex\odex\system\framework\ > NUL
if exist %~dp0tools\odex\odex\system\app rd /s /q %~dp0tools\odex\odex\system\app > NUL
mkdir %~dp0tools\odex\odex\system\app\ > NUL
if exist %~dp0tools\odex\deodex\system\app rd /s /q %~dp0tools\odex\deodex\system\app > NUL
mkdir %~dp0tools\odex\deodex\system\app > NUL
if exist %~dp0tools\odex\deodex\system\framework rd /s /q %~dp0tools\odex\deodex\system\framework > NUL
mkdir %~dp0tools\odex\deodex\system\framework > NUL
%~dp0tools\adb.exe -s %devicefinal% pull /system/framework/ %~dp0tools\odex\odex\system\framework\ > NUL
copy  /y %~dp0place-here-for-modding\%capp% %~dp0tools\odex\originals\%capp% > NUL
echo.
echo  Deodexing !capp:~0,-4!.apk...
if not exist %~dp0tools\odex\odex\out mkdir %~dp0tools\odex\odex\out > NUL
java -jar %~dp0tools\build\baksmali.jar -a %api% -x %~dp0place-here-for-modding\!capp:~0,-4!.odex -d %~dp0tools\odex\odex\system\framework -o %~dp0tools\odex\deodex\system\app\!capp:~0,-4!
if errorlevel 1 goto errorlog
java -jar %~dp0tools\build\smali.jar -a %api% %~dp0tools\odex\deodex\system\app\!capp:~0,-4! -o %~dp0tools\odex\odex\out\classes.dex
if errorlevel 1 goto errorlog
copy /y %~dp0place-here-for-modding\!capp:~0,-4!.apk %~dp0tools\odex\odex\system\app\!capp:~0,-4!.apk > NUL
%~dp0tools\Apps\7za.exe u -tzip %~dp0tools\odex\odex\system\app\!capp:~0,-4!.apk "%~dp0tools\odex\odex\out\classes.dex" -mx%usrc% > NUL
echo.
move %~dp0tools\odex\odex\system\app\!capp:~0,-4!.apk %~dp0place-here-for-modding\ > NUL
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  Cleaning up temp files.
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
if exist %~dp0tools\odex\odex\ rd /s /q %~dp0tools\odex\odex\ > NUL
if exist %~dp0tools\odex\deodex\ rd /s /q %~dp0tools\odex\deodex\ > NUL
set capp=!capp:~0,-4!.apk
goto decompileapkodex
goto errorlog
																				::ODEX INFORMATION
:odexinformation
cls 
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What is an odex file?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  An .odex file is an optimized Dalvik executable file, sort of like an .exe in
echo  windows. The .odex is compressed to save space, and contains bits and pieces
echo  of its .apk that are optimized before Android boots. This helps speed up the
echo  boot process and pre-loads parts of the application.
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  What is a deodex file?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Deodex it is not a file extension like .odex is, rather, apps that are
echo  deodexed are assembled in such a way that they are not pre-optimized and the
echo  bits that would have gone into a separate .odex file are put into classes.dex
echo  files and kept inside the .apk. 
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::FIRST OPEN SETTINGS
:firstopen
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  First Time Setup
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This is the first time you have opened the AIO. 
echo.
echo  Please take a few seconds and go through the initial setup wizard 
echo  This will setup the AIO^'s initial settings.
echo.
echo  If you set something that you do not like you can change all the settings 
echo  through the aio later as well.
echo.
echo  ------------------------------------------------------------------------------
echo.
echo  Press any key to start the setup. . .
PAUSE > NUL
set firstrun=on
goto apkverfirstrun
:setupdates
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Check for Udates?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Would you like the AIO to automatically check for updates?
echo.
echo  ------------------------------------------------------------------------------
SET /P input=Please make your decision [y/n]:
if %input% EQU y goto enableupdatefirstrun
if %input% EQU n goto disableupdatefirstrun
:firstrunbeep
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Enable Sounds?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Would you like the AIO to make noise?
echo.
echo  ------------------------------------------------------------------------------
SET /P input=Please make your decision [y/n]:
if %input% EQU y goto enablebeepfirstrun
if %input% EQU n goto disablebeepfirstrun
:settheme
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Set the AIO Colors
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  The AIO has 4 colors that you can change. 
echo.
echo  You can edit the main font color, the highlight color,
echo  The disabled menu color, and the error highlight color.
echo.
echo  ------------------------------------------------------------------------------
echo.
echo  Press any key to set the theme now. . .
PAUSE > NUL
goto theme
																				::XULTIMATE 9PATCHER
:xultimate
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Compile .9 pngs?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  This will compile all the .9 file inside of %~dp0dot9
echo  Would you like to continue?
echo.
echo  ------------------------------------------------------------------------------
SET /P input=Please make your decision [y/n]:
if %input% EQU y goto patchnine
if %input% EQU n goto restart
:patchnine
if exist %~dp0dot9\originals rd /s /q %~dp0dot9\originals > NUL
mkdir %~dp0dot9\originals\res\drawable-hdpi > NUL
if exist %~dp0done\dot9\ rd /s /q %~dp0done\dot9\ > NUL
mkdir %~dp0done\dot9\ > NUL
move %~dp0dot9\*.9.png %~dp0dot9\originals\res\drawable-hdpi\ > NUL
copy /y %~dp0tools\Apps\xUltimate-d9pc.exe %~dp0dot9 > NUL
cd %~dp0dot9
xUltimate-d9pc.exe
cd %~dp0
del /q %~dp0dot9\xUltimate-d9pc.exe > NUL
::rd /s /q %~dp0dot9\originals > NUL
move %~dp0dot9\*.png %~dp0done\dot9\ > NUL
move %~dp0dot9\done\originals\res\drawable-hdpi\* %~dp0done\dot9\ > NUL
rd /s /q %~dp0dot9\done\originals > NUL
rd /s /q %~dp0dot9\done > NUL
cls
echo.
echo  ------------------------------------------------------------------------------
%~dp0tools\Apps\chgcolor %high%
echo  .9 pngs Compile Finished
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  Your new files are located at 
echo  %~dp0done\dot9\
echo.
echo  ------------------------------------------------------------------------------
echo.
PAUSE
goto restart
																				::COLOR EDIT
:coloredit
cls
echo  ------------------------------------------------------------------------------
set input=error
%~dp0tools\Apps\chgcolor %high%
echo  Compile .9 pngs?
%~dp0tools\Apps\chgcolor %bg%
echo  ------------------------------------------------------------------------------
echo.
echo  1    Just open Color Edit
echo  2    Open %capp%'s colors.xml file
echo.
echo  ------------------------------------------------------------------------------
SET /P input=Please make your decision:
if %input%==1 start %~dp0tools\Apps\ColorEdit.exe
if %input%==2 start %~dp0tools\Apps\ColorEdit.exe %~dp0projects\%capp%\res\values\colors.xml
goto restart
																				::EXIT THE AIO
:leave
echo Exiting ADB
tasklist /FI "IMAGENAME eq adb.exe" | find /I /N "adb.exe" > NUL
if "%ERRORLEVEL%"=="0" taskkill /IM adb.exe /f > NUL
echo Leaving the app. Goodbye
exit
