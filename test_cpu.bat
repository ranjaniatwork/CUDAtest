@echo off
echo ====================================
echo CPU Medical Imaging - Quick Test
echo ====================================
echo.

echo Testing system readiness for CPU version...
echo.

echo [1/2] Visual Studio C++ Compiler:
where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Visual Studio C++ compiler found
) else (
    echo ❌ Visual Studio C++ compiler not found
    echo    Install Visual Studio Community with C++ workload
    echo    Or use "Developer Command Prompt for Visual Studio"
    echo    Download: https://visualstudio.microsoft.com/downloads/
)

echo.
echo [2/2] OpenCV:
if exist "C:\opencv\build\include\opencv2\opencv.hpp" (
    echo ✅ OpenCV installed at C:\opencv
) else (
    echo ❌ OpenCV not found
    echo    Download: https://opencv.org/releases/
    echo    Extract to C:\opencv and add to PATH
)

echo.
echo ====================================

REM Count successful components
set /a success_count=0

where cl >nul 2>&1
if %errorlevel% equ 0 set /a success_count+=1

if exist "C:\opencv\build\include\opencv2\opencv.hpp" set /a success_count+=1

echo CPU Version Requirements: %success_count%/2

if %success_count% equ 2 (
    echo.
    echo 🎉 ALL COMPONENTS READY FOR CPU VERSION!
    echo.
    echo Would you like to build and run the CPU medical imaging now? (Y/N)
    set /p choice=
    if /i "%choice%"=="Y" (
        echo.
        echo Building CPU Medical Imaging Project...
        call build_cpu.bat
    )
) else (
    echo.
    echo ⚠️  Install missing components first:
    if %success_count% lss 1 (
        echo • Visual Studio Community: https://visualstudio.microsoft.com/downloads/
    )
    if not exist "C:\opencv\build\include\opencv2\opencv.hpp" (
        echo • OpenCV: https://opencv.org/releases/
    )
    echo.
    echo Then run this test again: test_cpu.bat
)

echo.
pause
