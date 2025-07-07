# CUDA Medical Imaging - Windows Setup Guide

## Prerequisites

Before you can run this CUDA medical imaging project, you need to install the following:

### 1. NVIDIA CUDA Toolkit
- Download from: https://developer.nvidia.com/cuda-downloads
- Choose Windows x86_64
- Install the CUDA Toolkit (this includes nvcc compiler)
- After installation, verify by opening a new command prompt and running: `nvcc --version`

### 2. OpenCV for Windows
Option A - Pre-built binaries (Recommended):
- Download from: https://opencv.org/releases/
- Extract to C:\opencv
- Add C:\opencv\build\x64\vc16\bin to your system PATH

Option B - Using vcpkg:
```cmd
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
.\bootstrap-vcpkg.bat
.\vcpkg.exe install opencv:x64-windows
```

### 3. Visual Studio Build Tools
- Install Visual Studio Community or Build Tools
- Make sure to include C++ development tools
- CUDA requires Visual Studio for compilation on Windows

## Building and Running

### Option 1: Using the Windows Batch File
1. Open Command Prompt or PowerShell as Administrator
2. Navigate to the project directory
3. Run: `build_windows.bat`

### Option 2: Manual Build
1. Open Developer Command Prompt for Visual Studio
2. Navigate to project directory
3. Run:
```cmd
nvcc -std=c++14 -O3 -I./src -I"C:\opencv\build\include" -L"C:\opencv\build\x64\vc16\lib" -lopencv_core451 -lopencv_imgproc451 -lopencv_highgui451 -lopencv_imgcodecs451 -o cuda_medical.exe src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu
```

### Option 3: Using Visual Studio
1. Create a new CUDA project in Visual Studio
2. Add all source files to the project
3. Configure OpenCV include and library paths
4. Build and run

## Running the Application
```cmd
cuda_medical.exe --input_dir data/input_images --output_dir data/output_images --mode enhance
```

## Troubleshooting

### Common Issues:
1. **NVCC not found**: Make sure CUDA is installed and in PATH
2. **OpenCV errors**: Verify OpenCV installation and paths
3. **Link errors**: Check that you're using the correct Visual Studio version
4. **Runtime errors**: Ensure you have an NVIDIA GPU with CUDA support

### GPU Requirements:
- NVIDIA GPU with CUDA Compute Capability 3.0 or higher
- Latest NVIDIA drivers

## Project Structure
- `src/cuda_medical.cu` - Main application
- `src/host_utils.cpp` - Host utility functions (OpenCV image I/O)
- `src/host_utils.h` - Header file
- `src/kernel_utils.cu` - CUDA kernels
- `data/input_images/` - Input medical images
- `data/output_images/` - Processed output images
