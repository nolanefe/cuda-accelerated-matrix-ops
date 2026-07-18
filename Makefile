CC = nvcc
CFLAGS = -O3 -std=c++17 -allow-unsupported-compiler -D_Float32=float -D_Float64=double
TARGET = matmul
SRC = src/matmul.cu

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)