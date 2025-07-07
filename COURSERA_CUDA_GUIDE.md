# CUDA Medical Imaging - Google Colab Version
# For Coursera CUDA at Scale Assignment

## Setup Instructions for Google Colab:

### Step 1: Open Google Colab
1. Go to: https://colab.research.google.com
2. Sign in with Google account
3. Create new notebook

### Step 2: Enable GPU Runtime
1. Runtime → Change runtime type
2. Hardware accelerator → GPU
3. GPU type → T4 (or available option)
4. Save

### Step 3: Verify CUDA Installation
```python
# Check if CUDA is available
!nvidia-smi
!nvcc --version
```

### Step 4: Install Required Packages
```bash
# Install OpenCV
!apt-get update
!apt-get install -y libopencv-dev
!pip install opencv-python

# Create project structure
!mkdir -p cuda_medical/src
!mkdir -p cuda_medical/data/input_images
!mkdir -p cuda_medical/data/output_images
```

### Step 5: Upload Your Source Files
Upload these files to Colab:
- src/cuda_medical.cu
- src/host_utils.cpp  
- src/host_utils.h
- src/kernel_utils.cu
- data/input_images/chemical.png.png

### Step 6: Compile and Run
```bash
# Navigate to project directory
%cd cuda_medical

# Compile CUDA project
!nvcc -std=c++14 -O3 -I./src -o cuda_medical src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu `pkg-config --cflags --libs opencv4`

# Run the application
!./cuda_medical --input_dir data/input_images --output_dir data/output_images --mode enhance

# Display results
from IPython.display import Image, display
import matplotlib.pyplot as plt

# Show original and enhanced images
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))

original = plt.imread('data/input_images/chemical.png.png')
enhanced = plt.imread('data/output_images/chemical.png.png')

ax1.imshow(original, cmap='gray')
ax1.set_title('Original Medical Image')
ax1.axis('off')

ax2.imshow(enhanced, cmap='gray')
ax2.set_title('CUDA Enhanced Image')
ax2.axis('off')

plt.tight_layout()
plt.show()
```

## 📊 Assignment Deliverables:
1. **CUDA Source Code** - Your .cu files
2. **Compilation Output** - Build logs showing successful CUDA compilation
3. **Execution Results** - GPU processing output and enhanced images
4. **Performance Metrics** - GPU utilization and processing times
5. **Documentation** - Project description and CUDA concepts used

## 🎓 Learning Objectives Covered:
- CUDA kernel development
- GPU memory management
- Parallel image processing
- CUDA compilation and optimization
- Enterprise-scale GPU computing concepts

This approach lets you complete your Coursera CUDA assignment properly with real NVIDIA GPU hardware in the cloud!
