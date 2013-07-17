@echo off
tasklist /FI "IMAGENAME eq adb.exe" | find /I /N "adb.exe" > NUL
if "%ERRORLEVEL%"=="0" taskkill /IM adb.exe /f > NUL
if exist %~dp0tools\logs\log.log del /q %~dp0tools\logs\log.log
if exist %~dp0tools\temp\adb.txt del /q %~dp0tools\temp\adb.txt
start cmd.exe /c Script.bat