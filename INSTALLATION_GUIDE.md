# CUDA Medical Imaging - Step-by-Step Installation Guide

## Current Status ❌
- NVIDIA GPU: Not detected
- CUDA Toolkit: Not installed  
- Visual Studio C++: Not installed
- OpenCV: Not installed

## Installation Steps (Follow in Order)

### Step 1: Check Your Hardware 🖥️
First, verify you have an NVIDIA GPU:
1. Press `Win + R`, type `dxdiag`, press Enter
2. Click "Display" tab
3. Look for NVIDIA in the graphics card name
4. If you only see Intel/AMD graphics, this project won't work

### Step 2: Install NVIDIA Drivers 🔧
**Download:** https://www.nvidia.com/drivers/
1. Click "Download Drivers"
2. Select your GPU model (or use auto-detect)
3. Download and install the latest driver
4. Restart your computer

### Step 3: Install CUDA Toolkit ⚡
**Download:** https://developer.nvidia.com/cuda-downloads
1. Choose: Windows → x86_64 → 11 → exe (local)
2. Download the installer (~3GB)
3. Run as Administrator
4. Choose "Express Installation"
5. Restart your computer
6. **Verify:** Open Command Prompt, type `nvcc --version`

### Step 4: Install Visual Studio Community 💻
**Download:** https://visualstudio.microsoft.com/downloads/
1. Download "Visual Studio Community 2022" (free)
2. Run the installer
3. In "Workloads" tab, select:
   - ✅ "Desktop development with C++"
4. Click "Install" (this will take 15-30 minutes)
5. Restart your computer

### Step 5: Install OpenCV 📷
**Download:** https://opencv.org/releases/
1. Download "Windows" version (opencv-4.x.x-windows.exe)
2. Run the installer, extract to `C:\opencv`
3. **Add to PATH:**
   - Press `Win + R`, type `sysdm.cpl`, press Enter
   - Click "Environment Variables"
   - Under "System Variables", find "Path", click "Edit"
   - Click "New", add: `C:\opencv\build\x64\vc16\bin`
   - Click "OK" on all dialogs
4. Restart your computer

### Step 6: Verify Installation ✅
1. Press `Win + R`, type `cmd`, press Enter
2. Type these commands to verify:
```cmd
nvcc --version
cl
nvidia-smi
```
All should work without errors.

### Step 7: Build and Run 🚀
1. Open "Developer Command Prompt for Visual Studio" (search in Start menu)
2. Navigate to your project folder:
```cmd
cd "c:\Users\artam\OneDrive\Desktop\Ranjani_job\CUDA project\CUDAtest\CUDA-Medical-Imaging"
```
3. Run the checker: `check_prerequisites.bat`
4. If all green ✅, run: `build_windows.bat`

## Expected Output 📊
After successful execution:
- Enhanced medical image saved in `data/output_images/`
- Console shows GPU processing information
- Processing time will be displayed

## Troubleshooting 🔍

### Common Issues:
1. **"nvcc not found"** → CUDA not in PATH, restart computer
2. **"cl not found"** → Use "Developer Command Prompt for Visual Studio"
3. **"OpenCV not found"** → Check PATH environment variable
4. **GPU errors** → Update NVIDIA drivers

### System Requirements:
- Windows 10/11 (64-bit)
- NVIDIA GPU with CUDA support
- 4GB+ RAM
- 10GB+ free disk space

## Download Links Quick Reference:
- NVIDIA Drivers: https://www.nvidia.com/drivers/
- CUDA Toolkit: https://developer.nvidia.com/cuda-downloads  
- Visual Studio: https://visualstudio.microsoft.com/downloads/
- OpenCV: https://opencv.org/releases/

**Total Installation Time: ~1-2 hours** (depending on internet speed)
