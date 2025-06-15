#!/bin/bash
set -e

# Check if model file is provided
if [ -z "$1" ]; then
    echo "Usage: ./run-example.sh <path-to-model.gguf>"
    echo "Example: ./run-example.sh models/llama-2-7b-chat.Q4_K_M.gguf"
    exit 1
fi

MODEL_PATH="$1"

# Check if model file exists
if [ ! -f "$MODEL_PATH" ]; then
    echo "Error: Model file not found: $MODEL_PATH"
    echo "Please download a GGUF model and place it in the models/ directory"
    exit 1
fi

# Build Docker image if not exists
if ! docker images | grep -q "owl-llm/llama-cpp"; then
    echo "Building Docker image..."
    ./build.sh
fi

echo "Running example with model: $MODEL_PATH"
echo ""

# Run simple inference
echo "1. Running simple inference..."
docker-compose run --rm llama-cpp ./main \
    -m "/models/$(basename $MODEL_PATH)" \
    -p "What is the capital of France?" \
    -n 50

echo ""
echo "2. To run with CWL, first update the model path in examples/simple-prompt.yml"
echo "   Then run: cwl-runner cwl/llama-cpp-tool.cwl examples/simple-prompt.yml"
