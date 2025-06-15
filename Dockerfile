FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Clone llama.cpp repository
RUN git clone --depth 1 https://github.com/ggerganov/llama.cpp.git /opt/llama.cpp

# Build llama.cpp with CUDA support
WORKDIR /opt/llama.cpp
RUN cmake -B build . \
    -DLLAMA_BUILD_EXAMPLES=OFF \
    -DLLAMA_BUILD_TESTS=OFF \
    -DLLAMA_CURL=OFF \
    -DLLAMA_CUDA=ON \
    && cmake --build build --config Release -j$(nproc)

# Make binaries available in PATH
RUN cp build/bin/* /usr/local/bin/ && \
    cp build/*.so* /usr/local/lib/ 2>/dev/null || true && \
    ldconfig

# Set working directory
WORKDIR /workspace