#include <cuda_runtime.h>

__global__ void enhanceKernel(const unsigned char* input, unsigned char* output, int width, int height) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= width || y >= height) return;

    int idx = y * width + x;
    float pixel = input[idx] * 1.25f + 15.0f;
    output[idx] = min(255, static_cast<int>(pixel));
}

extern "C" void launchEnhanceKernel(const unsigned char* d_input, unsigned char* d_output, int width, int height) {
    dim3 blockDim(16, 16);
    dim3 gridDim((width + 15) / 16, (height + 15) / 16);
    enhanceKernel<<<gridDim, blockDim>>>(d_input, d_output, width, height);
    cudaDeviceSynchronize();
}