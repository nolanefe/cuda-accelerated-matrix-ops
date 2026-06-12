#include <cuda_runtime.h>
#include <iostream>
#include <vector>
#include <cmath>

// Custom GPU kernel for matrix multiplication
__global__ void matrixMulKernel(float* A, float* B, float* C, int N) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    
    // Ensure we don't go out of bounds
    if (row < N && col < N) {
        float value = 0;
        for (int k = 0; k < N; ++k) {
            value += A[row * N + k] * B[k * N + col];
        }
        C[row * N + col] = value;
    }
}

int main() {
    // Define matrix dimensions (1024x1024)
    int N = 1024; 
    size_t size = N * N * sizeof(float);

    // 1. Allocate memory on the CPU (Host)
    float *h_A = (float*)malloc(size);
    float *h_B = (float*)malloc(size);
    float *h_C = (float*)malloc(size);

    // Initialize matrices with dummy values
    for (int i = 0; i < N * N; ++i) {
        h_A[i] = 1.0f;
        h_B[i] = 2.0f;
    }

    // 2. Allocate memory on the GPU (Device)
    float *d_A, *d_B, *d_C;
    cudaMalloc(&d_A, size);
    cudaMalloc(&d_B, size);
    cudaMalloc(&d_C, size);

    // 3. Copy data from Host to Device
    cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

    // 4. Define thread hierarchy (16x16 threads per block)
    dim3 threadsPerBlock(16, 16);
    dim3 numBlocks((N + threadsPerBlock.x - 1) / threadsPerBlock.x, 
                   (N + threadsPerBlock.y - 1) / threadsPerBlock.y);

    std::cout << "Launching CUDA kernel..." << std::endl;

    // 5. Launch the kernel
    matrixMulKernel<<<numBlocks, threadsPerBlock>>>(d_A, d_B, d_C, N);

    // Wait for GPU to finish
    cudaDeviceSynchronize();

    // 6. Copy result back to Host
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

    // 7. Verification
    std::cout << "Matrix multiplication completed for " << N << "x" << N << " matrices." << std::endl;
    std::cout << "Verification - Sample output C[0]: " << h_C[0] << " (Expected: " << N * 1.0f * 2.0f << ")" << std::endl;

    // 8. Free memory
    cudaFree(d_A); 
    cudaFree(d_B); 
    cudaFree(d_C);
    free(h_A); 
    free(h_B); 
    free(h_C);

    return 0;
}