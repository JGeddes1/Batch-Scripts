@echo off
REM Set the source directory you want to backup
set source=F:\Coding projects 2024

REM Set the base backup directory
set backupDir=D:\Backup\ImportantFilesBackup

REM Get the current date to create a versioned backup folder (format: YYYYMMDD)
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
    set today=%%c%%a%%b
)

REM Create a new backup folder with the date
set destination=%backupDir%\Backup_%today%
if not exist "%destination%" (
    mkdir "%destination%"
)

REM Set the log file for backup operations
set logFile=%backupDir%\BackupLog.txt

REM Start logging
echo Starting backup on %date% at %time% >> "%logFile%"
echo Backing up data from "%source%" to "%destination%" >> "%logFile%"

REM Perform the backup using robocopy (more robust than xcopy)
robocopy "%source%" "%destination%" /E /Z /R:3 /W:5 /NP /LOG+:"%logFile%"

REM Check if the backup was successful
if %ERRORLEVEL% geq 1 (
    echo Backup completed with errors or warnings. See the log for details. >> "%logFile%"
) else (
    echo Backup completed successfully on %date% at %time%. >> "%logFile%"
)

REM Final message
echo Backup operation completed. Log file: "%logFile%"
pause