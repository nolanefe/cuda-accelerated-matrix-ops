# CUDA-Accelerated Matrix Operations

A silicon-optimized custom CUDA kernel for matrix multiplication (GEMM) written in pure C++. While high-level frameworks like PyTorch and TensorFlow abstract away the massive computational complexity of neural networks, relying solely on them can create bottlenecks when dealing with custom layer architectures or irregular tensor shapes. This project bypasses those high-level abstractions entirely, allowing the computation to be managed explicitly at the hardware level. This shifts the execution away from the Python interpreter and enables maximized parallelization across Streaming Multiprocessors (SMs), optimizing memory bandwidth and enabling zero-latency tensor calculations before the operations are ever integrated into a larger AI training pipeline.

## Core Architecture

* **Host-to-Device Memory Management:** Utilizes explicit memory allocation (`cudaMalloc`) and data streaming (`cudaMemcpy`) across the PCIe bus to eliminate latency spikes between the CPU (Host) and GPU (Device).
* **Custom Kernel Execution:** Implements a foundational `matrixMulKernel` that deploys a grid of blocks, each containing a 16x16 thread matrix, where every individual thread computes a single scalar value of the output matrix independently.
* **Silicon-Level Optimization:** Engineered specifically to bypass the Python Global Interpreter Lock (GIL), executing logic directly in C++ to compute dense 1024x1024 matrix multiplications with zero high-level framework overhead.

## Tech Stack

* **Language:** C++, CUDA
* **Architecture:** Low-Level GPU Compute, Parallel Processing, Memory Management
* **Domain:** AI Systems Infrastructure, Hardware Optimization

## Build and Execution

This project requires the NVIDIA CUDA Toolkit (`nvcc` compiler) to be installed and an NVIDIA GPU available on your system.

```bash
# 1. Clone the repository, compile the CUDA code, and execute the binary natively
git clone [https://github.com/nolanefe/cuda-accelerated-matrix-ops.git](https://github.com/nolanefe/cuda-accelerated-matrix-ops.git)
cd CUDA-Accelerated-Matrix-Ops
make
./matmul