# CUDA Medical Imaging Project - Quick Start Guide

## Current Status
This CUDA medical imaging project requires several components to run:

✅ **Project Files**: Present  
❌ **CUDA Toolkit**: Not detected  
❌ **C++ Compiler**: Not detected  
❌ **OpenCV**: Not detected  

## What This Project Does
This is a CUDA-accelerated medical image enhancement application that:
- Reads medical images from `data/input_images/`
- Applies GPU-accelerated image enhancement
- Saves processed images to `data/output_images/`

## Immediate Next Steps

### 1. Install CUDA Toolkit (Required)
- Go to: https://developer.nvidia.com/cuda-downloads
- Download CUDA Toolkit for Windows
- This includes the `nvcc` compiler needed to build CUDA code

### 2. Install Visual Studio Community (Required)
- Go to: https://visualstudio.microsoft.com/downloads/
- Download Visual Studio Community (free)
- During installation, select "Desktop development with C++"
- This provides the C++ compiler that CUDA needs

### 3. Install OpenCV (Required)
- Download from: https://opencv.org/releases/
- Extract to `C:\opencv`
- Add `C:\opencv\build\x64\vc16\bin` to system PATH

### 4. Verify Installation
After installing the above, open a new Command Prompt and run:
```cmd
nvcc --version
cl
```

## Quick Test (After Setup)
1. Open "Developer Command Prompt for Visual Studio"
2. Navigate to this project folder
3. Run: `build_windows.bat`

## Alternative: Use Visual Studio
1. Open Visual Studio
2. Create new project: "CUDA Runtime"
3. Add the source files from the `src/` folder
4. Configure OpenCV paths in project settings
5. Build and run

## Files in This Project
- `cuda_medical.cu` - Main CUDA application
- `host_utils.cpp` - Image loading/saving (uses OpenCV)
- `kernel_utils.cu` - GPU image enhancement kernels
- `chemical.png.png` - Sample medical image for testing

## Need Help?
If you encounter issues:
1. Make sure you have an NVIDIA GPU
2. Update your NVIDIA drivers
3. Verify all tools are in your system PATH
4. Use the "Developer Command Prompt for Visual Studio" instead of regular Command Prompt
