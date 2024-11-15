@echo off
setlocal enabledelayedexpansion

REM Set the path to ogr2ogr executable
set "ogr2ogr=C:\GDAL\gdal-3-8-4-mapserver-8-0-1\bin\gdal\apps\ogr2ogr.exe"
setx PROJ_LIB "C:\GDAL\gdal-3-8-4-mapserver-8-0-1\bin\proj9\share"


REM Create GML folder if it doesn't exist
if not exist "GML" mkdir "GML"

REM Loop through all SHP files in the current directory
for %%f in (*.shp) do (
    REM Set output GML filename based on SHP filename
    set "output_gml=GML\%%~nf.gml"

    REM Convert SHP to GML using ogr2ogr
    "!ogr2ogr!" -f GML "!output_gml!" "%%f"

    REM Check if conversion was successful
    if !errorlevel! neq 0 (
        echo Conversion of %%f failed
    ) else (
        echo Converted %%f to %%~nf.gml
    )
)

echo All conversions completed.
pause