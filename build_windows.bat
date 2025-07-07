@echo off
echo 🔧 Building CUDA Medical Imaging Project on Windows...

REM Check if NVCC is available
nvcc --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ NVCC not found. Please install CUDA Toolkit first.
    echo Download from: https://developer.nvidia.com/cuda-downloads
    pause
    exit /b 1
)

REM Check if we have OpenCV installed
if not exist "C:\opencv" (
    echo ❌ OpenCV not found in C:\opencv
    echo Please install OpenCV and set the environment variables
    echo Or modify this script to point to your OpenCV installation
    pause
    exit /b 1
)

REM Set OpenCV paths (modify these paths according to your OpenCV installation)
set OPENCV_DIR=C:\opencv\build
set OPENCV_INCLUDE=%OPENCV_DIR%\include
set OPENCV_LIB=%OPENCV_DIR%\x64\vc16\lib

echo 📁 Creating output directory...
if not exist "data\output_images" mkdir "data\output_images"

echo 🚀 Compiling with NVCC...
echo Command: nvcc -std=c++14 -O3 -I./src -I"%OPENCV_INCLUDE%" -L"%OPENCV_LIB%" -lopencv_core451 -lopencv_imgproc451 -lopencv_highgui451 -lopencv_imgcodecs451 -o cuda_medical.exe src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu

nvcc -std=c++14 -O3 -I./src -I"%OPENCV_INCLUDE%" -L"%OPENCV_LIB%" -lopencv_core451 -lopencv_imgproc451 -lopencv_highgui451 -lopencv_imgcodecs451 -o cuda_medical.exe src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu

if %errorlevel% equ 0 (
    echo ✅ Build successful!
    echo 🚀 Running the application...
    echo Processing image: data/input_images/chemical.png.png
    cuda_medical.exe --input_dir data/input_images --output_dir data/output_images --mode enhance
    if %errorlevel% equ 0 (
        echo ✅ Processing complete! Check data/output_images/ for results.
        if exist "data/output_images/chemical.png.png" (
            echo ✅ Enhanced image created: data/output_images/chemical.png.png
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
    echo 3. Verify CUDA and Visual Studio are properly installed
    pause
)
