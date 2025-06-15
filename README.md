# owl-llm
LLM tools for container based workflows and prompt engineering

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) must be installed to build and run the container.
- [Common Workflow Language](https://www.commonwl.org/) (`cwltool` or `cwl-runner`) is required to execute the CWL workflows.

GGUF models used by `llama.cpp` should be placed in the `models/` directory at the repository root so they can be mounted into the container.

## Building the Docker image

Build the `llama.cpp` image once before running any examples:

```bash
./build.sh
# or
docker-compose build
```

## Command line usage

After installing the package you can run the bundled Docker setup using the `owl-llm` command:

```bash
owl-llm run models/your-model.gguf -p "What is the capital of France?"
```

This command executes the `llama.cpp` container with your model and prints the generated response.

## Running the example scripts

To try a local model quickly, use the helper script after building the image:

```bash
./run-example.sh models/llama-2-7b-chat.Q4_K_M.gguf
```

The script runs a short inference and prints the output. It will build the Docker image automatically if it does not exist.

## Running CWL workflows

Example CWL input files are provided in the `examples/` directory. After placing your model in `models/` and building the image, run them with `cwl-runner` (or `cwltool`):

```bash
cwl-runner cwl/llama-cpp-tool.cwl examples/simple-prompt.yml
cwl-runner cwl/conversation-workflow.cwl examples/conversation.yml
```

These workflows invoke the `llama.cpp` container to process the prompts defined in the YAML files.
