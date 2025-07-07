@echo off
echo ====================================
echo Component Installation Tester
echo ====================================
echo.

echo Testing component installations...
echo.

echo [1/4] NVIDIA GPU Driver:
nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ NVIDIA GPU driver working
    nvidia-smi --query-gpu=name --format=csv,noheader,nounits | head -1
) else (
    echo ❌ NVIDIA GPU driver not working
    echo    Install from: https://www.nvidia.com/drivers/
)

echo.
echo [2/4] CUDA Toolkit:
nvcc --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ CUDA Toolkit installed
    nvcc --version | findstr "release"
) else (
    echo ❌ CUDA Toolkit not installed
    echo    Install from: https://developer.nvidia.com/cuda-downloads
)

echo.
echo [3/4] Visual Studio C++:
where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Visual Studio C++ compiler found
    echo    Note: Must use "Developer Command Prompt for Visual Studio"
) else (
    echo ❌ Visual Studio C++ compiler not found
    echo    Install Visual Studio Community with C++ workload
    echo    Or use "Developer Command Prompt for Visual Studio"
)

echo.
echo [4/4] OpenCV:
if exist "C:\opencv\build\include\opencv2\opencv.hpp" (
    echo ✅ OpenCV installed at C:\opencv
) else (
    echo ❌ OpenCV not found
    echo    Install from: https://opencv.org/releases/
    echo    Extract to C:\opencv and add to PATH
)

echo.
echo ====================================
echo NEXT STEPS:
echo ====================================

REM Count successful installations
set /a success_count=0

nvidia-smi >nul 2>&1
if %errorlevel% equ 0 set /a success_count+=1

nvcc --version >nul 2>&1
if %errorlevel% equ 0 set /a success_count+=1

where cl >nul 2>&1
if %errorlevel% equ 0 set /a success_count+=1

if exist "C:\opencv\build\include\opencv2\opencv.hpp" set /a success_count+=1

echo Components installed: %success_count%/4

if %success_count% equ 4 (
    echo.
    echo 🎉 ALL COMPONENTS READY!
    echo You can now run: build_windows.bat
    echo.
    echo Would you like to build and run the project now? (Y/N)
    set /p choice=
    if /i "%choice%"=="Y" (
        echo.
        echo Building CUDA Medical Imaging Project...
        call build_windows.bat
    )
) else (
    echo.
    echo ⚠️  Install missing components first, then run this test again.
    echo Quick links:
    echo • NVIDIA Drivers: https://www.nvidia.com/drivers/
    echo • CUDA: https://developer.nvidia.com/cuda-downloads  
    echo • Visual Studio: https://visualstudio.microsoft.com/downloads/
    echo • OpenCV: https://opencv.org/releases/
)

echo.
pause
