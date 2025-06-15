#!/bin/bash
set -e

echo "Building llama.cpp Docker image..."
docker-compose build

echo "Build complete!"
echo ""
echo "To run llama.cpp directly:"
echo "  docker-compose run llama-cpp ./main -m /models/your-model.gguf -p 'Your prompt'"
echo ""
echo "To run with CWL:"
echo "  cwl-runner cwl/llama-cpp-tool.cwl examples/simple-prompt.yml"
