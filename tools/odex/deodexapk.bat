@echo off
setlocal enabledelayedexpansion
set /p errors=<%~dp0error.txt
if (%1)==() goto end
if not exist %~dp0odex\system\app\%~n1.odex goto notodex
if not exist %~dp0odex\out mkdir %~dp0odex\out > NUL
echo Deodexing %~n1.apk...
java -jar %baksmali% -a %api% -x %~dp0odex\system\app\%~n1.odex -d %~dp0deodex\system\framework -d %~dp0odex\system\framework -o %~dp0deodex\system\app\%~n1
if errorlevel 1 goto error
java -jar %smali% -a %api% %~dp0deodex\system\app\%~n1 -o %~dp0odex\out\classes.dex
if errorlevel 1 goto error
%zip% u -tzip %~dp0odex\system\app\%~n1.apk %~dp0odex\out\classes.dex -mx%3 > NUL
move %~dp0odex\system\app\%~n1.apk %~dp0deodex\system\app\%~n1.apk > NUL
if exist %~dp0deodex\system\app\%~n1 rd /s /q %~dp0deodex\system\app\%~n1 > NUL
if exist %~dp0odex\system\app\%~n1.odex del /q %~dp0odex\system\app\%~n1.odex > NUL
if exist %~dp0odex\out rd /s /q %~dp0odex\out > NUL
goto end
:notodex
move %~dp0odex\system\app\%~n1.apk %~dp0deodex\system\app\%~n1.apk > NUL
if exist %~dp0deodex\system\app\%~n1 rd /s /q %~dp0deodex\system\app\%~n1 > NUL
if exist %~dp0odex\system\app\%~n1.odex del /q %~dp0odex\system\app\%~n1.odex > NUL
if exist %~dp0odex\out rd /s /q %~dp0odex\out > NUL
goto end
:error
echo.
%colorchange% %err%
echo An Error Occured with %~n1.apk
%colorchange% %bg%
echo An Error Occured with %~n1.apk>>%~dp0errorfile.txt
set /A errors+=1
echo %errors% > %~dp0error.txt
echo.
rd /s /q %~dp0deodex\system\app\%~n1 > NUL
:end