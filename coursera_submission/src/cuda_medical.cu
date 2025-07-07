#include <iostream>
#include <string>
#include "host_utils.h"

int main(int argc, char* argv[]) {
    std::string input_dir = "./data/input_images";
    std::string output_dir = "./data/output_images";
    std::string mode = "enhance"; // default

    parseCommandLineArgs(argc, argv, input_dir, output_dir, mode);

    std::vector<Image> images = loadImagesFromDirectory(input_dir);

    for (auto& img : images) {
        unsigned char* d_input;
        unsigned char* d_output;

        allocateDeviceMemory(img.width * img.height, &d_input, &d_output);

        cudaMemcpy(d_input, img.data, img.width * img.height, cudaMemcpyHostToDevice);

        if (mode == "enhance") {
            launchEnhanceKernel(d_input, d_output, img.width, img.height);
        }

        cudaMemcpy(img.data, d_output, img.width * img.height, cudaMemcpyDeviceToHost);
        saveImage(output_dir, img.filename, img);

        freeDeviceMemory(d_input, d_output);
    }

    return 0;
}