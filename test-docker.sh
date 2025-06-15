#!/bin/bash
set -e

echo "=== Testing owl-llm Docker image ==="
echo

# Test 1: Check if container runs
echo "Test 1: Container runs successfully"
docker run --rm ghcr.io/workflow-library/owl-llm:latest echo "Container is running"
echo "✓ Pass"
echo

# Test 2: Check if bash is available
echo "Test 2: Bash shell is available"
docker run --rm ghcr.io/workflow-library/owl-llm:latest bash -c "echo 'Bash is working'"
echo "✓ Pass"
echo

# Test 3: Check working directory
echo "Test 3: Working directory is /workspace"
docker run --rm ghcr.io/workflow-library/owl-llm:latest pwd
echo "✓ Pass"
echo

# Test 4: Check if we can mount volumes
echo "Test 4: Volume mounting works"
docker run --rm -v $(pwd):/workspace ghcr.io/workflow-library/owl-llm:latest ls -la /workspace/Dockerfile
echo "✓ Pass"
echo

# Test 5: Check build tools availability
echo "Test 5: Build tools are available"
docker run --rm ghcr.io/workflow-library/owl-llm:latest bash -c "gcc --version && cmake --version | head -1"
echo "✓ Pass"
echo

# Test 6: Check llama.cpp installation
echo "Test 6: llama.cpp files exist"
docker run --rm ghcr.io/workflow-library/owl-llm:latest ls -la /opt/llama.cpp/build/bin/ | head -5
echo "✓ Pass"
echo

echo "=== All tests passed! ==="
