@echo off
setlocal enabledelayedexpansion

REM Set source and backup directories
set source=C:\Users\YourUsername\Documents\ImportantFiles
set backupDir=D:\Backup\ImportantFilesBackup

REM Get current date (YYYYMMDD format)
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
    set today=%%c%%a%%b
)

REM Create versioned backup folder
set destination=%backupDir%\Backup_%today%
if not exist "%destination%" (
    mkdir "%destination%"
)

REM Set log file
set logFile=%backupDir%\BackupLog.txt

REM Use PowerShell to calculate total file size in bytes (handles large numbers)
for /f %%S in ('powershell -command "(Get-ChildItem -Path \"%source%\" -Recurse | Measure-Object -Property Length -Sum).Sum"') do set totalSizeBytes=%%S

REM Convert to MB and GB
set /a totalSizeMB=%totalSizeBytes% / 1048576
set /a totalSizeGB=%totalSizeMB% / 1024

REM Simulated speed in MB/s (adjust based on system speed)
set speedMBps=20
set /a estimatedTime=%totalSizeMB% / %speedMBps%

REM Display estimated size & time
echo Estimated backup size: %totalSizeMB% MB (%totalSizeGB% GB)
echo Estimated time: %estimatedTime% seconds (based on %speedMBps% MB/s speed)

REM Log start
echo Starting backup on %date% at %time% >> "%logFile%"
echo Backing up data from "%source%" to "%destination%" >> "%logFile%"
echo Estimated backup size: %totalSizeMB% MB, Estimated time: %estimatedTime% sec >> "%logFile%"

REM Perform backup (EXCLUDING iCloudPhotos)
robocopy "%source%" "%destination%" /E /Z /R:3 /W:5 /MT:8 /XD "any directory leave out" /TEE /LOG+:"%logFile%"

REM Check if backup was successful
if %ERRORLEVEL% geq 1 (
    echo Backup completed with errors or warnings. See the log for details. >> "%logFile%"
) else (
    echo Backup completed successfully on %date% at %time%. >> "%logFile%"
)

REM Final message
echo Backup operation completed. Log file: "%logFile%"
pause
