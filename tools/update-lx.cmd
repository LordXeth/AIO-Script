@echo off
setlocal enabledelayedexpansion
set /p check=<checkversion.txt
echo.
echo  New Update Found
echo.
echo  Getting Update...
echo.
if EXIST AIO-%check%.zip (del /q AIO-%check%.zip)
Apps\wget\wget -q http://www.daily-battlefield.net/downloads/AIO_Script/AIO-%check%.zip
echo  Installing new updates
IF NOT EXIST  "temp\update\" (mkdir temp\update\)
Apps\7za.exe x AIO-%check%.zip -y -o temp\update\ > NUL
xcopy "temp\update\*" .. /e /y
echo.
echo  Removing temp files
echo.
del /q "AIO-%check%.zip"
del /q "checkversion.txt"
rmdir /S /Q "temp\update\" > NUL
echo  AIO Apk Tool updated successfully!
echo.
PAUSE
exit