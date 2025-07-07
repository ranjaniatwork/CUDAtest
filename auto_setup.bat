@echo off
echo ================================================
echo CUDA Medical Imaging - Automated Setup Helper
echo ================================================
echo.
echo I'll help you install everything step by step!
echo This script will open installers and guide you through each step.
echo.

REM Check if running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  For best results, run this script as Administrator
    echo Right-click this file and select "Run as administrator"
    echo.
    pause
)

echo [STEP 1] Checking current system status...
echo.

REM Check for NVIDIA GPU
echo Checking for NVIDIA GPU...
nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ NVIDIA GPU detected
) else (
    echo ❌ NVIDIA GPU not detected - installing drivers...
    echo Opening NVIDIA driver download page...
    start https://www.nvidia.com/drivers/
    echo Please download and install the driver, then restart your computer.
    echo Press any key when driver installation is complete...
    pause
)

echo.
echo [STEP 2] Installing CUDA Toolkit...
nvcc --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ CUDA already installed
) else (
    echo Opening CUDA download page...
    start https://developer.nvidia.com/cuda-downloads
    echo.
    echo INSTRUCTIONS FOR CUDA:
    echo 1. Choose: Windows ^> x86_64 ^> 11 ^> exe (local)
    echo 2. Download the installer (~3GB)
    echo 3. Run as Administrator
    echo 4. Choose "Express Installation"
    echo 5. Restart your computer
    echo.
    echo Press any key when CUDA installation is complete...
    pause
)

echo.
echo [STEP 3] Installing Visual Studio...
where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Visual Studio C++ already installed
) else (
    echo Opening Visual Studio download page...
    start https://visualstudio.microsoft.com/downloads/
    echo.
    echo INSTRUCTIONS FOR VISUAL STUDIO:
    echo 1. Download "Visual Studio Community 2022" (free)
    echo 2. Run the installer
    echo 3. Select "Desktop development with C++" workload
    echo 4. Click Install (takes 15-30 minutes)
    echo 5. Restart your computer
    echo.
    echo Press any key when Visual Studio installation is complete...
    pause
)

echo.
echo [STEP 4] Installing OpenCV...
if exist "C:\opencv\build\include\opencv2\opencv.hpp" (
    echo ✅ OpenCV already installed
) else (
    echo Opening OpenCV download page...
    start https://opencv.org/releases/
    echo.
    echo INSTRUCTIONS FOR OPENCV:
    echo 1. Download the Windows exe file
    echo 2. Extract to C:\opencv
    echo 3. Add to PATH: Win+R, type sysdm.cpl
    echo 4. Environment Variables ^> System Path ^> Edit ^> New
    echo 5. Add: C:\opencv\build\x64\vc16\bin
    echo 6. Restart your computer
    echo.
    echo Press any key when OpenCV installation is complete...
    pause
)

echo.
echo [STEP 5] Final verification and build...
echo Please make sure you've restarted your computer after installations.
echo Press any key to run the final verification...
pause

echo.
echo Running prerequisites check...
call check_prerequisites.bat

echo.
echo If all checks passed above, press any key to build and run the project...
pause

echo.
echo ================================================
echo Building and Running CUDA Medical Imaging...
echo ================================================

REM Check one more time that we're in the right environment
where cl >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  Please run this from "Developer Command Prompt for Visual Studio"
    echo Search for it in the Start menu and run this script again.
    pause
    exit /b 1
)

call build_windows.bat

echo.
echo ================================================
echo Setup Complete!
echo ================================================
if exist "data\output_images\chemical.png.png" (
    echo ✅ SUCCESS! Your CUDA medical imaging project is working!
    echo ✅ Enhanced image created: data\output_images\chemical.png.png
    echo.
    echo 🎉 Congratulations! Your GPU-accelerated medical imaging is ready!
) else (
    echo ❌ Something went wrong. Please check the error messages above.
    echo You can run individual components:
    echo - check_prerequisites.bat (to verify installation)
    echo - build_windows.bat (to build and run)
)

echo.
echo Press any key to exit...
pause
