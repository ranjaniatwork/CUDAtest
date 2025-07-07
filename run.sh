#!/bin/bash

echo "🔧 Building project..."
make clean && make

echo "📁 Creating output directory (if needed)..."
mkdir -p data/output_images

echo "🚀 Running CUDA-Medical-Imaging..."
./cuda_medical --input_dir data/input_images --output_dir data/output_images --mode enhance

echo "✅ Done!"