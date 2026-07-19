CC = nvcc
CXX = g++-12 
CFLAGS = -O3 -std=c++17
TARGET = matmul
SRC = src/matmul.cu

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -ccbin $(CXX) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)