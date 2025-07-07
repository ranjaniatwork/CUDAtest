@echo off
echo ========================================
echo CUDA Medical Imaging - Quick Installer
echo ========================================
echo.
echo This script will help you download the required components.
echo You'll still need to run the installers manually.
echo.

REM Create downloads directory
if not exist "downloads" mkdir "downloads"

echo [1/4] Opening NVIDIA Driver download page...
start https://www.nvidia.com/drivers/

echo [2/4] Opening CUDA Toolkit download page...
start https://developer.nvidia.com/cuda-downloads

echo [3/4] Opening Visual Studio download page...
start https://visualstudio.microsoft.com/downloads/

echo [4/4] Opening OpenCV download page...
start https://opencv.org/releases/

echo.
echo ========================================
echo INSTALLATION ORDER (Important!):
echo ========================================
echo.
echo 1. Install NVIDIA Drivers first
echo    - Download from the opened browser tab
echo    - Run the installer
echo    - Restart your computer
echo.
echo 2. Install CUDA Toolkit
echo    - Choose: Windows ^> x86_64 ^> 11 ^> exe (local)
echo    - Run as Administrator
echo    - Choose "Express Installation"
echo    - Restart your computer
echo.
echo 3. Install Visual Studio Community
echo    - Download "Visual Studio Community 2022"
echo    - Select "Desktop development with C++" workload
echo    - Install (takes 15-30 minutes)
echo    - Restart your computer
echo.
echo 4. Install OpenCV
echo    - Download the Windows exe file
echo    - Extract to C:\opencv
echo    - Add C:\opencv\build\x64\vc16\bin to system PATH
echo    - Restart your computer
echo.
echo 5. After all installations:
echo    - Open "Developer Command Prompt for Visual Studio"
echo    - Run: check_prerequisites.bat
echo    - Run: build_windows.bat
echo.
echo ========================================
echo SYSTEM PATH Setup for OpenCV:
echo ========================================
echo 1. Press Win+R, type: sysdm.cpl
echo 2. Click "Environment Variables"
echo 3. Under "System Variables", find "Path", click "Edit"
echo 4. Click "New", add: C:\opencv\build\x64\vc16\bin
echo 5. Click OK on all dialogs
echo 6. Restart computer
echo.
echo Press any key when you've completed ALL installations...
pause

echo.
echo Running prerequisites check...
call check_prerequisites.bat

echo.
echo If all checks passed, press any key to build and run...
pause

echo.
echo Building and running CUDA Medical Imaging...
call build_windows.bat
