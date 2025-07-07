#include "host_utils.h"
#include <opencv2/opencv.hpp>
#include <filesystem>
#include <iostream>

void parseCommandLineArgs(int argc, char* argv[], std::string& input, std::string& output, std::string& mode) {
    for (int i = 1; i < argc; i++) {
        if (std::string(argv[i]) == "--input_dir") input = argv[++i];
        else if (std::string(argv[i]) == "--output_dir") output = argv[++i];
        else if (std::string(argv[i]) == "--mode") mode = argv[++i];
    }
}

std::vector<Image> loadImagesFromDirectory(const std::string& path) {
    std::vector<Image> images;
    for (const auto& entry : std::filesystem::directory_iterator(path)) {
        cv::Mat img = cv::imread(entry.path().string(), cv::IMREAD_GRAYSCALE);
        if (img.empty()) continue;

        Image image;
        image.width = img.cols;
        image.height = img.rows;
        image.filename = entry.path().filename().string();
        image.data = new unsigned char[img.total()];
        std::copy(img.data, img.data + img.total(), image.data);
        images.push_back(image);
    }
    return images;
}

void saveImage(const std::string& dir, const std::string& filename, const Image& image) {
    cv::Mat out(image.height, image.width, CV_8UC1, image.data);
    cv::imwrite(dir + "/" + filename, out);
}

// CPU-based image enhancement function
void enhanceImageCPU(unsigned char* data, int width, int height) {
    int total_pixels = width * height;
    
    for (int i = 0; i < total_pixels; i++) {
        // Apply the same enhancement as the CUDA kernel
        float pixel = data[i] * 1.25f + 15.0f;
        data[i] = std::min(255, static_cast<int>(pixel));
    }
}