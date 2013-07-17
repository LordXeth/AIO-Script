@echo off
setlocal enabledelayedexpansion
echo Enter %4's password:
echo.
copy /y %~5\unsigned%~n2.apk %~5\%~n2.zip > NUL
%6\Apps\7za.exe d %~5\%~n2.zip META-INF > NUL
%1 -keystore %3 -sigfile CERT -signedjar %5\signedOdexed%~n2.apk %~5\%~n2.apk %4
%1 -keystore %3 -verify -certs %5\signedOdexed%~n2.apk
echo.
del /q %~5\%~n2.zip > NUL
PAUSE