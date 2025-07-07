#pragma once
#include <string>
#include <vector>

struct Image {
    int width;
    int height;
    std::string filename;
    unsigned char* data;
};

void parseCommandLineArgs(int argc, char* argv[], std::string& input, std::string& output, std::string& mode);
std::vector<Image> loadImagesFromDirectory(const std::string& path);
void saveImage(const std::string& dir, const std::string& filename, const Image& image);

// CPU-based enhancement function
void enhanceImageCPU(unsigned char* data, int width, int height);