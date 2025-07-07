@echo off
echo 🔧 Building CPU Medical Imaging Project on Windows...

REM Check if we have a C++ compiler
where cl >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Visual Studio C++ compiler not found.
    echo Please run this from "Developer Command Prompt for Visual Studio"
    echo Download Visual Studio Community: https://visualstudio.microsoft.com/downloads/
    pause
    exit /b 1
)

REM Check if we have OpenCV installed
if not exist "C:\opencv" (
    echo ❌ OpenCV not found in C:\opencv
    echo Please install OpenCV:
    echo 1. Download from: https://opencv.org/releases/
    echo 2. Extract to C:\opencv
    echo 3. Add C:\opencv\build\x64\vc16\bin to system PATH
    pause
    exit /b 1
)

REM Set OpenCV paths
set OPENCV_DIR=C:\opencv\build
set OPENCV_INCLUDE=%OPENCV_DIR%\include
set OPENCV_LIB=%OPENCV_DIR%\x64\vc16\lib

echo ✅ Visual Studio C++ compiler found
echo ✅ OpenCV found at C:\opencv

echo 📁 Creating output directory...
if not exist "data\output_images" mkdir "data\output_images"

echo 🚀 Compiling CPU version with Visual Studio...
echo Command: cl /EHsc /std:c++14 /O2 /I./src /I"%OPENCV_INCLUDE%" src/cpu_medical.cpp src/host_utils.cpp /link /LIBPATH:"%OPENCV_LIB%" opencv_core451.lib opencv_imgproc451.lib opencv_highgui451.lib opencv_imgcodecs451.lib /OUT:cpu_medical.exe

cl /EHsc /std:c++14 /O2 /I./src /I"%OPENCV_INCLUDE%" src/cpu_medical.cpp src/host_utils.cpp /link /LIBPATH:"%OPENCV_LIB%" opencv_core451.lib opencv_imgproc451.lib opencv_highgui451.lib opencv_imgcodecs451.lib /OUT:cpu_medical.exe

if %errorlevel% equ 0 (
    echo ✅ Build successful!
    echo 🚀 Running the CPU-based application...
    echo Processing image: data/input_images/chemical.png.png
    
    cpu_medical.exe --input_dir data/input_images --output_dir data/output_images --mode enhance
    
    if %errorlevel% equ 0 (
        echo ✅ Processing complete! Check data/output_images/ for results.
        if exist "data/output_images/chemical.png.png" (
            echo ✅ Enhanced image created: data/output_images/chemical.png.png
            echo 🎉 CPU-based medical imaging processing successful!
        )
    ) else (
        echo ❌ Runtime error occurred!
    )
) else (
    echo ❌ Build failed!
    echo.
    echo Common solutions:
    echo 1. Make sure you're using "Developer Command Prompt for Visual Studio"
    echo 2. Check if OpenCV version matches (try opencv_core450 if 451 fails)
    echo 3. Verify Visual Studio C++ tools are installed
    pause
)

echo.
echo Press any key to exit...
pause
