CC = nvcc
CFLAGS = -O3 -std=c++14
TARGET = matmul
SRC = src/matmul.cu

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)