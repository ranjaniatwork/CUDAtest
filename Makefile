TARGET = cuda_medical
SRC = src/cuda_medical.cu src/host_utils.cpp src/kernel_utils.cu
CFLAGS = -std=c++14 -O3

all: $(TARGET)

$(TARGET): $(SRC)
	nvcc $(CFLAGS) -I./src -o $(TARGET) $(SRC) `pkg-config --cflags --libs opencv4`

clean:
	rm -f $(TARGET)