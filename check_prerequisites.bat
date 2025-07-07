@echo off
echo ================================
echo CUDA Medical Imaging - Prerequisites Checker
echo ================================

echo.
echo Checking system requirements...

REM Check for NVIDIA GPU
echo [1/6] Checking for NVIDIA GPU...
nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ NVIDIA GPU detected
    nvidia-smi --query-gpu=name --format=csv,noheader,nounits
) else (
    echo ❌ NVIDIA GPU not detected or drivers not installed
    echo    Please install NVIDIA drivers first: https://www.nvidia.com/drivers/
)

echo.
echo [2/6] Checking for CUDA Toolkit...
nvcc --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ CUDA Toolkit found
    nvcc --version | findstr "release"
) else (
    echo ❌ CUDA Toolkit not found
    echo    Download from: https://developer.nvidia.com/cuda-downloads
    echo    Choose: Windows x86_64 ^> Local ^> exe[network] or exe[local]
)

echo.
echo [3/6] Checking for Visual Studio C++ Compiler...
where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Visual Studio C++ compiler found
) else (
    echo ❌ Visual Studio C++ compiler not found
    echo    Install Visual Studio Community: https://visualstudio.microsoft.com/downloads/
    echo    Make sure to select "Desktop development with C++" workload
)

echo.
echo [4/6] Checking for OpenCV...
if exist "C:\opencv\build\include\opencv2\opencv.hpp" (
    echo ✅ OpenCV found at C:\opencv
) else (
    echo ❌ OpenCV not found at C:\opencv
    echo    Download from: https://opencv.org/releases/
    echo    Extract to C:\opencv and add C:\opencv\build\x64\vc16\bin to PATH
)

echo.
echo [5/6] Checking PATH environment...
echo %PATH% | findstr "opencv" >nul
if %errorlevel% equ 0 (
    echo ✅ OpenCV appears to be in PATH
) else (
    echo ⚠️  OpenCV may not be in PATH
    echo    Add C:\opencv\build\x64\vc16\bin to your system PATH
)

echo.
echo [6/6] Checking project files...
if exist "src\cuda_medical.cu" (
    echo ✅ CUDA source files found
) else (
    echo ❌ Source files missing
)

echo.
echo ================================
echo Installation Guide:
echo ================================
echo.
echo 1. Install NVIDIA GPU Drivers (if not done):
echo    https://www.nvidia.com/drivers/
echo.
echo 2. Install CUDA Toolkit:
echo    https://developer.nvidia.com/cuda-downloads
echo    - Choose Windows x86_64
echo    - Download and run the installer
echo    - Restart your computer after installation
echo.
echo 3. Install Visual Studio Community:
echo    https://visualstudio.microsoft.com/downloads/
echo    - Select "Desktop development with C++" workload
echo    - This includes the C++ compiler (cl.exe)
echo.
echo 4. Install OpenCV:
echo    https://opencv.org/releases/
echo    - Download the Windows package
echo    - Extract to C:\opencv
echo    - Add C:\opencv\build\x64\vc16\bin to system PATH
echo.
echo 5. After installation:
echo    - Restart your computer
echo    - Open "Developer Command Prompt for Visual Studio"
echo    - Run this checker again: check_prerequisites.bat
echo    - Then run: build_windows.bat
echo.
echo ================================

pause
