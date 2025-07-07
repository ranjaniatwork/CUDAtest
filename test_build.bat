@echo off
echo ====================================
echo CUDA Medical Imaging - Test Runner
echo ====================================

REM Quick system check
echo Checking system status...
nvcc --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ CUDA not available. Run quick_installer.bat first.
    pause
    exit /b 1
)

where cl >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Visual Studio C++ not available. 
    echo Please run this from "Developer Command Prompt for Visual Studio"
    pause
    exit /b 1
)

if not exist "C:\opencv" (
    echo ❌ OpenCV not found. Install OpenCV to C:\opencv first.
    pause
    exit /b 1
)

echo ✅ All prerequisites found!
echo.

REM Create test output directory
if not exist "data\output_images" mkdir "data\output_images"

echo Building project...
nvcc -std=c++14 -O3 -I./src -I"C:\opencv\build\include" -L"C:\opencv\build\x64\vc16\lib" -lopencv_core451 -lopencv_imgproc451 -lopencv_highgui451 -lopencv_imgcodecs451 -o cuda_medical.exe src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu

if %errorlevel% neq 0 (
    echo ❌ Build failed. Trying with different OpenCV version...
    nvcc -std=c++14 -O3 -I./src -I"C:\opencv\build\include" -L"C:\opencv\build\x64\vc16\lib" -lopencv_core450 -lopencv_imgproc450 -lopencv_highgui450 -lopencv_imgcodecs450 -o cuda_medical.exe src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu
)

if %errorlevel% equ 0 (
    echo ✅ Build successful!
    echo.
    echo Running CUDA medical image enhancement...
    echo Input: data/input_images/chemical.png.png
    echo Output: data/output_images/chemical.png.png
    echo.
    
    cuda_medical.exe --input_dir data/input_images --output_dir data/output_images --mode enhance
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ SUCCESS! Medical image processing completed.
        echo.
        if exist "data/output_images/chemical.png.png" (
            echo ✅ Enhanced image created: data/output_images/chemical.png.png
            echo 📊 File size comparison:
            for %%F in ("data/input_images/chemical.png.png") do echo    Original: %%~zF bytes
            for %%F in ("data/output_images/chemical.png.png") do echo    Enhanced: %%~zF bytes
            echo.
            echo 🎉 Your CUDA medical imaging project is working perfectly!
        ) else (
            echo ⚠️ Output file not created. Check error messages above.
        )
    ) else (
        echo ❌ Runtime error occurred during processing.
    )
else (
    echo ❌ Build failed. Check error messages above.
    echo.
    echo Troubleshooting tips:
    echo 1. Ensure you're using "Developer Command Prompt for Visual Studio"
    echo 2. Check OpenCV installation at C:\opencv
    echo 3. Verify CUDA and Visual Studio are properly installed
)

echo.
echo Test complete.
pause
