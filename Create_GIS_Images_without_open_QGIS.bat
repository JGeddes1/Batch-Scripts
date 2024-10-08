@echo off
setlocal

rem Set paths
set PYTHON="C:\Users\jgg513\AppData\Local\Programs\Python\Python312\python.exe"
set SCRIPT="C:\python scripts\gis_image_preview_2.0.py"

REM Get input directory from right-click context menu
set INPUT_DIR=%1

REM Set output directory
set OUTPUT_DIR=%INPUT_DIR%\previews

REM Run Python script
%PYTHON% %SCRIPT% "%INPUT_DIR%" "%OUTPUT_DIR%"

echo Previews generated in %OUTPUT_DIR%
pause