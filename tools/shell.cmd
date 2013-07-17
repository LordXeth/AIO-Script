@echo off
adb.exe wait-for-device
adb.exe -s %1 remount
adb.exe -s %1 shell
