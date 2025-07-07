#include <iostream>
#include <string>
#include "host_utils.h"

int main(int argc, char* argv[]) {
    std::string input_dir = "./data/input_images";
    std::string output_dir = "./data/output_images";
    std::string mode = "enhance"; // default

    parseCommandLineArgs(argc, argv, input_dir, output_dir, mode);

    std::vector<Image> images = loadImagesFromDirectory(input_dir);

    std::cout << "Processing " << images.size() << " image(s) using CPU enhancement..." << std::endl;

    for (auto& img : images) {
        std::cout << "Processing: " << img.filename << " (" << img.width << "x" << img.height << ")" << std::endl;
        
        if (mode == "enhance") {
            // CPU-based image enhancement
            enhanceImageCPU(img.data, img.width, img.height);
        }

        saveImage(output_dir, img.filename, img);
        std::cout << "✅ Enhanced image saved: " << output_dir << "/" << img.filename << std::endl;
    }

    std::cout << "🎉 CPU-based medical image processing complete!" << std::endl;
    return 0;
}
