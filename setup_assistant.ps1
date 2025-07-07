# CUDA Medical Imaging - PowerShell Setup Assistant
# Run this as Administrator for best results

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "CUDA Medical Imaging - Setup Assistant" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Function to download files
function Download-File {
    param($url, $output)
    Write-Host "Downloading: $output" -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        Write-Host "✅ Downloaded: $output" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Failed to download: $output" -ForegroundColor Red
        return $false
    }
}

# Create downloads directory
$downloadsDir = "downloads"
if (!(Test-Path $downloadsDir)) {
    New-Item -ItemType Directory -Path $downloadsDir
}

Write-Host "🚀 Opening download pages in your browser..." -ForegroundColor Yellow
Write-Host ""

# Open download pages
Start-Process "https://www.nvidia.com/drivers/"
Start-Process "https://developer.nvidia.com/cuda-downloads"
Start-Process "https://visualstudio.microsoft.com/downloads/"
Start-Process "https://opencv.org/releases/"

Write-Host "📋 INSTALLATION CHECKLIST:" -ForegroundColor Cyan
Write-Host ""
Write-Host "□ 1. NVIDIA Drivers" -ForegroundColor White
Write-Host "   - Download from opened tab"
Write-Host "   - Install and restart"
Write-Host ""
Write-Host "□ 2. CUDA Toolkit" -ForegroundColor White  
Write-Host "   - Choose: Windows > x86_64 > exe (local)"
Write-Host "   - Run as Admin, Express Install"
Write-Host "   - Restart computer"
Write-Host ""
Write-Host "□ 3. Visual Studio Community" -ForegroundColor White
Write-Host "   - Download Community 2022"
Write-Host "   - Select 'Desktop development with C++'"
Write-Host "   - Install and restart"
Write-Host ""
Write-Host "□ 4. OpenCV" -ForegroundColor White
Write-Host "   - Download Windows exe"
Write-Host "   - Extract to C:\opencv"
Write-Host "   - Add C:\opencv\build\x64\vc16\bin to PATH"
Write-Host "   - Restart computer"
Write-Host ""

Write-Host "⏰ ESTIMATED TIME: 1-2 hours total" -ForegroundColor Yellow
Write-Host ""

# Wait for user input
Write-Host "Press Enter after completing ALL installations..." -ForegroundColor Green
Read-Host

# Final verification
Write-Host ""
Write-Host "🔍 Running final verification..." -ForegroundColor Cyan

# Check CUDA
try {
    $cudaVersion = & nvcc --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ CUDA Toolkit installed" -ForegroundColor Green
    } else {
        Write-Host "❌ CUDA Toolkit not found" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ CUDA Toolkit not found" -ForegroundColor Red
}

# Check Visual Studio
try {
    $clVersion = & where.exe cl 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Visual Studio C++ compiler found" -ForegroundColor Green
    } else {
        Write-Host "❌ Visual Studio C++ compiler not found" -ForegroundColor Red
        Write-Host "   Use 'Developer Command Prompt for Visual Studio'" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Visual Studio C++ compiler not found" -ForegroundColor Red
}

# Check OpenCV
if (Test-Path "C:\opencv\build\include\opencv2\opencv.hpp") {
    Write-Host "✅ OpenCV installed" -ForegroundColor Green
} else {
    Write-Host "❌ OpenCV not found at C:\opencv" -ForegroundColor Red
}

Write-Host ""
Write-Host "🚀 If all items show ✅, you're ready to build!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Open 'Developer Command Prompt for Visual Studio'" -ForegroundColor White
Write-Host "2. Navigate to your project folder" -ForegroundColor White
Write-Host "3. Run: .\build_windows.bat" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"
