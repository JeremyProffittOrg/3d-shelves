@echo off
setlocal enabledelayedexpansion

REM Build STL files and PNG previews for every wrapper SCAD file in this repo.
REM Wrappers are *.scad files OTHER than bar_shelf.scad (which is the library).

set OPENSCAD="C:\Program Files\OpenSCAD\openscad.exe"
set OUT_STL=build\stl
set OUT_IMG=build\images

if not exist build         mkdir build
if not exist %OUT_STL%     mkdir %OUT_STL%
if not exist %OUT_IMG%     mkdir %OUT_IMG%

set CAMERA_FRONT=0,0,0,55,0,45,0
set CAMERA_REAR=0,0,0,55,0,225,0
set IMG_SIZE=800,600

for %%f in (77-inch-industrial-shelves-*.scad) do (
    set BASE=%%~nf
    echo === Building !BASE! ===
    %OPENSCAD% -o %OUT_STL%\!BASE!.stl "%%f"
    %OPENSCAD% -o %OUT_IMG%\!BASE!_front.png --camera=%CAMERA_FRONT% --imgsize=%IMG_SIZE% --autocenter --viewall --colorscheme=Tomorrow "%%f"
    %OPENSCAD% -o %OUT_IMG%\!BASE!_rear.png  --camera=%CAMERA_REAR%  --imgsize=%IMG_SIZE% --autocenter --viewall --colorscheme=Tomorrow "%%f"
)

echo.
echo === Build complete ===
dir %OUT_STL%
dir %OUT_IMG%
